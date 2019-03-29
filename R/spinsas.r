spinsas <- function(sasfile, text=NULL, keep=FALSE, ...) {
    # stopifnot((length(sasfile)==1 && file.exists(sasfile))||length(text)==1)
    if (is.null(text)) {
        vtext <- readLines(sasfile, warn=FALSE)
    } else {
        vtext <- text
    }
    
    # reshape from R to SAS
    vtext <- unlist(strsplit(paste(vtext, collapse="\n"), ";\\n[[:blank:]]*"))
    
    # track and strip leading line breaks
    pre <- rep(0,length(vtext))
    while (any(br <- grepl(x=vtext, pattern="^[[:space:]]*\\n"))) {
        pre <- pre + br
        vtext <- sub(pattern="^[[:space:]]*\\n", replacement="", x=vtext)
    }
    
    docl <- grepl(pattern="^[[:space:]]*\\*\\* ", x=vtext)    # normal text lines
    chunkl <- grepl(pattern="^[[:space:]]*\\*\\+ ", x=vtext)  # chunk lines
    Rl <- grepl(pattern="^[[:space:]]*\\*R ", x=vtext)        # R code lines
    sasl <- !grepl(pattern="^[[:space:]]*\\*[*+R] ", x=vtext) # SAS code lines
    
    # Normal text (document)
    vtext <- sub("^[[:space:]]*\\*\\* ", "#' ", vtext)  # convert leading "** " to "#'"
    vtext[docl] <- gsub("\\n", "\\\n#' ", vtext[docl])  # mark new lines
    vtext[docl] <- sub(";$", "", vtext[docl])           # strip trailing ";"
    # Chunk header
    vtext <- sub("^[[:space:]]*\\*\\+ ", "#\\+ ", vtext)     # convert leading "*+" to "#+"
    vtext[chunkl] <- sub(";$", "", vtext[chunkl])       # strip trailing ";"
    vtext[chunkl] <- gsub("\\n", "", vtext[chunkl])     # strip internal \n
    vtext[chunkl] <- paste0(vtext[chunkl], "\n")        # ensure trailing \n
    # R code
    vtext[Rl] <- sub("^[[:space:]]*\\*R ", "", vtext[Rl])    # convert leading "*R" to " "
    vtext[Rl] <- sub(";$", "", vtext[Rl])               # strip trailing ";"
    # SAS code
    vtext[sasl] <- paste0(vtext[sasl], ";\n")
    
    # ensure chunk headers start on new lines
    vtext[(pre & chunkl)!=chunkl] <- paste0("\n", vtext[(pre & chunkl)!=chunkl])

    # restore leading line breaks
    lb <- vector("character", length=length(pre))
    while (any(pre>0)) {
        lb[pre>0] <- paste0(lb[pre>0], "\n")
        pre[pre>0] <- pre[pre>0]-1
    }
    vtext <- paste0(lb, vtext)
    
    # reshape from SAS to R
    vtext <- unlist(strsplit(paste(vtext, collapse=""), "\n"))
    
    if (is.null(text)) {
        rfile <- sub("[.]sas$", ".r", sasfile)
        
        writeLines(vtext, rfile)
        if (!keep)
            on.exit(unlink(rfile), add=TRUE)
        # knitr::spin(rfile, precious=keep, comment=c("^/[*][*]", "^.*[*]/[*] *$"), ...)
        spin_lang(rfile, precious=keep, comment=c("^/[*][*]", "^.*[*]/[*] *$"), language="sas", ...)
    } else {
        # return(knitr::spin(text=vtext, precious=keep, comment=c("^/[*][*]", "^.*[*]/[*] *$"), ...))
        return(spin_lang(text=vtext, precious=keep, comment=c("^/[*][*]", "^.*[*]/[*] *$"), language="sas", ...))
    }
    
}

# modified from knitr::spin() version 1.22

spin_lang = function(
    hair, knit = TRUE, report = TRUE, text = NULL, envir = parent.frame(),
    format = c('Rmd', 'Rnw', 'Rhtml', 'Rtex', 'Rrst'),
    doc = "^#+'[ ]?", inline = '^[{][{](.+)[}][}][ ]*$',
    comment = c("^[# ]*/[*]", "^.*[*]/ *$"), precious = !knit && is.null(text),
    language = "R"
) {
    
    format = match.arg(format)
    x = if (nosrc <- is.null(text)) xfun::read_utf8(hair) else split_lines(text)
    stopifnot(length(comment) == 2L)
    c1 = grep(comment[1], x); c2 = grep(comment[2], x)
    if (length(c1) != length(c2))
        stop('comments must be put in pairs of start and end delimiters')
    # remove comments
    if (length(c1)) x = x[-unique(unlist(mapply(seq, c1, c2, SIMPLIFY = FALSE)))]
    
    # remove multiline string literals and symbols (note that this ignores lines with spaces at their
    # beginnings, assuming doc and inline regex don't match these lines anyway)
    if (language == "R"){
        parsed_data = utils::getParseData(parse(text = x, keep.source = TRUE))
        is_matchable = seq_along(x) %in% unique(parsed_data[parsed_data$col1 == 1, 'line1'])
    }
    
    # .Rmd needs to be treated specially
    p = if (identical(tolower(format), 'rmd')) .fmt.rmd(x) else .fmt.pat[[tolower(format)]]
    
    # turn {{expr}} into inline expressions, e.g. `r expr` or \Sexpr{expr}
    if (language == "R") {
        if (any(i <- is_matchable & grepl(inline, x))) x[i] = gsub(inline, p[4], x[i])
        r = rle((is_matchable & grepl(doc, x)) | i)  # inline expressions are treated as doc instead of code
    } else {
        if (any(i <- grepl(inline, x))) x[i] = gsub(inline, p[4], x[i])
        r = rle((grepl(doc, x)) | i)  # inline expressions are treated as doc instead of code
    }
    
    n = length(r$lengths); txt = vector('list', n); idx = c(0L, cumsum(r$lengths))
    p1 = gsub('\\{', '\\\\{', paste0('^', p[1L], '.*', p[2L], '$'))
    
    for (i in seq_len(n)) {
        block = x[seq(idx[i] + 1L, idx[i + 1])]
        txt[[i]] = if (r$values[i]) {
            # normal text; just strip #'
            sub(doc, '', block)
        } else {
            # R code; #+/- indicates chunk options
            block = strip_white(block) # rm white lines in beginning and end
            if (!length(block)) next
            if (length(opt <- grep(rc <- '^(#|--)+(\\+|-| ----+| @knitr)', block))) {
                block[opt] = paste0(p[1L], gsub(paste0(rc, '\\s*|-*\\s*$'), '', block[opt]), p[2L])
                # close each chunk if there are multiple chunks in this block
                if (any(opt > 1)) {
                    j = opt[opt > 1]
                    block[j] = paste(p[3L], block[j], sep = '\n')
                }
            }
            if (!grepl(p1, block[1L])) {
                block = c(paste0(p[1L], p[2L]), block)
            }
            c('', block, p[3L], '')
        }
    }
    
    txt = unlist(txt)
    # make it a complete TeX document if document class not specified
    if (report && format %in% c('Rnw', 'Rtex') && !grepl('^\\s*\\\\documentclass', txt)) {
        txt = c('\\documentclass{article}', '\\begin{document}', txt, '\\end{document}')
    }
    if (nosrc) {
        outsrc = xfun::with_ext(hair, format)
        xfun::write_utf8(txt, outsrc)
        txt = NULL
    } else outsrc = NULL
    if (!knit) return(txt %n% outsrc)
    
    out = if (report) {
        if (format == 'Rmd') {
            knitr::knit2html(outsrc, text = txt, envir = envir)
        } else if (!is.null(outsrc) && (format %in% c('Rnw', 'Rtex'))) {
            knitr::knit2pdf(outsrc, envir = envir)
        }
    } else knitr::knit(outsrc, text = txt, envir = envir)
    
    if (!precious && !is.null(outsrc)) file.remove(outsrc)
    invisible(out)
}

.fmt.pat = list(
    rnw = c('<<', '>>=', '@', '\\\\Sexpr{\\1}'),
    rhtml = c('<!--begin.rcode ', '', 'end.rcode-->', '<!--rinline \\1 -->'),
    rtex = c('% begin.rcode ', '', '% end.rcode', '\\\\rinline{\\1}'),
    rrst = c('.. {r ', '}', '.. ..', ':r:`\\1`')
)

# determine how many backticks we need to wrap code blocks and inline code
.fmt.rmd = function(x) {
    x = paste(x, collapse = '\n')
    l = attr(gregexpr('`+', x)[[1]], 'match.length')
    l = max(l, 0)
    if (length(l) > 0) {
        i = spaces(l + 1, '`')
        b = spaces(max(l + 1, 3), '`')
    } else {
        i = '`'
        b = '```'
    }
    c(paste0(b, '{r '), '}', b, paste0(i, 'r \\1 ', i))
}

spin_child = function(input, format) {
    if (!isTRUE(getOption('knitr.in.progress')))
        return(sys.source(input, parent.frame()))
    fmt = if (missing(format)) {
        if (is.null(fmt <- out_format()))
            stop('spin_child() must be called in a knitting process')
        .spin.fmt = c(
            'latex' = 'Rnw', 'sweave' = 'Rnw', 'listings' = 'Rnw',
            'html' = 'Rhtml', 'markdown' = 'Rmd'
        )
        if (is.na(fmt <- .spin.fmt[fmt]))
            stop('the document format ', fmt, ' is not supported yet')
        fmt
    } else format
    knitr::asis_output(knitr::knit_child(
        text = spin_lang(text = readLines(input), knit = FALSE, report = FALSE, format = fmt),
        quiet = TRUE
    ))
}

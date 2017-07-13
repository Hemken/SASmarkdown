spinsas <- function(sasfile, keep=FALSE, ...) {
    stopifnot(length(sasfile)==1 && file.exists(sasfile))
    vtext <- readLines(sasfile, warn=FALSE)
    
    vtext <- unlist(strsplit(paste(vtext, collapse="\n"), ";"))
    
    pre <- rep(0,length(vtext))
    while (any(br <- grepl(x=vtext, pattern="^\\n"))) {
        pre <- pre + br
        vtext <- sub(pattern="^\\n", replacement="", x=vtext)
    }
    
    sasl <- !grepl(pattern="^\\*[*+R] ", x=vtext)
    
    vtext <- sub("^\\*\\* ", "#' ", vtext)     # convert leading "* " to "#'"
    docl <- grepl(pattern="^#'", x=vtext)   # normal text lines
    vtext[docl] <- gsub("\\n", "\\\n#' ", vtext[docl])     # mark new lines
    vtext[docl] <- sub(";$", "", vtext[docl])     # strip trailing ";"
    
    vtext <- sub("^\\*\\+ ", "#\\+ ", vtext)    # convert leading "*+" to "#+"
    chunkl <- grepl(pattern="^#\\+", x=vtext)   # chunk lines
    vtext[chunkl] <- sub(";$", "", vtext[chunkl])     # strip trailing ";"
    vtext[chunkl] <- gsub("\\n", "", vtext[chunkl])     # strip \n
    
    Rl <- grepl(pattern="^\\*R ", x=vtext)      # R code lines
    vtext[Rl] <- sub(";$", "", vtext[Rl])     # strip trailing ";"
    vtext[Rl] <- sub("^\\*R ", "", vtext[Rl])    # convert leading "*R" to " "
    
    vtext[sasl] <- paste0(vtext[sasl], ";")
    
    lb <- vector("character", length=length(pre))
    while (any(pre>0)) {
        lb[pre>0] <- paste0(lb[pre>0], "\n")
        pre[pre>0] <- pre[pre>0]-1
    }
    
    vtext <- paste0(lb, vtext)
    
    vtext <- unlist(strsplit(paste(vtext, collapse=""), "\n"))
    
    rfile <- sub("[.]sas$", ".r", sasfile)
    
    writeLines(vtext, rfile)
    if (!keep)
        on.exit(unlink(rfile), add=TRUE)
    knitr::spin(rfile, precious=keep, comment=c("^/[*][*]", "^.*[*]/[*] *$"), ...)
    
}

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
        knitr::spin(rfile, precious=keep, comment=c("^/[*][*]", "^.*[*]/[*] *$"), ...)
    } else {
        return(knitr::spin(text=vtext, precious=keep, comment=c("^/[*][*]", "^.*[*]/[*] *$"), ...))
    }
    
}

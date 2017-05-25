sashtmllog <- function (options) {

  code = {
    f <- basename(tempfile(pattern="sas", tmpdir=".", fileext=".sas"))
    listf <- sub("[.]sas$", ".lst", f)
    logf <- sub("[.]sas$", ".log", f)
    htmlf <- sub("[.]sas$", ".html", f)
    on.exit(unlink(c(htmlf, logf, listf, f)), add = TRUE)
    
    if (options$label != "") glabel <- paste("/imagename='", options$label, "'")
    if (length(grep("fig.path", options$params.src, fixed=TRUE))!=0) 
        gpath <- paste0(options$fig.path,"/") else gpath<-""
    
    odsinit <- c("ods noproctitle;",
                 "ods listing close;",
                 paste("ods graphics", glabel, ";"),
                 paste("ods html gpath='", gpath, "'", 
                       "file='", htmlf,
                       "' (no_top_matter no_bottom_matter) style=journal;"
                 )
    )
    writeLines(c("OPTIONS NONUMBER NODATE PAGESIZE = MAX FORMCHAR = '|----|+|---+=|-/<>*' FORMDLIM=' ';title;",
                 odsinit,
                 options$code), f)
    f
  }
  
  code = paste(code, options$engine.opts)
  cmd = options$engine.path
  out = if (options$eval) {
    message("running: ", cmd, " ", code)
    tryCatch(system2(cmd, code, stdout = TRUE, stderr = TRUE,
                     env = options$engine.env), error = function(e) {
                       if (!options$error)
                         stop(e)
                       paste("Error in running command", cmd)
                     })
  }
  else ""
  if (!options$error && !is.null(attr(out, "status")))
      stop(paste(out, collapse = "\n"))
  if (options$eval &&  file.exists(listf))
      out.listing <- c(readLines(listf), out)
  if (options$eval &&  file.exists(logf))
      out.log <- c(readLines(logf), out)
  if (options$eval &&  file.exists(htmlf))
      out.html <- c(readLines(htmlf), out)
  out.log <- out.log[-(1:grep("FORMDLIM", out.log))]
  out.log <- out.log[1:(grep("SAS Institute Inc.", out.log)-2)]
  out.log <- out.log[-(1:grep("NOTE: Writing HTML Body file: ", out.log))]
  
  return(sas_output(options, out.log, out.html))
}

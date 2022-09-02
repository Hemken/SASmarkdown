saspdf <- function (options) {
#  print(options)
  code <- {
    if (is.null(options$saveSAS) || options$saveSAS==FALSE) {
          f <- basename(tempfile(pattern="sas", tmpdir=".", fileext=".sas"))
      } else {
          f <- basename(paste0(options$label, ".sas"))
      }
    listf <- sub("[.]sas$", ".lst", f)
    logf <- sub("[.]sas$", ".log", f)
    texf <- sub("[.]sas$", ".tex", f)
    if (is.null(options$saveSAS) || options$saveSAS==FALSE) 
        on.exit(unlink(c(texf, logf, listf, f)), add = TRUE)
    
    if (options$label != "") 
        glabel <- options$label else
            glabel <- "sasplot.pdf"
    if (length(grep("fig.path", options$params.src, fixed=TRUE))!=0) 
      gpath <- paste0(options$fig.path,"/") else 
          gpath <- ""
    
    odsinit <- c("ods noproctitle;\n",
                 "ods listing close;\n",
                 paste0("ods tagsets.tablesonlylatex file='", texf,  "' (no_top_matter no_bottom_matter) style=journal;\n"),
                 paste0("ods graphics / imagename='", glabel, "' outputfmt=pdf;")
                 )
    
    writeLines(c(odsinit,
                 "OPTIONS NONUMBER NODATE PAGESIZE = MAX FORMCHAR = '|----|+|---+=|-/<>*' FORMDLIM=' ';title;",
                 options$code), f)
    f
  }
  
  if (is.list(options$engine.opts)) {
      code = paste(code, options$engine.opts[[options$engine]])
  } else { # backwards compatability
      code = paste(code, options$engine.opts)
  }
  if (is.list(options$engine.path)) {
      cmd = options$engine.path[[options$engine]]
  } else { # backwards compatability
      cmd = options$engine.path
  }
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
  # if (options$eval &&  file.exists(listf))
  #   out.listing <- c(readLines(listf), out)
  # if (options$eval &&  file.exists(logf))
  #   out.log <- c(readLines(logf), out)
  # if (options$eval &&  file.exists(texf))
  #     out.tex <- c(readLines(texf), out)
  if (is.null(options$encoding))
      enc <- "latin1" else enc <- options$encoding
  if (options$eval && file.exists(listf))
      out.listing = c(iconv(readLines(listf), from=enc, to="UTF-8"), out) else out.listing=""
  if (options$eval && file.exists(logf))
      out.log = c(iconv(readLines(logf), from=enc, to="UTF-8"), out)
  if (options$eval &&  file.exists(texf))
    out.tex <- c(iconv(readLines(texf), from=enc, to="UTF-8"), out)
 # out.log <- out.log[-(1:grep("FORMDLIM", out.log))]
 # out.log <- out.log[1:(grep("SAS Institute Inc.", out.log)-2)]
 # out.log <- out.log[-(1:grep("^NOTE: ([[:alpha:]]*) HTML5? Body", out.log))]
  formdelim <- grep("FORMDLIM", out.log)
  if (length(formdelim > 0)) {
      out.log <- out.log[-(1:formdelim)]           # trim log header
  }
  sasinit <- grep("NOTE: SAS initialization", out.log)
 if (length(sasinit > 0)) {
     out.log <- out.log[-(1:sasinit+2)]           # trim log header
 }
 autoexec <- grep("NOTE: AUTOEXEC processing completed.", out.log)
 if (length(autoexec > 0)) {
     out.log <- out.log[-(1:autoexec+1)]           # trim log header
 }
 sasinstitute <- grep("NOTE: SAS Institute Inc.", out.log)
 if (length(sasinstitute > 0)) {
     out.log <- try(out.log[1:(sasinstitute-2)], silent=TRUE) # trim log tail
 }
 # htmlbody <- grep("^NOTE: .* HTML5? Body", out.log)
 # if (length(htmlbody > 0)) {
 #     out.log <- try(out.log[-(1:htmlbody)], silent=TRUE) # trim HTML output note
 # }
 
 # if (is.null(options$saveSAS) || options$saveSAS==FALSE) 
 #     on.exit(unlink(paste0(glabel, ".pdf")), add = TRUE)
 
  if (options$engine == "saspdf" && is.null(attr(out, "status"))) {
      return(sas_output(options, options$code, out.tex))
  } else {
      return(sas_output(options, out.log, out.tex))
  }
}

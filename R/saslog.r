saslog <- function (options) {
    # print(str(options))
  code <- {
    if (is.null(options$saveSAS) || options$saveSAS==FALSE) {
        f <- basename(tempfile(pattern="sas", tmpdir=".", fileext=".sas"))
    } else {
        f <- basename(paste0(options$label, ".sas"))
    }
    writeLines(c("OPTIONS NONUMBER NODATE PAGESIZE = MAX FORMCHAR = '|----|+|---+=|-/<>*' FORMDLIM=' ';title;",
                 options$code), f)
    if (is.null(options$saveSAS)) 
        on.exit(unlink(f))
    listf = sub("[.]sas$", ".lst", f)
    logf = sub("[.]sas$", ".log", f)
    if (is.null(options$saveSAS) || options$saveSAS==FALSE) 
        on.exit(unlink(c(logf, listf, f)), add = TRUE)
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
  out <- if (options$eval) {
    message("running: ", cmd, " ", code)
    tryCatch(system2(cmd, code, stdout = TRUE, stderr = TRUE,
                     env = options$engine.env), error = function(e) {
                       if (!options$error)
                         stop(e)
                       paste("Error in running command", cmd)
                     })
  } else ""
  if (!options$error && !is.null(attr(out, "status")))
    stop(paste(out, collapse = "\n"))
  if (is.null(options$encoding))
      enc <- "latin1" else enc <- options$encoding
  if (options$eval && file.exists(listf))
    out.listing <- c(iconv(readLines(listf), from=enc, to="UTF-8"), out) else out.listing=""
  if (options$eval && file.exists(logf))
    out.log <- c(iconv(readLines(logf), from=enc, to="UTF-8"), out) else out.log <- ""
  if (options$eval && length(out.log > 0)) {
	sasinit <- grep("NOTE: SAS initialization", out.log)
	if (length(sasinit > 0)) {
	 out.log <- out.log[-(1:sasinit+2)]           # trim log header
	}
	autoexec <- grep("NOTE: AUTOEXEC processing completed.", out.log)
	if (length(autoexec > 0)) {
	 out.log <- out.log[-(1:autoexec+1)]           # trim log header
	}
	formdelim <- grep("FORMDLIM", out.log)
	if (length(formdelim > 0)) {
	 out.log <- out.log[-(1:formdelim)]           # trim log header
	}
	sasinstitute <- grep("NOTE: SAS Institute Inc.", out.log)
	if (length(sasinstitute > 0)) {
	 out.log <- try(out.log[1:(sasinstitute-2)], silent=TRUE) # trim log tail
	}
  }
  
  if (options$engine == "sas" && is.null(attr(out, "status"))) {
    return(sas_output(options, options$code, out.listing))
  } else {
    return(sas_output(options, out.log, out.listing))
  }
  
}

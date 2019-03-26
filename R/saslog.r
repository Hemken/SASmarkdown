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
  
  code = paste(code, options$engine.opts[[options$engine]])
  cmd = options$engine.path[[options$engine]]
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
  if (options$eval && file.exists(listf))
    out.listing = c(readLines(listf), out) else out.listing=""
  if (options$eval && file.exists(logf))
    out.log = c(readLines(logf), out)
  out.log <- out.log[-(1:grep("FORMDLIM", out.log))]
  out.log <- out.log[1:(grep("SAS Institute Inc.", out.log)-2)]
  
  if (options$engine == "sas" && is.null(attr(out, "status"))) {
    return(sas_output(options, options$code, out.listing))
  } else {
    return(sas_output(options, out.log, out.listing))
  }
  
}

saslog <- function (options) {
  code = {
    f = basename(tempfile(pattern="sas", tmpdir=".", fileext=".sas"))
    writeLines(c("OPTIONS NONUMBER NODATE PAGESIZE = MAX FORMCHAR = '|----|+|---+=|-/<>*' FORMDLIM=' ';title;",
                 options$code), f)
    on.exit(unlink(f))
    listf = sub("[.]sas$", ".lst", f)
    logf = sub("[.]sas$", ".log", f)
    on.exit(unlink(c(logf, listf, f)), add = TRUE)
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
    out.listing = c(readLines(listf), out) else out.listing=""
  if (options$eval &&  file.exists(logf))
    out.log = c(readLines(logf), out)
  out.log <- out.log[-(1:grep("FORMDLIM", out.log))]
  out.log <- out.log[1:(grep("SAS Institute Inc.", out.log)-2)]
  
  return(sas_output(options, out.log, out.listing))
}

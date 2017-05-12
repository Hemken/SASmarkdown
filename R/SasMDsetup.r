#require(knitr)
if (file.exists("C:/Program Files/SASHome/SASFoundation/9.4/sas.exe")) {
  saspath <- "C:/Program Files/SASHome/SASFoundation/9.4/sas.exe"
} else if (file.exists("D:/SASHome/SASFoundation/9.4/sas.exe")) {
  saspath <- "D:/SASHome/SASFoundation/9.4/sas.exe"
} else {
  saspath <- "sas"
}
sasopts <- "-nosplash -log 'z:' -print 'Z:' -ls 75"

knitr::knit_engines$set(saslog=function (options)
{
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
  #commandlines <- grep("^[[:digit:]]", out.log)
  #if (length(commandlines)>0) {out.log <- out.log[-commandlines]}
  
  engine_output(options, out.log, out.listing)
}
)

knitr::knit_engines$set(sashtml=function (options)
{
  #print(options)
  code <- {
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
  engine_output(options, options$code, out.html)
}
)

engine_output <- function (options, code, out, extra = NULL) 
{
  if (!is.logical(options$echo)) 
    code = code[options$echo]
  if (length(code) != 1L) 
    code = paste(code, collapse = "\n")
  if (options$engine == "sas" && 
      length(out) > 1L && 
      !grepl("[[:alnum:]]", out[2])) 
    out = tail(out, -3L)
  if (options$engine == "sashtml") {
    #print(sum(grepl("nbsp", out)))
    out <- gsub("&nbsp;", " ", out)
  }
  if (length(out) != 1L) 
    out = paste(out, collapse = "\n")
  out = sub("([^\n]+)$", "\\1\n", out)
  options$engine = switch(options$engine, mysql = "sql", node = "javascript", 
                          psql = "sql", Rscript = "r", options$engine)
  paste(c(if (length(options$echo) > 1L || options$echo) 
    (knitr::knit_hooks$get("source"))(code, options), 
    if (options$results != "hide" && !knitr:::is_blank(out)) {
      if (options$engine == "highlight") out else knitr:::wrap.character(out, options)
    }, extra), collapse = "\n")
}

knitr::knit_hooks$set(collectcode = function(before, options, envir) {
  if (!before) {
    if (options$engine %in% c("sas", "saslog", "sashtml")) {
      autoexec <- file("autoexec.sas", open="at")
      writeLines(options$code, autoexec)
      close(autoexec)
    }
  }
})

knitr::opts_chunk$set(engine="sas", engine.path=saspath, engine.opts=sasopts, comment="")

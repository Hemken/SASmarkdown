sas_output <- function (options, code, out, extra = NULL) 
{
  if (!is.logical(options$echo)) 
    code = code[options$echo]
  if (length(code) != 1L) 
    code = paste(code, collapse = "\n")
  if (options$engine %in% c("sas", "saslog") && 
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
  # options$engine = switch(options$engine, mysql = "sql", node = "javascript", 
  #                         psql = "sql", Rscript = "r", options$engine)
  paste(c(if (length(options$echo) > 1L || options$echo) 
    (knitr::knit_hooks$get("source"))(code, options), 
    if (options$results != "hide" && !knitr:::is_blank(out)) {
      if (options$engine == "highlight") out else knitr:::wrap.character(out, options)
    }, extra), collapse = "\n")
}

sas_output <- function (options, code, out, extra = NULL) 
{
  # print(out)
  if (options$engine == "saslog" &&
      length(out) > 1L &&
      !grepl("[[:alnum:]]", out[2]))
    out = tail(out, -3L)
  if (options$engine %in% c("sashtml", "sashtmllog")) {
    out <- gsub("&nbsp;", " ", out)
  }
  
  knitr::engine_output(options, code, out, extra)
}

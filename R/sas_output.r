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
  if (options$engine %in% c("saspdf", "saspdflog")) {
      out <- gsub("\\pagebreak", " ", out)
      sty <- readLines("sas.sty")
      sty2 <- sub("\\newcommand{\\color}[2][]{}", "", sty, fixed=TRUE)
      sty3 <- sub("\\newcommand{\\sascaption}[2][l]{\\marginpar[#1]{\\fbox{\\parbox{0.7in}{\\sasScaption{#2}}}}}",
                  "\\newcommand{\\sascaption}[2][l]{\\reversemarginpar{\\fbox{\\parbox{0.9in}{\\sasScaption{#2}}}}}",
                  sty2,
                  fixed=TRUE)
      writeLines(sty3, "sasmarkdown.sty")
  }
  
  knitr::engine_output(options, code, out, extra)
}

loghook <- function(x, options) {
    # print(grep("output", match.call()))
    # print(options$engine)
  if ((length(grep("output", match.call()))>=1 && options$engine=="R") ||
      (length(grep("source", match.call()))>=1 && options$engine=="saslog")) {
     # print("Using loghook")
    y <- strsplit(x, "\n")[[1]]
    # print(y)
        
    # Remove command echo in SAS log
    if (!is.null(options$SASecho) && options$SASecho==FALSE) {
        commandlines <- grep("^[[:digit:]]", y)
        if (length(commandlines)>0) {y <- y[-commandlines]}
    }
    # Remove all NOTES
    if (!is.null(options$SASnotes) && options$SASnotes==FALSE) {
        notelines <- grep("^NOTE:", y)
        if (length(notelines)>0) {y <- y[-notelines]}
    }
    # Remove processing times
    if (!is.null(options$SASproctime) && options$SASproctime==FALSE) {
        noteproc <- grep("^NOTE: PROCEDURE ", y)
        realtime <- grep("real time", y)
        cputime <- grep("cpu time", y)
        if (length(c(noteproc, realtime, cputime))>0) {
            y <- y[-c(noteproc, realtime, cputime)]
        }
    }
       
    # Ensure a trailing blank line
    if (length(y)>0 && y[length(y)] != "") { y <- c(y, "") }
    # Remove blank lines at the top of the SAS log
    firstline <- min(grep("[[:alnum:]]", y))
    if (firstline != Inf && firstline > 1) {y <- y[-(1:(firstline-1))]}
    # Now treat the result as regular output
    hook_orig(y, options)
  } else {
    hook_orig(x, options)
  }
}
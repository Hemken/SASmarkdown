find_sas <- function(message=TRUE) {
    versionlist <- c("8.0","8.1","8.2","9.0","9.1","9.1.3","9.2","9.2m2",
                     "9.3","9.3m2","9.4","9.4m1","9.4m2","9.4m3","9.4m4",
                     "9.4m5","9.4m6", "9.4m7")
    
  if (.Platform$OS.type == "windows"){
  sasexe <- NULL
  for (d in paste(c("C:/Program Files","C:/Program Files (x86)"),
                  "SASHome/SASFoundation", sep="/")) {
    if (dir.exists(d)) {
      for (v in versionlist) {
        dv <- paste(d,v, sep="/")
        if (dir.exists(dv)) {
          dvf <- paste(paste(dv, "sas", sep="/"), "exe", sep=".")
            if (file.exists(dvf)) {
              sasexe <- dvf
              if (message) message("SAS found at ", sasexe)
              break
            }
          }
        }
      }
  }
  
  if (is.null(sasexe)) {    
      # SAS is not found at default location in windows
      # Try to find it from PATH
      sasexe <- Sys.which("sas")
      attr(sasexe, "names") <- NULL    # remove attr so this is plain text
      if (nchar(sasexe) > 0) {
          if (message) message("SAS found at ", sasexe)
      } else {
          sasexe <- NULL    # change the 0-length `sasexe` back to `NULL`
      }
  }
  
} else if (Sys.info()["sysname"]=="Darwin") {
  sasexe <- NULL
  dv <- "/Applications/Sas/"
  if (dir.exists(dv)) {
    for (f in c("sas")) {
      dvf <- paste(paste(dv, f, sep="/"), "app", sep=".")
      if (file.exists(dvf)) {
        sasexe <- dvf
        if (message) message("SAS found at ", sasexe)
        break
      }
    }
  }
} else if (.Platform$OS.type == "unix") {
    # sasexe <- system2("which", "sas", stdout=TRUE)
    # if (message) message("SAS found at ", sasexe)
    sasexe <- Sys.which("sas")
    if (nchar(sasexe) > 0) {
        if (message) message("SAS found at ", sasexe)
        attr(sasexe, "names") <- NULL    # remove attr so this is plain text
    } else {
        sasexe <- NULL    # change the 0-length `sasexe` back to `NULL`
    }
    if (is.null(sasexe)){
        for (d in paste(c("/usr/local/sas","/software/sas"),
                        "SASFoundation", sep="/")) {
            if (dir.exists(d)) {
                for (v in versionlist) {
                    dv <- paste(d,v, sep="/")
                    if (dir.exists(dv)) {
                        dvf <- paste(dv, "sas", sep="/")
                        if (file.exists(dvf)) {
                            sasexe <- dvf
                            if (message) message("SAS found at ", sasexe)
                            break
                        }
                    }
                }
            }
        }
    }
    
} else {
    message("Unknown OS.\n Specify the location of your SAS executable.")
}
    if (is.null(sasexe)) {
        message("Specify the location of your SAS executable with `knitr::opts_chunk$set`.")
        message("In SAS, issue the command ` %put %sysget(SASROOT); ` to find this.")
    }
  return(sasexe)
}

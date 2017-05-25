.onLoad <- function (libname, pkgname) {
    packageStartupMessage("SASmarkdown loading ....\n")
    
    knitr::knit_engines$set(sashtml=sashtml, saslog=saslog, sashtmllog=sashtmllog)

    knitr::opts_hooks$set(results = function(options) {
        if (options$engine %in% c("sashtml", "sashtmllog") &&
            options$results != "hide") {
            options$results = "asis"
        }
            options
    })
    
    packageStartupMessage("saslog, sashtml, and sashtmllog engines")
    packageStartupMessage("   are now ready to use.")
}

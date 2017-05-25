.onLoad <- function (libname, pkgname) {
    packageStartupMessage("SASmarkdown loading ....\n")
    
    knitr::knit_engines$set(sashtml=sashtml, saslog=saslog)

    knitr::opts_hooks$set(results = function(options) {
        if (options$engine == "sashtml" &&
            options$results != "hide") {
            options$results = "asis"
        }
            options
    })
    
    packageStartupMessage("sashtml and saslog engines")
    packageStartupMessage("   are now ready to use.")
}

.onLoad <- function (libname, pkgname) {
    utils::globalVariables("hook_orig") # to suppress CHECK note
}

.onAttach <- function (libname, pkgname) {
    knitr::knit_engines$set(sas=saslog, saslog=saslog, 
                            sashtml=sashtml, sashtmllog=sashtml)

    knitr::opts_hooks$set(results = function(options) {
        if (options$engine %in% c("sashtml", "sashtmllog") &&
            options$results != "hide") {
            options$results = "asis"
        }
            options
    })
    
    sas_collectcode()
    # saslog_hookset()
    
    packageStartupMessage("sas, saslog, sashtml, and sashtmllog engines")
    packageStartupMessage("   are now ready to use.")
}

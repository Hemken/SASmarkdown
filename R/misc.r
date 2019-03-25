
.onLoad <- function (libname, pkgname) {
    utils::globalVariables(c("oautoexec","hook_orig")) # to suppress CHECK note
}

.onAttach <- function (libname, pkgname) {
    knitr::knit_engines$set(sas=saslog, saslog=saslog, 
                            sashtml=sashtml, sashtmllog=sashtml,
                            sashtml5=sashtml, sashtml5log=sashtml)

    knitr::opts_hooks$set(results = function(options) {
        if (options$engine %in% c("sashtml", "sashtmllog", "sashtml5", "sashtml5log") &&
            options$results != "hide") {
            options$results = "asis"
        }
            options
    })
    
    sas_collectcode()
    # saslog_hookset()
    
    packageStartupMessage("sas, saslog, sashtml, sashtml5, and sashtmllog & sashtml5log engines")
    packageStartupMessage("   are now ready to use.")
}

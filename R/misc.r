.onLoad <- function (libname, pkgname) {
    packageStartupMessage("SASmarkdown loading ....")
    
    knitr::knit_engines$set(sashtml=sashtml, saslog=saslog, sashtmllog=sashtmllog)

    knitr::opts_hooks$set(results = function(options) {
        if (options$engine %in% c("sashtml", "sashtmllog") &&
            options$results != "hide") {
            options$results = "asis"
        }
            options
    })
    
    # sas_collectcode()
    
    packageStartupMessage("saslog, sashtml, and sashtmllog engines")
    packageStartupMessage("   are now ready to use.")
}

is_blank <- function (x) 
{
    if (length(x)) 
        all(grepl("^\\s*$", x))
    else TRUE
}
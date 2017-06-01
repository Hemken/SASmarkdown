
.onLoad <- function (libname, pkgname) {
    utils::globalVariables("hook_orig") # to suppress CHECK note
}

.onAttach <- function (libname, pkgname) {
    knitr::knit_engines$set(sashtml=sashtml, saslog=saslog, sashtmllog=sashtml)

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

# Copied from "knitr" package, where it is unexported.
# is_blank <- function (x) 
# {
#     if (length(x)) 
#         all(grepl("^\\s*$", x))
#     else TRUE
# }
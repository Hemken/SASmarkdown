sas_enginesetup <- function (...) {
    # utils::globalVariables("hook_orig", "SASmarkdown")
    knitr::knit_engines$set(...)

    if (any(names(list(...)) == "sashtml")) {
        knitr::opts_hooks$set(results = function(options) {
            if (options$engine %in% c("sashtml", "sashtmllog", "sashtml5", "sashtml5log", "saspdf", "saspdflog") &&
                options$results != "hide") {
            options$results = "asis"
            }
            options
            })
    }
}
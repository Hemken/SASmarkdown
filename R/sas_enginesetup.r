sas_enginesetup <- function (...) {
    knitr::knit_engines$set(...)

    if (any(names(list(...)) == "sashtml")) {
        knitr::opts_hooks$set(results = function(options) {
            if (options$engine == "sashtml" &&
                options$results != "hide") {
            options$results = "asis"
            }
            options
            })
    }
}
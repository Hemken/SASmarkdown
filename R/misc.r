
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
    
    sasexe <- find_sas()
    if (!is.null(sasexe)) {
        knitr::opts_chunk$set(engine.path=list(sas=sasexe,
                    saslog=sasexe, sashtml=sasexe, sashtmllog=sasexe,
                    sashtml5=sasexe, sashtml5log=sasexe))
    }
    sasopts <- "-nosplash -ls 75"
    knitr::opts_chunk$set(engine.opts=list(sas=sasopts,
                    saslog=sasopts, sashtml=sasopts, sashtmllog=sasopts,
                    sashtml5=sasopts, sashtml5log=sasopts))
    knitr::opts_chunk$set(error=TRUE, comment=NA)
    
    
    packageStartupMessage("sas, saslog, sashtml, sashtml5, and sashtmllog & sashtml5log engines")
    packageStartupMessage("   are now ready to use.")
}

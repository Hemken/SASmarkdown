
.onLoad <- function (libname, pkgname) {
    utils::globalVariables(c("oautoexec","hook_orig")) # to suppress CHECK note
}

# .onUnload <- function(libpath) {
#     # remove("hook_orig", inherits=TRUE)
#     remove("oautoexec", inherits=TRUE)
# }

.onAttach <- function (libname, pkgname) {
    knitr::knit_engines$set(sas=saslog, saslog=saslog, 
                            sashtml=sashtml, sashtmllog=sashtml,
                            sashtml5=sashtml, sashtml5log=sashtml,
                            saspdf=saspdf, saspdflog=saspdf)

    knitr::opts_hooks$set(results = function(options) {
        if (options$engine %in% c("sashtml", "sashtmllog", "sashtml5", "sashtml5log", "saspdf", "saspdflog") &&
            options$results != "hide") {
            options$results = "asis"
        }
            options
    })
    
    knitr::opts_hooks$set(SASproctime = function(options) {
        engine <- options$engine
        sasopts <- paste(options$engine.opts[[engine]], "-nostimer")
        options$engine.opts[[engine]] <- sasopts
        options
    })
    
    knitr::opts_hooks$set(SASecho = function(options) {
        engine <- options$engine
        sasopts <- paste(options$engine.opts[[engine]], "-nosource")
        options$engine.opts[[engine]] <- sasopts
        options
    })
    
    knitr::opts_hooks$set(SASnotes = function(options) {
        engine <- options$engine
        sasopts <- paste(options$engine.opts[[engine]], "-nonotes")
        options$engine.opts[[engine]] <- sasopts
        options
    })
    
    sas_collectcode()
    saslog_hookset()
    
    sasexe <- find_sas()
    if (!is.null(sasexe)) {
        knitr::opts_chunk$set(engine.path=list(sas=sasexe,
                    saslog=sasexe, sashtml=sasexe, sashtmllog=sasexe,
                    sashtml5=sasexe, sashtml5log=sasexe,
                    saspdf=sasexe, saspdflog=sasexe))
    } else {
         packageStartupMessage("The SAS executable was not found.", call.=FALSE)
    }
    
    if (.Platform$OS.type=="windows") {
        sasopts <- "-nosplash -ls 75"
    } else if (.Platform$OS.type=="unix") {
        sasopts <- "-nonews -ls 75"
    }
    knitr::opts_chunk$set(engine.opts=list(sas=sasopts,
                    saslog=sasopts, sashtml=sasopts, sashtmllog=sasopts,
                    sashtml5=sasopts, sashtml5log=sasopts,
                    saspdf=sasopts, saspdflog=sasopts))
    knitr::opts_chunk$set(error=TRUE, comment=NA)
    
    
    packageStartupMessage("SAS engines are now ready to use.")
}

sas_collectcode <- function() {
    if (file.exists("autoexec.sas")) {
        assign("oautoexec", readLines("autoexec.sas"), pos=2)
        message("Found an existing 'autoexec.sas'.")
    } else {
        oautoexec <- NULL
    }
    
knitr::knit_hooks$set(collectcode = function(before, options, envir) {
    if (!before) {
        if (options$engine %in% c("sas", "saslog", 
                                  "sashtml", "sashtmllog", 
                                  "sashtml5", "sashtml5log",
                                  "saspdf", "saspdflog")) {
            autoexec <- file("autoexec.sas", open="at")
            writeLines(options$code, autoexec)
            close(autoexec)
            # print(sys.calls())
            # print(sys.frames())
        if (utils::packageVersion('knitr') < '1.45') {
            do.call("on.exit",
                    list(quote(unlink("autoexec.sas")), add=TRUE),
                    envir = sys.frame(-9))
        } else if (utils::packageVersion('knitr') >= '1.45') {
            do.call("on.exit",
                    list(quote(unlink("autoexec.sas")), add=TRUE),
                    envir = sys.frame(-10))
            # sys.frame(1) or sys.frame(-11) is rmarkdown::render()
            # sys.frame(2) or sys.frame(-10) is knitr::knit()
        }

        if (!is.null(oautoexec)) {
            do.call("on.exit",
                list(quote(writeLines(oautoexec, "autoexec.sas")), add=TRUE),
                envir = sys.frame(-9))
        }
        }
    }
})
}
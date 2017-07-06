sas_collectcode <- function() {
    if (file.exists("autoexec.sas")) {
        stop("You must remove or rename an existing 'autoexec.sas'.")
    }
knitr::knit_hooks$set(collectcode = function(before, options, envir) {
    if (!before) {
        if (options$engine %in% c("sas", "saslog", "sashtml", "sashtmllog")) {
            autoexec <- file("autoexec.sas", open="at")
            writeLines(options$code, autoexec)
            close(autoexec)
            #print(sys.frames())
            #print(sys.calls())
        do.call("on.exit", 
            list(quote(unlink("autoexec.sas")), add=TRUE),
            envir = sys.frame(-9)) 
            # sys.frame(1) or sys.frame(-10) is rmarkdown::render()
            # sys.frame(-9) is knitr::knit()
        }
    }
})
}
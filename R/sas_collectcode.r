sas_collectcode <- function() {
knitr::knit_hooks$set(collectcode = function(before, options, envir) {
    if (!before) {
        if (options$engine %in% c("sas", "saslog", "sashtml", "sashtmllog")) {
            autoexec <- file("autoexec.sas", open="at")
            writeLines(options$code, autoexec)
            close(autoexec)
            # print(sys.frames())
            # print(sys.calls())
        do.call("on.exit", 
            list(quote(unlink("autoexec.sas")), add=TRUE),
            envir = sys.frame(1))
        }
    }
})
}
sas_collectcode <- function() {
knitr::knit_hooks$set(collectcode = function(before, options, envir) {
    if (!before) {
        if (options$engine %in% c("sas", "saslog", "sashtml")) {
            autoexec <- file("autoexec.sas", open="at")
            writeLines(options$code, autoexec)
            close(autoexec)
        }
    }
})
}
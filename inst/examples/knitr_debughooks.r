knitr_debughooks <- function() {
    knitr::knit_hooks$set(ls_start = function(before, options, envir) {
        if (before) {
            if (options$engine %in% c("sas", "saslog", "sashtml", "sashtmllog")) {
                print("Inside ls_start()")
                print(envir)
                print(str(options))
                }
        }
    })

    knitr::knit_hooks$set(ls_end = function(before, options, envir) {
        if (!before) {
            if (options$engine %in% c("sas", "saslog", "sashtml", "sashtmllog")) {
                print("Inside ls_end()")
                print(envir)
                print(str(options))
            }
        }
    })
    
    knitr::knit_hooks$set(ls_parent = function(before, options, envir) {
        if (!before) {
            if (options$engine %in% c("sas", "saslog", "sashtml", "sashtmllog")) {
                print("Inside ls_parent()")
                # print(sys.frames())
                # print(sys.calls())
                print(sys.call(1)) # rmarkdown
                # print(ls(sys.frame(1)))
                print(sys.call(2)) # knit
                # print(ls(sys.frame(2))) # "output"
                # print(str(get("output", sys.frame(2)))) # output file name
                # print(sys.call(7)) # call_block
                # print(ls(sys.frame(7))) # ??
                # print(str(get("o", sys.frame(7)))) # hook name
                print(sys.call(8)) # block_exec
                print(ls(sys.frame(8))) # "output"
                print(str(get("output", sys.frame(8)))) # source & output
                # print(sys.call(9)) # run_hooks
                # print(ls(sys.frame(9))) # "out"
                # print(str(get("out", sys.frame(9)))) # NULL
                
                # print(search()) # global env and packages
                # print(ls(pos=1)) # R_Globalenv
                # print(ls(pos=2)) # SASmarkdown package
                # print(ls(pos=3)) # stats package
                # print(ls(pos=-1)) # local
                
                # print(str(options))
            }
        }
    })
    
}
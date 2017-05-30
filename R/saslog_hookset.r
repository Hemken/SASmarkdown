saslog_hookset <- function (hooktype="source") {
    if (hooktype == "source"){
        assign("hook_orig", knitr::knit_hooks$get("source"), pos=parent.frame())
        # hook_orig <<- knitr::knit_hooks$get("source")
        knitr::knit_hooks$set(source = SASmarkdown::sasloghook)
    } else if(hooktype == "output") {
        assign("hook_orig", knitr::knit_hooks$get("output"), pos=parent.frame())
        # hook_orig <<- knitr::knit_hooks$get("output")
        knitr::knit_hooks$set(output = SASmarkdown::sasloghook)
    }
}
library(knitr)
# How some of these might look at a call in the global environment

(f <- system.file("vignettes", "basicuse.rmd", package = "SASmarkdown"))
knit(f, output="BasicUse.html")  # compile to html

(f <- system.file("vignettes", "collectcode.rmd", package = "SASmarkdown"))
knit(f, output="CollectCode.html")

(f <- system.file("vignettes", "SASloghooks.rmd", package = "SASmarkdown"))
knit(f, output="SASloghooks.html")

(f <- system.file("vignettes", "SASerrors.rmd", package = "SASmarkdown"))
knit(f, output="SASerrors.html")

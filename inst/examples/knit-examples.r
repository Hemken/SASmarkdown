library(knitr)
# (f <- system.file("examples", "basicuse.rmd", package = "SASmarkdown"))
# knit(f, output="BasicUse.html")  # compile to html

(f <- system.file("examples", "collectcode.rmd", package = "SASmarkdown"))
knit(f, output="CollectCode.html")  # compile to html

# (f <- system.file("examples", "SASloghooks.rmd", package = "SASmarkdown"))
# knit(f, output="SASloghooks.html")  # compile to html

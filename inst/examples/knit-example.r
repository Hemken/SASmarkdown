library(knitr)
(f <- system.file("examples", "basicuse.rmd", package = "SASmarkdown"))
knit(f, output="U:/BasicUse.html")  # compile to html

(f <- system.file("examples", "SASloghooktest.rmd", package = "SASmarkdown"))
knit(f, output="U:/SASloghooktest.html")  # compile to html

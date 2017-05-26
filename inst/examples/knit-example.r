library(knitr)
(f <- system.file("basicuse.rmd", package = "SASmarkdown"))
knit(f, output="U:/BasicUse.html")  # compile to html

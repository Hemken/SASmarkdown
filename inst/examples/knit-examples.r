library(knitr)
# How some of these might look at a call in the global environment

(f <- system.file("examples", "basicuse.rmd", package = "SASmarkdown"))
knit(f, output="vignettes/BasicUse.md")  # compile to markdown
file.rename("vignettes/BasicUse.md", "vignettes/BasicUse.rmd")

(f <- system.file("examples", "collectcode.rmd", package = "SASmarkdown"))
knit(f, output="vignettes/CollectCode.md")
file.rename("vignettes/CollectCode.md", "vignettes/CollectCode.rmd")

(f <- system.file("examples", "SASloghooks.rmd", package = "SASmarkdown"))
knit(f, output="vignettes/SASloghooks.md")
file.rename("vignettes/SASloghooks.md", "vignettes/SASloghooks.rmd")

(f <- system.file("examples", "SASerrors.rmd", package = "SASmarkdown"))
knit(f, output="vignettes/SASerrors.md")
file.rename("vignettes/SASerrors.md", "vignettes/SASerrors.rmd")

library(rmarkdown)

try(detach("package:SASmarkdown", unload=TRUE))
render("tests/vignettes/basicuse.rmd", github_document(preserve_yaml=TRUE, html_preview=FALSE))

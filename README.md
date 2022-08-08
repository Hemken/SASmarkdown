# SASmarkdown
This is a collection of R functions that extends knitr's capability 
for using SAS as a language engine.  They have no use if you do not 
also have SAS installed.

You can install these as an R package:
```
install.packages("SASmarkdown")
# or use
devtools::install_github("Hemken/SASmarkdown")
# devtools::install_github("Hemken/SASmarkdown", build_vignettes = TRUE)    # build vignettes locally
```
Then you can check with
```
library(SASmarkdown)
help(package="SASmarkdown")
```
If the package was installed, you should see an R Help page.  Vignettes
on using the package may be found from `help(package="SASmarkdown")`.

If you would like to contribute to this project, please "fork" it on Github.  Or, just email me directly.

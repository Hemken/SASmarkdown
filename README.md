# SASmarkdown
This is a collection of R functions that extends knitr's capability 
for using SAS as a language engine.  They have no use if you do not 
also have SAS installed.

You can install these as an R package:
```
devtools::install_github("Hemken/SASmarkdown")
```
Then you can check with
```
library(SASmarkdown)
help(package="SASmarkdown")
```
If the package was installed, you should see an R Help page.  Vignettes
on using the package may be found from `help(package="SASmarkdown")`.

If you would like to contribute to this project, please "fork" it on Github and then clone it back to your working environment.  Make your changes and enhancements, push them back to your Github repository, then initiate a "pull" request.

While this procedure may seem overly elaborate, this allows us each to keep the parts we like, even if we should disagree!  (I’ve been really happy about this at least twice, as the forking user.)
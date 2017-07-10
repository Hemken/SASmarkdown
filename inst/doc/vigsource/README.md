# Rebuilding the SASmarkdown vignettes

To run these vignettes individually, change the output type
in the YAML header to \"html_document\" (instead of \"html_vignette\").

These vignettes are not fully integrated into the R help system.
In particular, you cannot find them through the 
`vignette(package="SASmarkdown")` function, only by clicking through
the `help(package="SASmarkdown")` documentation.

CRAN\'s computers do not have SAS installed, so they cannot build
the vignettes from their markdown sources.  Instead the package
is built from static HTML pages.  There is some irony here in
building a package for more literate programming from less literate
sources!

Be that as it may, if **you** have SAS installed (and why would you
have downloaded this package if you don\'t?), then **you** can 
build better vignettes.

Unpack the package tarball, or download the source code from
[github/Hemken](https://github.com/Hemken/SASmarkdown).

Move the Rmarkdown (rmd) files from this folder (/doc/vigsource)
to a new folder in the root of the package, /vignettes.  Also move
the DESCRIPTION file from this folder to the root of the package
(replacing the existing DESCRIPTION file),
probably updating the version and date information.

Finally, use your favorite build method to rebuild SASmarkdown from
your modified source files.
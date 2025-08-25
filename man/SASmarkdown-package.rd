\docType{package}
\name{SASmarkdown-package}
\alias{SASmarkdown-package}
\alias{SASmarkdown}

\title{Settings and functions to extend the knitr SAS engine.}

\description{
Using the "sas" language engine provided in \code{knitr} has a number of limitations.
Each SAS code chunk is run as a separate batch file, and only the source
code and the listing output are returned to the document being knit.

The functions in this package set up additional variations on the SAS
language engine, enabling ODS HTML, HTML5, and LaTeX output to be returned to the
document, as well as enabling SAS log output to be returned.  These
language engines are automatically created when the package is loaded.

When used with chunk option \code{error=TRUE}, the user can see some
SAS errors automatically included in their document.

Another function here sets up a chunk hook, that repeats selected 
code chunks
at the beginning of later code chunks.  This allows
the code in one chunk to use the results of a previous chunk.  See
\code{\link{sas_collectcode}}.

Another function sets up source hooks, allowing the user to suppress
parts of the SAS log.  See \code{\link{saslog_hookset}}.

The function \code{spinsas} processes SAS command files that
include markup within SAS comments.  See \code{\link{spinsas}}.
}
\references{
More documentation and examples: 
\url{https://www.ssc.wisc.edu/~hemken/SASworkshops/sas.html#writing-sas-documentation}
}
\seealso{
The package that this extends: \code{\link[knitr:knitr-package]{knitr-package}}.
}
\author{
Doug Hemken
}
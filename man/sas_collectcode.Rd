\name{sas_collectcode}
\alias{sas_collectcode}
\title{
A function to create a knitr chunk hook for accumlating code.
}
\description{
This wrapper function calls \code{knitr::knit_hooks$set()} to
define a chunk hook.  When the chunk hook is later invoked, this
writes the contents of the current chunk to the end of a SAS
\code{autoexec.sas} file.

This may be used with any of the SAS language engines:  "sas",
"sashtml", "saslog",  or "sashtmllog".
}
\usage{
sas_collectcode()
}
\details{
When knitr calls SAS, each code chunk is processed as a separate
SAS batch job.  Where code in one chunk depends upon the results
from a prevous chunk, code needs to be repeated and re-evaluated.

This function creates a knitr chunk hook that signals when one
chunk's code should be saved for re-use later.  The code ends up
in a temporary SAS \code{autoexec.sas} file.

}
\note{
If there is already an \file{autoexec.sas} in the directory where
the document source is located, you will not be allowed to set
this hook - remove or rename \file{autoexec.sas}.
}
\value{
There are no return values, chunk hook creation is a side effect here..
}
\author{
Doug Hemken
}
\seealso{
\code{\link{sas_enginesetup}}
}
\examples{
\dontrun{
# In a first code chunk do
```{r}
require(SASmarkdown)
sas_collectcode()

sasexe <- "C:/Program Files/SASHome/SASFoundation/9.4/sas.exe"
sasopts <- "-nosplash -ls 75"
```
# Then mark SAS code chunks with
```{r, engine="sas", engine.path=sasexe, engine.opts=sasopts, collectcode=TRUE}
# SAS code here
```

# A later chunk that depends on the first.
```{r, engine="sas", engine.path=sasexe, engine.opts=sasopts}
# dependent SAS code here
```
}
}

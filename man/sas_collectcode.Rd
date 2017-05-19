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
"sashtmlengine", or "saslogengine".
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
in a SAS \code{autoexec.sas} file.

Note you usually want to remove the \code{autoexec.sas} file later,
if you have actually invoked \code{collectcode}.
}
\value{
There are no return values, chunk hook creation is a side effect here..
}
\author{
Doug Hemken
}
\seealso{
\code{\link{sashtmlengine}},

\code{\link{saslogengine}}
}
\examples{
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
# etc etc.

# At the end of a document, cleanup
```{r}
unlink("autoexec.sas")
```
}

\name{sas_collectcode}
\alias{sas_collectcode}
\title{
Create a knitr chunk hook for accumlating code.
}
\description{
This wrapper function calls \code{knitr::knit_hooks$set()} to
define a chunk hook.  When the chunk hook is later invoked, this
writes the contents of the current chunk to the end of a SAS
\code{autoexec.sas} file.

This may be used with any of the SAS language engines.
}
\usage{
sas_collectcode()
}
\details{
This function is automatically invoked when the SASmarkdown
library is attached.  Normally a user will not need to call
this function, instead using \code{collectcode=TRUE} as a 
chunk option - see the example below.

When knitr calls SAS, each code chunk is processed as a separate
SAS batch job.  Where code in one chunk depends upon the results
from a prevous chunk, code needs to be repeated and re-evaluated.

This function creates a knitr chunk hook that signals when one
chunk's code should be saved for re-use later.  The code ends up
in a temporary SAS \code{autoexec.sas} file.

}
\note{
If there is already an \file{autoexec.sas} in the directory where
the source document is located, collected code will be added to it,
and the original file will be restored after your document is processed.
}
\value{
There are no return values, chunk hook creation is a side effect here.
}
\author{
Doug Hemken
}
\seealso{
\code{\link{SASmarkdown-package}}
}
\examples{
sas_collectcode()

\dontrun{
indoc <- '
---
title: "Basic SASmarkdown Doc"
author: "Doug Hemken"
output: html_document
---
# In a first code chunk, set up with
```{r}
library(SASmarkdown)
```

# Then mark SAS code chunks with collectcode=TRUE
```{sas, collectcode=TRUE}
data class;
    set sashelp.class;
    keep age;
    run;
```

# A later chunk that depends on the first.
```{sas}
proc means data=class; /* not SASHELP.class */
run;
```
'
knitr::knit(text=indoc, output="test.md")
rmarkdown::render("test.md")
}
}

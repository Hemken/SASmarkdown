\name{find_sas}
\alias{find_sas}
\title{
A helper function that seeks to locate your SAS executable.
}
\description{
This function searches for recent versions of SAS (>= SAS 8),
in some of the usual default installation locations.

This function is automatically invoked when the SASmarkdown
library is attached - normally a user will not need to call
this function.

In the event SAS is not found, you will have to specify the
correct location yourself.

}
\usage{
find_sas(message=TRUE)
}
\arguments{
\item{message}{(logical) Whether or not to print a message
when SAS is found.}
}
\value{
A character string with the path and name of the SAS executable.
}
\author{
Doug Hemken
}
\seealso{
\code{\link{SASmarkdown-package}}
}
\examples{
indoc <- '
---
title: "Basic SASmarkdown Doc"
author: "Doug Hemken"
output: html_document
---
# An R console example
## In a first code chunk, set up with
```{r}
library(SASmarkdown)
```
## Then mark SAS code chunks with
```{sas}
data class;
  set sashelp.class;
  bmi = 703*weight/height**2;
  run;
  
proc means;
  var bmi;
  run;
```
Some more document text here.
'

if (!is.null(SASmarkdown::find_sas())) {
  # To run this example, remove tempdir().
  fmd <- file.path(tempdir(), "test.md")
  fhtml <- file.path(tempdir(), "test.html")

  knitr::knit(text=indoc, output=fmd)
  rmarkdown::render(fmd, "html_document", fhtml)
}

}

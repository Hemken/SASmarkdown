\name{sas_output}
\alias{sas_output}
\alias{hook_orig}
\title{
A function to provide cleaner output for knitr's SAS engines.
}
\description{
When knitr calls SAS to produce various forms of output, that output
is often more cluttered than what you want to show in your SAS 
markdown documentation.

This function filters the output returned by SAS prior to invoking
knitr's \code{engine_output()} function.
}
\usage{
sas_output(options, code, out, extra = NULL)
}
\arguments{
\item{options}{options object passed from a SAS engine.}
\item{code}{code object passed from a SAS engine.}
\item{out}{out object passed from a SAS engine.}
\item{extra}{anything else to add to the document.}.
}

\details{
This redefinition adds a filter to the standard \code{engine_output()}.
At present, the same filtering is used for both SAS ODS
and SAS listing output.  
In the future more choice and nuance could be added here.  
The user should not need to invoke this directly.
}
\value{
This returns a call to \code{knitr::engine_output}.
}
\author{
Doug Hemken
}
\seealso{
\code{\link{SASmarkdown}},

}
\examples{
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
# Then set up SAS code chunks with
```{sas}
proc means data=sashelp.class;
run;
```
'
if (!is.null(SASmarkdown::find_sas())) {
  # To run this example, remove tempdir().
  fmd <- file.path(tempdir(), "test.md")
  fhtml <- file.path(tempdir(), "test.html")

  knitr::knit(text=indoc, output=fmd)
  rmarkdown::render(fmd, "html_document", fhtml)
}
}
}
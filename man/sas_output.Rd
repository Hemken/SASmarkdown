\name{sas_output}
\alias{sas_output}
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
sasexe <- find_sas()
sasopts <- "-nosplash -ls 75"
knitr::opts_chunk$set(engine.path=list(sas=sasexe, saslog=sasexe),
  engine.opts=list(sas=sasopts, saslog=sasopts),
  error=TRUE, comment=NA)
```

# Then set up SAS code chunks with
```{sashtml}
proc means data=sashelp.class;
run;
```
'
knitr::knit(text=indoc, output="test.md")
rmarkdown::render("test.md")
}
}

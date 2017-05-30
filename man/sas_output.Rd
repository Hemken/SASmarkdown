\name{sas_output}
\alias{sas_output}
\title{
A function to provide cleaner output for knitr's SAS engines.
}
\description{
When knitr calls SAS to produce various forms of output, that output
is often more cluttered than what you want to show in your SAS 
markdown documentation.

This function redefines knitr's \code{engine_output()} function to filter out
the clutter.
}
\usage{
sas_output(options, code, out, extra = NULL)
}
\arguments{
\item{options}{options object passed from a sas engine.}
\item{code}{code object passed from a sas engine.}
\item{out}{out object passed from a sas engine.}
\item{extra}{anything else to add to the document.}.
}

\details{
This redefinition adds a filter to the standard \code{engine_output()}.
At present, the same filtering can be used for both SAS ODS
and SAS log output.  If I do more development, I would add more choice
and nuance here.  The user should not need to invoke this directly.
}
\value{
This returns text to insert in a document, like \code{knitr::engine_output} does.
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
require(SASmarkdown)
sas_enginesetup(sashtml=sashtml)

sasexe <- "C:/Program Files/SASHome/SASFoundation/9.4/sas.exe"
sasopts <- "-nosplash -ls 75"
```
# Then set up SAS code chunks with
```{r, engine="sashtml", engine.path=sasexe, engine.opts=sasopts}
proc means data=sashelp.class;
run;
```
'
knitr::knit(text=indoc, output="test.md")
rmarkdown::render("test.md")
}
}

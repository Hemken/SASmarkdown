\name{sas_enginesetup}
\alias{sas_enginesetup}
\alias{sashtml}
\alias{saslog}
\alias{sashtmllog}
\title{Create SAS engines for knitr}
\description{
In addition to knitr's built in SAS engine, this function creates
additional engines for SAS.  Once created, these engines may be
invoked like any other knitr engine to generate different forms of
SAS output.

Set up once per session (i.e. document).  Ordinarily this is run
automatically when \code{SASmarkdown} is loaded.
}
\usage{
sas_enginesetup(...)

sashtml(options)
saslog(options)
}
\arguments{
\item{...}{arguments to be passed to \code{knit_engines$set(...)}.  
These take the form \code{enginename=enginefunction}}
\item{options}{\code{options} are passed to the engine 
functions when they
are actually invoked within \code{knitr}.}
}

\details{
This is a convenience function that uses
\code{knit_engines$set()}
to define knitr language engines.

\code{sas_enginesetup(...)} passes it's arguments to \code{knit_engines$set()}
in the form of \code{enginename=enginefunction} pairs.  Two pre-defined
engine functions are in this package:  \code{sashtml}
and \code{saslog}.
These functions are used as follows.

\itemize{
\item{
\code{sas_enginesetup(sashtml=sashtml)}
creates a language engine that returns SAS html output
using SAS's ODS system.  The engine created is called "sashtml".  An additional
side effect is that the html results are used "asis" - you can hide them or
you can use them as is.}
\item{
\code{sas_enginesetup(saslog=saslog)}
creates a language engine that returns SAS log output instead
of the plain code that is usually echoed, as well as listing output.  The engine
created is called "saslog".}
\item{
\code{sas_enginesetup(sashtmllog=sashtml)}
creates a language engine that returns SAS log output instead
of the plain code that is usually echoed, as well as html output.  The engine
created is called "sashtmllog".}
}
The end user should not need to use the language engine 
functions directly.  These are the
workhorse functions that actually call SAS and return output.  Their main use
is when set up within \code{sas_enginesetup(sashtml=sashtml)}
}

\value{
There are no return values for \code{sas_enginesetup}, engine creation is a side effect here.

The individual language engine functions return SAS code 
and SAS output internally to \code{knitr}.

}
\author{
Doug Hemken
}

\seealso{
\code{\link{knit_engines}}
}
\examples{
sas_enginesetup(sashtml=sashtml, saslog=saslog)

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
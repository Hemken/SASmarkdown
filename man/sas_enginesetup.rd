\name{sas_enginesetup}
\alias{sas_enginesetup}
\alias{sashtmlengine}
\alias{saslogengine}
\title{Create SAS engines for knitr}
\description{
In addition to knitr's built in SAS engine, this function creates
additional engines for SAS.  Once created, these engines may be
invoked like any other knitr engine to generate different forms of
SAS output.

Set up once per session (i.e. document).
}
\usage{
sas_enginesetup(...)

sashtmlengine() # deprecated for sas_enginesetup(sashtml=sashtml)

saslogengine() # deprecated for sas_enginesetup(saslog=saslog)
}
\arguments{
\item{...}{arguments to be passed to \code{knit_engines$set(...)}.  
These take the form
\code{enginename=enginefunction}}
}

\details{
These are convenience functions that use
\code{knit_engines$set()}
to define knitr language engines.

\code{sas_enginesetup(...)} passes it's arguments to \code{knit_engines$set()}
in the form of \code{enginename=enginefunction} pairs.  Two pre-defined
engine functions are in this package:  \code{sashtml} and \code{saslog}.
these functions are used as follows.

\code{sas_enginesetup(sashtml=sashtml)}
creates a language engine that returns SAS html output
using SAS's ODS system.  The engine created is called "sashtml".  An additional
side effect is that the html results are used "asis" - you can hide them or
you can use them as is.

\code{sas_enginesetup(saslog=saslog)}
creates a language engine that returns SAS log output instead
of the code that is usually echoed, as well as listing output.  The engine
created is called "saslog"
}
\value{
There are no return values, engine creation is a side effect here.
}
\author{
Doug Hemken
}

\seealso{
\code{\link{knit_engines}}
}
\examples{
\dontrun{
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
}
}
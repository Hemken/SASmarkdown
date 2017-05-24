\name{sasloghook}
\alias{sasloghook}
\title{A function to clean SAS log files}
\description{
This function is mainly intended as a "hook" for knitr.  It can serve
as a "source" hook to clean up SAS logs for the \code{saslog} engine,
or as an "output" hook to clean up SAS logs written to files and read
in using R code.

Used once per hook type per session (i.e. document), during set up.
}
\usage{
loghook(x, options)
}

\arguments{
\item{options}{\code{options} are passed to these functions when they
are actually invoked within \code{knitr}.}
\item{x}{The log text which is to be cleaned up}
}

\details{
The end user should not need to use this function directly.  This is a
workhorse function used to process selected log output.  The main use
is when set up within \code{knit_hooks$set(source=loghook)}
}
\value{
This return SAS log output internally to \code{knitr}.
}
\author{
Doug Hemken
}

\seealso{
\code{\link{knit_hooks}}

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
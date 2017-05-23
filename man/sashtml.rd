\name{sashtml}
\alias{sashtml}
\alias{saslog}
\title{SAS engines for knitr}
\description{
In addition to knitr's built in SAS engine, these functions are two
additional engines for SAS.  Once set up, these engines may be
invoked like any other knitr engine to generate different forms of
SAS output.

Used once per session (i.e. document) during set up.
}
\usage{
sashtml(options)
saslog(options)
}

\arguments{
\item{options}{\code{options} are passed to these functions when they
are actually invoked within \code{knitr}.}
}

\details{
The end user should not need to use the functions directly.  These are the
workhorse functions that actually call SAS and return output.  Their main use
is when set up within \code{sas_enginesetup(sashtml=sashtml)}
}
\value{
These return SAS code and SAS output internally to \code{knitr}.
}
\author{
Doug Hemken
}

\seealso{
\code{\link{sas_enginesetup}}

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
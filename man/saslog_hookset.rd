\name{saslog_hookset}
\alias{saslog_hookset}
\alias{sasloghook}
\title{A function to clean SAS log files}
\description{
The main function here is \code{saslog_hookset}, which sets
"hooks" for knitr.  It can set
a "source" hook to clean up SAS logs for the \code{saslog} engine,
or set an "output" hook to clean up SAS logs written to 
files and read in using R code.

Used once per hook type per session (i.e. document), during set up.
}
\usage{
saslog_hookset(hooktype)

sasloghook(x, options)
}

\arguments{
\item{hooktype}{Declare which type of hook to set, "source" (the
default) or "output".}

\item{options}{\code{options} are passed to these functions when they
are actually invoked within \code{knitr}.}
\item{x}{The log text which is to be cleaned up}
}

\details{
The main function is used with either "source" or "output" as 
the value of \code{hooktype}.

The end user should not need to use \code{sasloghook} directly.  
This is a
workhorse function used to process selected log output.  The main use
is when set up within \code{knit_hooks$set(source=sasloghook)}

Once this hook is set, the user may then set any chunk options

\itemize{
  \item{SASproctime}
  \item{SASecho}
  \item{SASnotes}
}

to FALSE to suppress that part of the SAS log.
}
\value{
\code{saslog_hookset} is used for it's side effect of resetting
a knitr hook.

\code{sasloghook} returns SAS log output internally to \code{knitr}.
}
\author{
Doug Hemken
}

\seealso{
\code{\link{knit_hooks}}

}
\examples{
# saslog_hookset() # called during loading

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
```{saslog, SASecho=FALSE}
proc means data=sashelp.class;
run;
```
'
knitr::knit(text=indoc, output="test.md")
rmarkdown::render("test.md")
}
}

\name{sasengine_output}
\alias{sasengine_output}
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
engine_output <- sasengine_output()
}
\details{
This redefinition adds a filter to the standard \code{engine_output()}.
At this early stage, the same filtering can be used for both SAS ODS
and SAS log output.  If I do more development, I would add more choice
and nuance here.

Note you can always invoke the original engine_output() function by
copying it from knitr to your global environment.
}
\value{
This returns a function, which *must* be named \code{engine_output}.
}
\author{
Doug Hemken
}
\seealso{
\code{\link{sashtmlengine}},

\code{\link{saslogengine}}
}
\examples{
\dontrun{
# In a first code chunk do
```{r}
require(SASmarkdown)
sashtmlengine()
saslogengine()
engine_output <- sasengine_output()

sasexe <- "C:/Program Files/SASHome/SASFoundation/9.4/sas.exe"
sasopts <- "-nosplash -ls 75"
```
# Then set up SAS code chunks with
```{r, engine="sashtml", engine.path=sasexe, engine.opts=sasopts}
# SAS code here
```
}
}

\name{spinsas}
\alias{spinsas}
\title{
Convert a specially marked up SAS file to Markdown and HTML.
}
\description{
This function takes a SAS file containing special mark up in
it's comments, and converts it to
Markdown and HTML documents (or one of several other formats).
}
\usage{
spinsas(sasfile, keep=FALSE, ...)
}
\arguments{
\item{sasfile}{A character string with the name of a SAS
command file, containing markup in it's comments.}
\item{keep}{Whether to save intermediate files.}
\item{...}{options passed to \code{knitr::spin}}
}

\details{
This function takes a SAS file containing special mark up in
it's comments, and converts it into knitr's "spin" format. 
This is in turn sent to \code{knitr::spin}, and converted to
Markdown and HTML (or one of several other formats).

Special Markup:
\itemize{
\item{\code{"** "} - Begin document text}
\item{\code{"*+ "} - Begin chunk header}
\item{\code{"*R "} - Begin a chunk of R code}
\item{\code{"*/* "} - Dropped from document, ends with
\code{"*/*"}}
}

Each document element - document text, chunk headers,
R code chunks, and SAS code chunks - ends with a
semicolon at the end of a line.

}
\value{
The path to the output file.
}
\author{
Doug Hemken
}
\seealso{
\code{\link{SASmarkdown-package}}
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
sas_collectcode()

sasexe <- "C:/Program Files/SASHome/SASFoundation/9.4/sas.exe"
sasopts <- "-nosplash -ls 75"
```
# Then mark SAS code chunks with
```{r, engine="sas", engine.path=sasexe, engine.opts=sasopts, collectcode=TRUE}
data class;
    set sashelp.class;
    keep age;
    run;
```

'
spinsas(text=indoc)
}
}

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
spinsas(sasfile, text=NULL, keep=FALSE, ...)
}
\arguments{
\item{sasfile}{A character string with the name of a SAS
command file, containing markup in it's comments.}
\item{text}{A character string in place of a file.}
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

If given text instead of a file, the compiled document as a
character string.
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
** # Native SASmarkdown
First, call the `SASmarkdown`` package in R.;

*R require(SASmarkdown);

** Then execute some SAS code.  First specify the
chunk header, then the code.;
*+ example, engine="sas",
    engine.path="C:/Program Files/SASHome/SASFoundation/9.4/sas.exe",
    engine.opts="-nosplash -ls 75";
proc means data=sashelp.class;
run;
'
x<-spinsas(text=indoc)
writeLines(x, "indoc.html")
}
}

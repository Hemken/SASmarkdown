## ----backtick, echo=FALSE, results="hide"--------------------------------
backtick <- "`"

## ----setup, message=FALSE------------------------------------------------
require(SASmarkdown)
if (file.exists("C:/Program Files/SASHome/SASFoundation/9.4/sas.exe")) {
  saspath <- "C:/Program Files/SASHome/SASFoundation/9.4/sas.exe"
} else {
  saspath <- "sas"
}
sasopts <- "-nosplash -ls 75"

sas_collectcode()


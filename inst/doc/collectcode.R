## ----setup, message=FALSE------------------------------------------------
require(SASmarkdown)
sas_collectcode()

if (file.exists("C:/Program Files/SASHome/SASFoundation/9.4/sas.exe")) {
  saspath <- "C:/Program Files/SASHome/SASFoundation/9.4/sas.exe"
} else if (file.exists("D:/SASHome/SASFoundation/9.4/sas.exe")) {
  saspath <- "D:/SASHome/SASFoundation/9.4/sas.exe"
} else {
  saspath <- "sas"
}

sasopts <- "-nosplash -ls 75"



#require(knitr)
if (file.exists("C:/Program Files/SASHome/SASFoundation/9.4/sas.exe")) {
  saspath <- "C:/Program Files/SASHome/SASFoundation/9.4/sas.exe"
} else if (file.exists("D:/SASHome/SASFoundation/9.4/sas.exe")) {
  saspath <- "D:/SASHome/SASFoundation/9.4/sas.exe"
} else {
  saspath <- "sas"
}

sasopts <- "-nosplash -log 'z:' -print 'Z:' -ls 75"

knitr::opts_chunk$set(engine="sas", engine.path=saspath, engine.opts=sasopts, comment="")

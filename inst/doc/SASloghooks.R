## ----backtick, echo=FALSE, results="hide"--------------------------------
backtick <- "`"

## ----setup, echo=FALSE, message=FALSE------------------------------------
require(SASmarkdown)
if (file.exists("C:/Program Files/SASHome/SASFoundation/9.4/sas.exe")) {
  saspath <- "C:/Program Files/SASHome/SASFoundation/9.4/sas.exe"
} else {
  saspath <- "sas"
}
sasopts <- "-nosplash -ls 75"
knitr::opts_chunk$set(engine.path=saspath, engine.opts=sasopts, comment="")

## ----sourcehook----------------------------------------------------------
require(SASmarkdown) # if not invoked previously
saslog_hookset("source")

## ----sourcetest1---------------------------------------------------------
runif(5)

## ----outputhook, echo=TRUE-----------------------------------------------
knitr::knit_hooks$set(source=hook_orig) # just for this example

saslog_hookset("output")

## ----readlog-------------------------------------------------------------
cat(readLines("saslog.log"), sep="\n")

## ----readlog, SASproctime=FALSE, echo=FALSE------------------------------
cat(readLines("saslog.log"), sep="\n")

## ----readlog, SASecho=FALSE, echo=FALSE----------------------------------
cat(readLines("saslog.log"), sep="\n")

## ----readlog, SASnotes=FALSE, echo=FALSE---------------------------------
cat(readLines("saslog.log"), sep="\n")

## ----cleanuplog----------------------------------------------------------
# Do not forget to remove the log file when you are done!
unlink("saslog.log")


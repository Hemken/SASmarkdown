library(rmarkdown)

try(detach("package:SASmarkdown", unload=TRUE))
# render("tests/vignettes/basicuse.rmd", github_document(preserve_yaml=TRUE, html_preview=FALSE))
render("vignettes/basicuse.rmd", output_format=html_vignette(),
       output_file="1_Basic_Use_of_SASmarkdown.html", output_dir="inst/doc")
render("vignettes/collectcode.rmd", output_format=html_vignette(),
       output_file="2_Linking_SAS_Code_Chunks.html", output_dir="inst/doc")
render("vignettes/SASloghooks.rmd", output_format=html_vignette(),
       output_file="3_Cleaning_Up_SAS_Logs.html", output_dir="inst/doc")
render("vignettes/saserrors.rmd", output_format=html_vignette(),
       output_file="4_SAS_Errors.html", output_dir="inst/doc")
render("vignettes/saveSASfiles.rmd", output_format=html_vignette(),
       output_file="5_Saving_Intermediate_SAS_Files.html", output_dir="inst/doc")

render("vignettes/spinSASmarkdown.rmd", output_format=html_vignette(),
       output_file="7_Spinning_SASmarkdown.html", output_dir="inst/doc")

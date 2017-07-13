** This is a special SAS script which can be used to generate a report.
  You can write normal text in command-style comments.

### Special Markup

- "** ", a double asterisk, signals the beginning of document text.  End with a semi-colon.
- "*+ ", an asterisk-plus, signals the beginning of a code chunk, and
specifies the code chunk options.  End with a semi-colon.
- "*R ", an asterisk-R, signals the enclosed code is in R.  End with a semi-colon.

  In order to run SAS code, first we specify a path for SAS and set up some options in R.
  ;
*+ setup, message=FALSE ;

*R 
# An R comment
require(SASmarkdown)
if (file.exists('C:/Program Files/SASHome/SASFoundation/9.4/sas.exe')) {
saspath <- 'C:/Program Files/SASHome/SASFoundation/9.4/sas.exe'
} else {
saspath <- 'sas'
}
sasopts <- '-nosplash -ls 75'
;


** The report begins here.;

*+  example1, engine='sas', engine.path=saspath, engine.opts=sasopts, 
comment='';

* A SAS comment;
proc means data=sashelp.class /*(keep = age)*/;
run;

/* lines here are
ignored by SAS, and also by spinsas,
i.e. they do not show up in your document
*/
;

** You can use the ***usual*** Markdown.;
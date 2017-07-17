** This is a special SAS script which can be used to generate a report.
  You can write normal text in command-style comments.

### Special Markup

- "** ", a double asterisk, signals the beginning of document text.  
End with a semi-colon, ";" at the end of a line.
- "*+ ", an asterisk-plus, signals the beginning of a code chunk, and
specifies the code chunk options.  End with a semi-colon.
- "*R ", an asterisk-R, signals the enclosed code is in R.  End with a semi-colon.
- "/** ", comments to "spin" begin with slash-double-asterisk.
These do not show up in your document.  End with "*/*" at
the end of a line.

### Semi-colons

- No semi-colons ***at the ends of lines*** in your document text.
- Your chunk of SAS code must end with a semi-colon (not a block comment).


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
comment=NA;

* A SAS comment;
proc means data=sashelp.class /*(keep = age)*/;
run;

/* lines here are
ignored by SAS.  If at the end of
your SAS code chunk they must be followed by a semi-colon.
*/
;

** You can use the ***usual*** Markdown.;
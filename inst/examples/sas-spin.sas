* This is a special SAS script which can be used to generate a report.;
* You can write normal text in command-style comments.;
* ;
* First we specify a path for SAS and set up some options.;
*+ setup, message=FALSE ;
*R require(SASmarkdown);
*R if (file.exists('C:/Program Files/SASHome/SASFoundation/9.4/sas.exe')) {;
*R saspath <- 'C:/Program Files/SASHome/SASFoundation/9.4/sas.exe';
*R } else {;
*R saspath <- 'sas';
*R };
*R sasopts <- '-nosplash -ls 75';
* The report begins here.;

*+  example1, engine='sas', engine.path=saspath, engine.opts=sasopts, comment='';

proc means data=sashelp.class (keep = age);
run;

* You can use the ***usual*** Markdown.;
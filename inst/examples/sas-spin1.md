This is a special SAS script which can be used to generate a report.
  You can write normal text in command-style comments.

  First we specify a path for SAS and set up some options.
  


```r
require(SASmarkdown)
if (file.exists('C:/Program Files/SASHome/SASFoundation/9.4/sas.exe')) {
saspath <- 'C:/Program Files/SASHome/SASFoundation/9.4/sas.exe'
} else {
saspath <- 'sas'
}
sasopts <- '-nosplash -ls 75'
```

The report begins here.


```sas
proc means data=sashelp.class (keep = age);
run;
```

```
                            The MEANS Procedure

                         Analysis Variable : Age 
 
     N            Mean         Std Dev         Minimum         Maximum
    ------------------------------------------------------------------
    19      13.3157895       1.4926722      11.0000000      16.0000000
    ------------------------------------------------------------------
```

You can use the ***usual*** Markdown.

x <- c("abc", "abd", "abe", "bcf")
grepl(pattern="^a", x) # string begin with "a"
grepl(pattern="[ce]", x) # strings contain either "c" or "e"
grepl(pattern="[ce]$", x) # strings end in "c" or "e"
grepl(pattern="^a[ce]", x) # strings end in "c" or "e"

x <- c("/*", "*/", "* ", "** ", "*+ ", "*R ")
grepl(pattern="^\\*", x) # strings begin with an asterisk, "*"
grepl(pattern="^\\* ", x) # strings begin with an asterisk-space, "* "
grepl(pattern="^\\*[*] ", x) # strings begin with double asterisk, "**"
grepl(pattern="^\\*[\\*] ", x) # strings begin with double asterisk, "**"
grepl(pattern="^\\*[\\*+] ", x) # strings begin with double asterisk or asterisk-plus, "**" or "*+"
grepl(pattern="^\\*[*+R] ", x) # 
grepl(pattern="^/[*]", x) # strings begin with a slash-asterisk, "/*"
grepl(pattern="^.*[*]/ *$", x) # strings end with a asterisk-slash, "*/"

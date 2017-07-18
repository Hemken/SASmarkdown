x <- c("abc", "abd", "abe", "bcf")
grepl(pattern="^a", x) # string begin with "a"
grepl(pattern="[ce]", x) # strings contain either "c" or "e"
grepl(pattern="[ce]$", x) # strings end in "c" or "e"
grepl(pattern="^a[ce]", x) # strings end in "c" or "e"

x <- c("/*", "*/", "* ", "** ", "*+ ", "*R ")
grepl(pattern="^\\*", x) # strings begin with an asterisk, "*"
# all but the first
grepl(pattern="^\\* ", x) # strings begin with an asterisk-space, "* "
# only the third one
grepl(pattern="^\\*[*] ", x) # strings begin with double asterisk, "**"
# only the fourth one
grepl(pattern="^\\*[\\*] ", x) # strings begin with double asterisk, "**"
# only the fourth one
grepl(pattern="^\\*[\\*+] ", x) # strings begin with double asterisk or asterisk-plus, "**" or "*+"
# fourth and fifth
grepl(pattern="^\\*[*+R] ", x) # any of **, *+, *R
# fourth, fifth, and sixth
grepl(pattern="^/[*]", x) # strings begin with a slash-asterisk, "/*"
# first only
grepl(pattern="^.*[*]/ *$", x) # strings end with a asterisk-slash, "*/"
# second only

x <- c(";", "anything;", "; ", ";\\n ", "\\;")
grepl(pattern=";", x)
# all
grepl(pattern=";$", x)
# first, second, fifth
grepl(pattern=";[[:blank:]]*$", x)
# all but fourth
grepl(pattern="^.*[\\];[[:blank:]]*$", x)
# only fifth
grepl(pattern="^.*[^\\]*;[[:blank:]]*$", x)
# all but the fourth
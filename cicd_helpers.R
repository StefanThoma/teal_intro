library(spelling)
words <- spelling::spell_check_files(list.files()[endsWith(list.files(), "md")], ignore = read.csv("inst/WORDLIST")[[1]])

library(tidyverse)
map(list.files()[endsWith(list.files(), "md")], lintr::lint)
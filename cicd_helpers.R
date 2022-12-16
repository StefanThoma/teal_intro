library(spelling)
spelling::spell_check_files(list.files()[endsWith(list.files(), "md")])
library(tidyverse)
map(list.files()[endsWith(list.files(), "md")], lintr::lint)




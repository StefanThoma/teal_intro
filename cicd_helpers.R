library(spelling)
spelling::spell_check_files(list.files()[endsWith(list.files(), "md")])

devtools::install_github("r-lib/covr")


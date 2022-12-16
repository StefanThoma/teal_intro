#' ---
#' output:
#'   reprex::reprex_document:
#'     std_out_err: TRUE
#' ---

library(teal.data)
library(tidyverse)

ADSL <- random.cdisc.data::cadsl

file_example <- tempfile(fileext = ".R")
writeLines(
  text = c(
    "ADSL <- ADSL %>%
      dplyr::mutate(newdata = 1)"
  ),
  con = file_example
)





## works with cdisc_dataset:
cdisc_dataset_ADSL <-
  cdisc_dataset(dataname = "ADSL", x = ADSL)

cdisc_dataset_mutated <- cdisc_dataset_ADSL %>%
  mutate_dataset(script = file_example)
get_raw_data(cdisc_dataset_mutated)$newdata[1]


## does not work with cdisc_data:

cdisc_data_ADSL <-
  cdisc_data(cdisc_dataset(dataname = "ADSL", x = ADSL))

cdisc_data_mutated <- cdisc_data_ADSL %>%
  mutate_dataset(
    script = file_example,
    dataname = "ADSL"
  )
get_raw_data(cdisc_data_mutated)$ADSL$newdata[1]

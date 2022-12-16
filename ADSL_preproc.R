ADSL <- ADSL %>%
  dplyr::mutate(AGEGR = if_else(AGE < 40, 0, 1, NA_real_))

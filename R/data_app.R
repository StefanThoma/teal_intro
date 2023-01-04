# data app
## ---- load packages data app ----
library(random.cdisc.data) # this package provides the data used
library(teal.data)
library(scda)
library(teal.modules.general)
library(sparkline)
library(teal)
library(tidyverse)

## ---- parameter data app ----
# metadata
author <- "Stefan Thoma"
molecule <- "hexadromedar"

# parameters
demographic_variables <- c("SEX", "AGE", "RACE")
arm_variable <- "ARM"

## ---- load data data app ----
ADSL <- random.cdisc.data::cadsl
ADAE <- random.cdisc.data::cadae
ADTTE <- random.cdisc.data::cadtte


modules(
  tm_front_page(
    label = "Study Information",
    header_text = c("Info about data source" = "Random data are used that have been created with the 'scda' R package"),
    tables = list(`NEST packages used` = data.frame(Packages = c("teal.modules.general", "teal.modules.clinical", "scda", "scda.2021")))
  ),
  tm_data_table("Data Table"),
  tm_variable_browser("Variable Browser"),
  tm_t_summary(
    label = "Demographic Table",
    dataname = "ADSL",
    arm_var = amr_variable,
    summarize_vars = choices_selected(
      choices = variable_choices(ADSL, demographic_variables),
      selected = c("SEX", "AGE", "RACE")
    )
  )


## ---- init data app ----
app <- teal::init(
  data = cdisc_data(
    cdisc_dataset("ADSL", ADSL) %>%
      mutate_dataset(script = "ADSL_preproc.R"),
    cdisc_dataset("ADAE", ADAE),
    cdisc_dataset("ADTTE", ADTTE)
  ),
  modules = modules(
    tm_front_page(
      label = "Study Information",
      header_text = 
        c("Info about data source" = "Random data are used that have been created with the 'scda' R package"),
      tables = 
        list("NEST packages used" = 
               data.frame(Packages = 
                            c("teal.modules.general", "teal.modules.clinical", "scda", "scda.2021")))),
    tm_data_table("Data Table"),
    tm_variable_browser("Variable Browser"),
    tm_t_summary(
      label = "Demographic Table",
      dataname = "ADSL",
      arm_var = cs_arm_var,
      summarize_vars = choices_selected(
        choices = variable_choices(ADSL, demog_vars_asl),
        selected = c("SEX", "AGE", "RACE")
      )
    )),
  header = "My first application",
  footer = "footer"
)


## ---- run data app ----
shinyApp(app$ui, app$server)

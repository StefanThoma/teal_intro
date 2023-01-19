# data app
## ---- load packages data app ----
library(random.cdisc.data) # this package provides the data used
library(teal.data)
library(scda)
library(teal.modules.general)
library(teal.modules.clinical)
library(sparkline)
library(teal)
library(tidyverse)


## ---- load data data app ----
ADSL <- random.cdisc.data::cadsl
ADAE <- random.cdisc.data::cadae
ADTTE <- random.cdisc.data::cadtte

## ---- parameter data app ----
# metadata
author <- "Stefan Thoma"
molecule <- "hexadromedar"

# parameters
demographic_variables <- c("SEX", "AGE", "RACE")
arm_vars <- "ARM"

cs_arm_var <- choices_selected(
  choices = variable_choices(ADSL, subset = arm_vars),
  selected = "ARM"
)

package_table <- tibble(
  package = .packages(),
  version = sapply(
    X = .packages(),
    FUN = function(x) as.character(packageVersion(x))
  )
)
# any other tables you want to include.
color_table <- tibble(
  color = c("green", "red"),
  meaning = c("ready", "not ready")
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
        list(
          "packages used" = package_table,
          "color table" = color_table
        ),
      additional_tags = tagList(tags$div(
        class = "header", checked = NA,
        tags$p("Ready to take the Shiny tutorial? If so"),
        tags$a(href = "https://docs.posit.co/resources/shiny/", "Click Here!")
      )),
      show_metadata = TRUE
    ),
    tm_data_table("Data Table"),
    tm_variable_browser("Variable Browser"),
    tm_t_summary(
      label = "Demographic Table",
      dataname = "ADSL",
      arm_var = cs_arm_var,
      summarize_vars = choices_selected(
        choices = variable_choices(ADSL, demographic_variables),
        selected = c("SEX", "AGE", "RACE")
      )
    )
  ),
  header = "My first application",
  footer = "footer"
)


## ---- run data app ----
shinyApp(app$ui, app$server)

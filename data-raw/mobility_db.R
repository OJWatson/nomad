## code to prepare `mobility_db` dataset
library(readr)
library(dplyr)

base_mobility_db <- as_tibble(read_csv(
  "data-raw/mobility_db.csv",
  show_col_types = FALSE
))

facebook_mobility_db <- as_tibble(read_csv(
  "data-raw/facebook_mobility_db.csv",
  show_col_types = FALSE
))

mobility_db <- bind_rows(base_mobility_db, facebook_mobility_db) %>%
  distinct(.data$name, .keep_all = TRUE)

# Prediction periods describe the target matrix, not the collection interval.
units <- read.csv("data-raw/distance_units.csv")
model_data <- new.env()
load("data/model_db.rda", envir = model_data)
fitted <- vapply(model_data$model_db, function(x) x$get_data_name(), character(1))
stopifnot(all(fitted %in% mobility_db$name))
mobility_db$has_fitted_models <- mobility_db$name %in% fitted
mobility_db$prediction_period_days <- ifelse(grepl("_fb_2025$", mobility_db$name), 21, NA_real_)
mobility_db$distance_unit <- units$distance_unit[match(mobility_db$name, units$name)]
mobility_db$distance_unit[mobility_db$name == "zmb_cdr_2020"] <- "m"
mobility_db$distance_unit[mobility_db$name == "zmb_fb_2020"] <- "km"
mobility_db$provenance <- ifelse(
  grepl("_fb_2025$", mobility_db$name),
  "JHU-supplied fits; recipe: data-raw/functions/facebook_models.R",
  ifelse(mobility_db$has_fitted_models,
         paste0("Fitting recipe: data-raw/models/", mobility_db$name, "/", mobility_db$name, ".R"),
         NA_character_)
)
usethis::use_data(mobility_db, overwrite = TRUE)

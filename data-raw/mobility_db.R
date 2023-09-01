## code to prepare `mobility_db` dataset
library(readr)
library(dplyr)

mobility_db <- as_tibble(read_csv(
  "data-raw/mobility_db.csv",
  show_col_types = FALSE
))

usethis::use_data(mobility_db, overwrite = TRUE)

#' Clean print information on a mobility dataset
#' @noRd
print_mobility_data <- function(data_name) {

  m <- which(nomad::mobility_db$name == data_name)

  cat(paste(
    crayon::yellow$bold(
      names(rename_mobility_db()[m, ])
    ),
    vapply(nomad::mobility_db[m, ], as.character, character(1)),
    sep = ": ",
    collapse = "\n"
  ))

}

#' Clean print information on a mobility model
#' @noRd
print_nomad_model <- function(x) {

  mod <- x$get_model(hydrate = FALSE)

  # Get the hierarchical first
  hierarchical <- model_hierarchical_string(mod)

  # create long sub type description
  # Get the name of the nomad model
  st <- model_sub_types()
  model_type <- names(st)[match(mod$type, st)]

  # build model description df
  df <- data.frame(mobility_model = mod$model,
                   model_type = model_type,
                   hierarchical = hierarchical)

  # nice plot
  cat(paste(
    crayon::yellow$bold(
      names(df)
    ),
    df[1, , drop = FALSE],
    sep = ": ",
    collapse = "\n"
  ))

}

#' Rename mobility db with nice names
#' @noRd
rename_mobility_db <- function() {
  nomad::mobility_db %>%
    dplyr::rename(Name = "name") %>%
    dplyr::rename(Data = "type") %>%
    dplyr::rename(ISO3C = "country") %>%
    dplyr::rename(N = "n") %>%
    dplyr::rename(Scheme = "sampling_scheme") %>%
    dplyr::rename(Censoring = "censoring") %>%
    dplyr::rename(Aggregation = "aggregation") %>%
    dplyr::rename(URL = "publication") %>%
    dplyr::rename(Start = "date_start") %>%
    dplyr::rename(End = "date_end")
}

#' @noRd
model_types <- function() {

  c(
    "grav" = "gravity",
    "rad" = "radiation",
    "dd" = "departure-diffusion"
  )
}

#' @noRd
model_sub_types <- function() {

  c("basic" = "basic",
    "transport" = "transport",
    "power law" = "power",
    "exponential" = "exp",
    "normalised power law" = "power_norm",
    "normalised exponential" = "exp_norm",
    "scaled power law" = "scaled_power",
    "finite" = "finite",
    "radiation" = "radiation")

}

#' @noRd
model_hierarchical_string <- function(model) {

  # Get if hierarchical
  hierarchical <- ""
  if (model$model == "departure-diffusion") {
    if (model$hierarchical) {
      hierarchical <- "hierarchical"
    }
  }
  hierarchical
}

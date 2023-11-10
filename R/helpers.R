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

#' Rename mobility db with nice names
#' @noRd
rename_mobility_db <- function() {
  mobility_db %>%
    rename(Name = name) %>%
    rename(Data = type) %>%
    rename(ISO3C = country) %>%
    rename(N = n) %>%
    rename(Scheme = sampling_scheme) %>%
    rename(Censoring = censoring) %>%
    rename(Space = aggregation) %>%
    rename(URL = publication) %>%
    rename(Start = date_start) %>%
    rename(End = date_end)
}

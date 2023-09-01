#' Clean print information on a mobility dataset
#' @noRd
print_mobility_data <- function(data_name) {

  m <- which(nomad::mobility_db$name == data_name)
  message(paste(
    names(nomad::mobility_db[m, ]),
    nomad::mobility_db[m, ],
    sep = ": ",
    collapse = "\n"
  ))

}

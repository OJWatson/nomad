#' @noRd
nomad_warn <- function(message, class) {
  cli::cli_warn(message, class = c(class, "nomad_warning"))
}

#' @noRd
nomad_inform <- function(message, class = "nomad_message") {
  cli::cli_inform(message, class = class)
}

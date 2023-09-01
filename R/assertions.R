#------------------------------------------------
# x inherits from custom class c
#' @noRd
assert_custom_class <- function(x,
                                c,
                                message = "%s must inherit from class '%s'",
                                name = deparse(substitute(x))) {

  if (!inherits(x, c)) {
    stop(sprintf(message, name, c), call. = FALSE)
  }
  return(TRUE)
}


#------------------------------------------------
# x is character string
#' @noRd
assert_string <- function(x,
                          message = "%s must be character string",
                          name = deparse(substitute(x))) {

  if (!is.character(x)) {
    stop(sprintf(message, name), call. = FALSE)
  }
  return(TRUE)
}

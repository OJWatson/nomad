#' Add nomad model to package model_db
#'
#' `add_model_to_db` correctly adds new nomad models to the internal
#' [nomad::model_db] database. You should only need to use this function
#' if you are planning on adding a new model to the `nomad` package and you
#' have read the \url{https://ojwatson.github.io/nomad/articles/data.html}
#' vignette.
#'
#' @param nomad_model A [nomad::nomad_model()] object
#' @param name Name of the nomad model to be added. If blank, the name of the
#'   `nomad_model` parameter will be uses. The name should abide to the
#'   naming conventions detailed in the Data vignette, i.e. it should look
#'   similar to zmb_cdr_2020_mod_dd_exp in structure
add_model_to_db <- function(nomad_model,
                            name = deparse(substitute(nomad_model))) {

  # Get package model_db structure
  model_db <- nomad::model_db

  # Add and sort models
  model_db[[name]] <- nomad_model
  model_db <- model_db[order(names(model_db))]

  # Return updated model_db
  model_db
}

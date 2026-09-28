#' Add nomad model to package model_db
#'
#' `add_model_to_db` correctly adds new nomad models to the internal
#' [nomad::model_db] database. You should only need to use this function
#' if you are planning on adding a new model to the `nomad` package and you
#' have read the \url{https://ojwatson.github.io/nomad/articles/data.html}
#' vignette.
#'
#' @noRd
#' @param nomad_model A [nomad::nomad_model()] object
#' @param name Name of the nomad model to be added. If blank, the name of the
#'   `nomad_model` parameter will be uses. The name should abide to the
#'   naming conventions detailed in the Data vignette, i.e. it should look
#'   similar to zmb_cdr_2020_mod_dd_exp in structure
add_model_to_db <- function(nomad_model,
                            name = deparse(substitute(nomad_model))) {

  # Get package model_db structure
  model_db <- nomad::model_db

  if (!nomad_model$get_data_name() %in% nomad::mobility_db$name) {
    stop("Register the source dataset in mobility_db before adding its model", call. = FALSE)
  }

  # Add and sort models
  model_db[[name]] <- nomad_model
  model_db <- model_db[order(names(model_db))]

  # Return updated model_db
  model_db
}


#' Remake model_db model from current
#'
#' When new features get added to the [nomad::nomad_model()] R6 class over
#' time, it will be important to have a way of updating the models in
#' [nomad::model_db] to reflect these changes without having to either refit
#' the underlying mobility model. `remake_model_in_db` provides this
#' functionality.
#'
#' @noRd
#' @param model A [nomad::nomad_model()] object
#' @returns [nomad::nomad_model()]
remake_model_in_db <- function(model) {

  # Create new model
  underlying <- tryCatch(
    model$get_model(hydrate = FALSE),
    error = function(e) model$get_model()
  )
  data_ref <- tryCatch(model$get_data_ref(), error = function(e) NULL)
  data_fields <- tryCatch(model$get_data_fields(), error = function(e) NULL)
  new <- nomad_model(
    model = underlying,
    data_name = model$get_data_name(),
    data_ref = data_ref,
    data_fields = data_fields
  )

  new$set_check_res(model$get_check_res())
  new
}

#' Rebuild model_db
#'
#' Loops through [nomad::model_db] and remakes each model
#' before savig model_db using [usethis::use_data()]
#'
#' @noRd
rebuild_model_db <- function() {

  model_db <- lapply(nomad::model_db, remake_model_in_db)
  usethis::use_data(model_db, overwrite = TRUE)

}

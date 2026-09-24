#' @title R6 Class for mobility models
#'
#' @description A nomad mobility model
#'
#' @importFrom R6 R6Class
nomad_model_ <- R6::R6Class(
  classname = "nomad_model",
  cloneable = FALSE,

  # PUBLIC METHODS
  public = list(

    # INITIALISATION
    #' @description
    #' Create a new `nomad` mobility model
    #' @param model [mobility::mobility()] model
    #' @param data_name The model's name to link to `nomad::mobility_db`
    #' @param data_ref Optional internal reference to shared package model data.
    #' @param data_fields Optional character vector of shared data fields.
    #' @return A new `nomad_model` object.
    initialize = function(model,
                          data_name,
                          data_ref = NULL,
                          data_fields = NULL) {

      # checks on args
      assert_custom_class(model, "mobility.model")
      assert_string(data_name)
      assert_optional_string(data_ref)
      assert_optional_character(data_fields)

      # Dataset membership is checked when registering the model.

      # assign objects to internal
      private$model <- model
      private$data_name <- data_name
      private$data_ref <- data_ref
      private$data_fields <- data_fields

    },

    #' Prediction and simulation method for 'mobility.model' class
    #'
    #' This function uses a fitted \code{mobility.model} object to simulate a
    #' connectivity matrix based on estimated parameters.
    #'
    #' @param newdata a list containing new data to used in model prediction.
    #'   If \code{NULL} (the default) the function will simulate the model with
    #'   the data used for fitting. See [mobility::predict()]
    #' @param nsim number of simulations (default = 1)
    #' @param seed optional integer specifying the call to \code{set.seed}
    #'   prior to model simulation (default = \code{NULL})
    #' @param ... further arguments passed to or from other methods
    #'
    #' @details When \code{nsim = 1}, the prediction matrix is calculated
    #'   using the mean point estimate of parameter values. If \code{nsim > 1}
    #'   then returns and array that contains \code{nsim} number of simulated
    #'   replications based on the posterior distributions of each parameter.
    #'
    #' @return a vector, matrix, or array containing predicted or
    #'   simulated mobility values.
    predict = function(newdata = NULL, nsim = 1, seed = NULL, ...) {
      stats::predict(self, newdata = newdata, nsim = nsim, seed = seed, ...)
    },

    #' Check coordinates
    #'
    #' This function uses a fitted \code{mobility.model} object to simulate a
    #' connectivity matrix based on estimated parameters.
    #'
    #' @param newdata List of `newdata` that is passed to
    #'   [mobility::predict]
    check_coordinates = function(newdata) {

      check_prediction_data(self, newdata)
    },

    #' Remove data model was trained on
    #' @param M Mobility Data
    #' @param D Distance Data
    #' @param N_orig Population Origin Data
    #' @param N_dest Population Destination Data
    #' @param S Radiation intervening opportunity matrix
    #' @param save_model_checks Logical to save model check results. Default = FALSE
    #' @param ... further arguments passed to [png()] for saving model check plot
    remove_model_data = function(M = FALSE, D = FALSE, N_orig = FALSE, N_dest = FALSE,
                                 S = FALSE,
                                 save_model_checks = FALSE, ...) {

      # save these for use later if needed
      if (save_model_checks) {

        # First save the model check statistics for recall later
        grDevices::png(...)
        on.exit(grDevices::dev.off(), add = TRUE)
        private$check_res <- check(self, plots = TRUE)

      }

      # Save

      # remove data if requested
      if (M) {
        private$model$data$M <- NULL
      }
      if (D) {
        private$model$data$D <- NULL
      }
      if (N_orig) {
        private$model$data$N_orig <- NULL
      }
      if (N_dest) {
        private$model$data$N_dest <- NULL
      }
      if (S) {
        private$model$data$S <- NULL
      }
      # return self
      invisible(self)

    },

    # GETTERS

    #' Get model object
    #' @param hydrate If `TRUE`, attach any shared package data referenced by
    #'   this model before returning it.
    #' @return Underlying [mobility::mobility()] model
    get_model = function(hydrate = TRUE) {
      if (!hydrate || is.null(private$data_ref)) {
        return(private$model)
      }

      hydrate_model_data(private$model, private$data_ref, private$data_fields)
    },

    #' Get data name
    #' @return Data name
    get_data_name = function() private$data_name,

    #' Get shared model data reference
    #' @return Shared data reference or `NULL`
    get_data_ref = function() private$data_ref,

    #' Get shared model data fields
    #' @return Character vector of shared data fields or `NULL`
    get_data_fields = function() private$data_fields,

    #' Get check results
    #' @return Results of model check
    get_check_res = function() private$check_res,

    #' Set check results
    #' @param check_res Results of model check
    set_check_res = function(check_res) {
      private$check_res <- check_res
    },

    #' Set shared model data reference
    #' @param data_ref Shared data reference
    #' @param data_fields Shared model data fields
    set_model_data_ref = function(data_ref = NULL, data_fields = NULL) {
      assert_optional_string(data_ref)
      assert_optional_character(data_fields)
      private$data_ref <- data_ref
      private$data_fields <- data_fields
      invisible(self)
    },

    #' Get the model's name
    #' @return Model name
    get_model_name = function() {

      # Get the name of the nomad model
      mt <- model_types()
      mod <- names(mt)[match(private$model$model, mt)]

      # Get if hierarchical
      hierarchical <- model_hierarchical_string(private$model)

      # create short hand name
      name <- paste(
        c(self$get_data_name(), "mod", as.character(mod),
          private$model$type, hierarchical),
        collapse = "_"
      )
      name <- gsub("_$", "", name)

      name
    }

  ),

  private = list(
    model = NULL,
    data_name = NULL,
    check_res = NULL,
    data_ref = NULL,
    data_fields = NULL
  )
)


#' @title Create nomad_model
#'
#' @description A nomad mobility model
#'
#' @param model [mobility::mobility()] model
#' @param data_name The model's name to link to `nomad::mobility_db`
#' @param data_ref Optional internal reference to shared package model data.
#' @param data_fields Optional character vector of shared data fields to attach
#'   when the model is hydrated.
#'
#' @return A new `nomad_model` object.
#'
#' @export
#' @importFrom R6 R6Class
#' @examples
#' # Get mobility.model object
#' mob_model <- nomad::model_db$zmb_fb_2020_mod_grav_exp$get_model()
#'
#' # Create nomad_model object
#' new_mod <- nomad_model(mob_model, data_name = "zmb_fb_2020")

nomad_model <- function(model,
                        data_name,
                        data_ref = NULL,
                        data_fields = NULL) {

  nomad_model_$new(model, data_name, data_ref, data_fields)

}

#' Remove mobility data that mobility model was trained on
#'
#' @details Specify `TRUE` to remove a data type.
#'
#' @param model [nomad::nomad_model()] model
#' @param M Mobility Data. Default = FALSE (i.e. do not remove)
#' @param D Distance Data. Default = FALSE
#' @param N_orig Population Origin Data. Default = FALSE
#' @param N_dest Population Destination Data. Default = FALSE
#' @param S Radiation intervening opportunity matrix. Default = FALSE
#' @param save_model_checks Logical to save model check results. Default = FALSE
#' @param ... further arguments passed to [png()] for saving model check plot
#' @export
nomad_remove_model_data <- function(model,
                                    M = FALSE,
                                    D = FALSE,
                                    N_orig = FALSE,
                                    N_dest = FALSE,
                                    S = FALSE,
                                    save_model_checks = FALSE,
                                    ...) {

  # remove from internal model as requested
  model <- model$remove_model_data(
    M = M,
    D = D,
    N_orig = N_orig,
    N_dest = N_dest,
    S = S,
    save_model_checks = save_model_checks,
    ...
  )

  return(model)
}

#' @noRd
model_data_cache <- new.env(parent = emptyenv())

#' @noRd
hydrate_model_data <- function(model, data_ref, data_fields) {
  if (is.null(data_fields) || !length(data_fields)) {
    return(model)
  }

  shared <- read_shared_model_data(data_ref)
  missing <- setdiff(data_fields, names(shared))
  if (length(missing)) {
    stop(
      sprintf(
        "Shared model data '%s' is missing field(s): %s",
        data_ref,
        paste(missing, collapse = ", ")
      ),
      call. = FALSE
    )
  }

  out <- model
  data <- out$data
  for (field in data_fields) {
    if (is.null(data[[field]])) {
      data[[field]] <- shared[[field]]
    }
  }
  out$data <- data
  out
}

#' @noRd
read_shared_model_data <- function(data_ref) {
  if (exists(data_ref, envir = model_data_cache, inherits = FALSE)) {
    return(get(data_ref, envir = model_data_cache, inherits = FALSE))
  }

  path <- shared_model_data_path(data_ref)
  data <- readRDS(path)
  assign(data_ref, data, envir = model_data_cache)
  data
}

#' @noRd
shared_model_data_path <- function(data_ref) {
  filename <- paste0(data_ref, ".rds")
  path <- system.file(
    "extdata",
    "model_data",
    filename,
    package = "nomad"
  )
  if (nzchar(path)) {
    return(path)
  }

  local_path <- file.path("inst", "extdata", "model_data", filename)
  if (file.exists(local_path)) {
    return(local_path)
  }

  stop(
    sprintf("Shared model data file for '%s' was not found", data_ref),
    call. = FALSE
  )
}

#' @noRd
assert_optional_string <- function(x) {
  if (is.null(x)) {
    return(invisible(NULL))
  }
  if (!is.character(x) || length(x) != 1L || is.na(x)) {
    stop("data_ref must be a character string or NULL", call. = FALSE)
  }

  invisible(NULL)
}

#' @noRd
assert_optional_character <- function(x) {
  if (is.null(x)) {
    return(invisible(NULL))
  }
  if (!is.character(x) || anyNA(x)) {
    stop("data_fields must be a character vector or NULL", call. = FALSE)
  }

  invisible(NULL)
}

#' @noRd
check_plot_file_path <- function(model) {
  model_path <- system.file(
    "extdata",
    file.path(
      "model_checks",
      model$get_data_name(),
      paste0(model$get_model_name(), ".png")
    ),
    package = "nomad"
  )
  if (nzchar(model_path)) {
    return(model_path)
  }

  system.file(
    "extdata",
    file.path("model_checks", model$get_data_name(), "model_check.png"),
    package = "nomad"
  )
}

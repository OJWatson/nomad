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
    #' @return A new `nomad_model` object.
    initialize = function(model,
                          data_name) {

      # checks on args
      assert_custom_class(model, "mobility.model")
      assert_string(data_name)

      # TODO Check on data name either NULL or in mobility_db

      # assign objects to internal
      private$model <- model
      private$data_name <- data_name

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
    predict = function(newdata, nsim, seed, ...) {

      # Use the model in this class for the prediction
      mobility::predict(private$model,
                        newdata = newdata,
                        nsim = nsim,
                        seed = seed,
                        ...)

    },

    #' Check coordinates
    #'
    #' This function uses a fitted \code{mobility.model} object to simulate a
    #' connectivity matrix based on estimated parameters.
    #'
    #' @param newdata List of `newdata` that is passed to
    #'   [mobility::predict]
    check_coordinates = function(newdata) {

      # TODO: Future milestone to include warnings here if the user has
      # provided newdata that is unsuitable for this model given the data
      # that was used to fit it


    },

    #' Remove data model was trained on
    #' @param M Mobility Data
    #' @param D Distance Data
    #' @param N_orig Population Origin Data
    #' @param N_dest Population Destination Data
    #' @param save_model_checks Logical to save model check results. Default = FALSE
    #' @param ... further arguments passed to [png()] for saving model check plot
    remove_model_data = function(M = FALSE, D = FALSE, N_orig = FALSE, N_dest = FALSE,
                                 save_model_checks = FALSE, ...) {

      # save these for use later if needed
      if (save_model_checks) {

        # First save the model check statistics for recall later
        png(...)
        private$check_res <- check(self, plots = TRUE)
        dev.off()

      }

      # Save

      # remove data if requested
      if (M) {
        private$model$data$M <- NULL
      }
      if (D) {
        private$model$data$M <- NULL
      }
      if (N_orig) {
        private$model$data$M <- NULL
      }
      if (N_dest) {
        private$model$data$M <- NULL
      }
      # return self
      invisible(self)

    },

    # GETTERS

    #' Get model object
    #' @return Underlying [mobility::mobility()] model
    get_model = function() private$model,

    #' Get data name
    #' @return Data name
    get_data_name = function() private$data_name,

    #' Get check results
    #' @return Results of model check
    get_check_res = function() private$check_res,

    #' Set check results
    #' @param check_res Results of model check
    set_check_res = function(check_res) {
      private$check_res <- check_res
    },

    #' Get the model's name
    #' @return Model name
    get_model_name = function() {

      # Get the name of the nomad model
      mt <- model_types()
      mod <- names(mt)[match(self$get_model()$type, mt)]

      # Get if hierarchical
      hierarchical <- model_hierarchical_string(self$get_model())

      # create short hand name
      name <- paste(self$get_data_name(), "mod",
                    as.character(mod), self$get_model()$type,
                    hierarchical,
                    sep = "_")

      return(name)
    }

  ),

  private = list(
    model = NULL,
    data_name = NULL,
    check_res = NULL,
    test = NULL
  )
)


#' @title Create nomad_model
#'
#' @description A nomad mobility model
#'
#' @param model [mobility::mobility()] model
#' @param data_name The model's name to link to `nomad::mobility_db`
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

nomad_model <- function(model, data_name) {

  nomad_model_$new(model, data_name)

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
#' @param save_model_checks Logical to save model check results. Default = FALSE
#' @param ... further arguments passed to [png()] for saving model check plot
#' @export
nomad_remove_model_data <- function(model,
                                    M = FALSE,
                                    D = FALSE,
                                    N_orig = FALSE,
                                    N_dest = FALSE,
                                    save_model_checks = FALSE,
                                    ...) {

  # remove from internal model as requested
  model <- model$remove_model_data(
    M = M,
    D = D,
    N_orig = N_orig,
    N_dest = N_dest,
    save_model_checks = save_model_checks,
    ...
  )

  return(model)
}

#' @noRd
check_plot_file_path <- function(model) {
  system.file(
    "extdata",
    file.path("model_checks", model$get_data_name(), "model_check.png"),
    package = "nomad"
  )
}

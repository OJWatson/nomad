#' @title R6 Class for mobility models
#'
#' @description A nomad mobility model
#'
#' @importFrom R6 R6Class
R6_nomad_model <- R6::R6Class(
  classname = "nomad.model",
  cloneable = FALSE,

  # PUBLIC METHODS
  public = list(

    # INITIALISATION
    #' @description
    #' Create a new `nomad` mobility model
    #' @param model [mobility::mobility()] model
    #' @param model_desc Short description of model type and underlying data
    #' @param data_desc Short description of data used to fit `model`
    #' @param model_name The name of the model for linking with `nomad::model_data`
    #' @return A new `nomad.model` object.
    initialize = function(model,
                          model_desc,
                          data_desc,
                          model_name) {

      # checks on args
      assert_custom_class(model, "mobility.model")
      assert_string(model_desc)
      assert_string(data_desc)
      assert_string(model_name)

      # assign
      private$model <- model
      private$model_desc <- model_desc
      private$data_desc <- data_desc
      private$model_name <- model_name

    }
  ),

  private = list(
    model = NULL,
    model_desc = NULL,
    data_desc = NULL,
    model_name = NULL
  )
)


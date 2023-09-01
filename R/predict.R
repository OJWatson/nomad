#' Prediction and simulation method for 'nomad_model' class
#'
#' This function uses the fitted [mobility::mobility()] object inside the the
#' [nomad::nomad_model()] to simulate a connectivity matrix based on
#' estimated parameters.
#'
#' @param object a [nomad::nomad_model()] object containing the fitted mobility
#'   model and its associated meta data
#' @param unit The unit of distance associated with the x and y coordinates.
#'   Default = `NULL`, which assumes the provided coordinates are longitude (x)
#'   and latitiude (y).
#'
#' @details When \code{nsim = 1}, the prediction matrix is calculated
#'   using the mean point estimate of parameter values. If \code{nsim > 1}
#'   then an array that contains \code{nsim} number of simulated replications
#'   is returned based on the posterior distributions of each parameter.
#'
#'   TODO: Warnings are not currently implemented (Milestone 2)
#'
#'   Warnings will be shown if the `newdata` provided is unlikely to be well
#'   predicted by the model. This will happen under two circumstances.
#'
#'   1) If the coordinates provided are at a spatial scale that is unsuitable
#'   given the spatial scale that the model was fit against. For example, if the
#'   model was fit using data collecting mobility between locations that are
#'   100s km apart on average but the coordinates are 1km apart on average.
#'
#'   2) If the coordinates provided span international borders. Currently, there
#'   are no models available in `nomad` that were fit using mobility data that
#'   includes international movements. As a result, any predictions made for
#'   international locations may poorly capture international mobility.
#'
#' @inherit mobility::predict
#'
#' @export
#' @examples
#' # Get nomad_model object
#' nmd_model <- nomad::model_db$zmb_cdr_2020_mod_dd_exp
#'
#' # Check model fit
#' nomad::predict(nmd_model)
predict <- function(object, newdata, nsim, seed, unit, ...) UseMethod('predict')

#' @export
predict.nomad_model <- function(object,
                                newdata = NULL,
                                nsim = 1,
                                seed = NULL,
                                unit = NULL,
                                ...) {

  # TODO: Check coordinates
  # check_coordinates(object, newdata, unit)

  mobility::predict(object$get_model(), newdata, nsim, seed, unit, ...)

}



#' Check goodness of fit for 'nomad_model' class
#'
#' This function takes a `nomad_model` object and calculates goodness of fit
#' metrics for the underlying [mobility::mobility()]. If the Deviance
#' Information Criterin (DIC) was calculated in the supplied model object,
#' it is included in output. When plots = TRUE, two plots are shown containing
#' the posterior distribution of trip counts compared to observed data and a
#' Normal Q-Q plot showing the quantiles of model residuals against those
#' expected from a Normal distribution.
#'
#' @param object a [nomad::nomad_model()] object containing the fitted mobility
#' @inherit mobility::check
#'
#' @export
#' @examples
#' # Get nomad_model object
#' nmd_model <- nomad::model_db$zmb_cdr_2020_mod_dd_exp
#'
#' # Check model fit
#' nomad::check(nmd_model)
#'
#' # Get nomad_model object without underlying data
#' nmd_model <- nomad::model_db$zmb_fb_2020_mod_grav_exp
#'
#' # Model check statistics are still available as these are
#' # saved when model data is removed from object
#' nomad::residuals(nmd_model)
check <- function(object, plots, ...) UseMethod('check')

#' @export
check.nomad_model <- function(object, plots = TRUE, ...) {

  if(is.null(object$get_check_res())) {
    mobility::check(object$get_model(), plots, ...)
  } else {
    fp <- check_plot_file_path(object)
    if(file.exists(fp)) {
      # TODO: Plot fp
    }
    object$get_check_res()
  }

}

#' Calculate summary statistics for 'nomad_model' class
#'
#' This function takes a `nomad_model` object and calculates summary statistics
#' for the underlying [mobility::mobility()]. This is a wrapper function of
#' [MCMCvis::MCMCsummary] that calculates summary statistics for each parameter
#' in a [mobility::mobility()] object.
#'
#' Summary statistics are calculated for all parameters across each chain along
#' with convergance diagnosics like the Gelman-Rubin convergence diagnostic and
#' (Rhat) and samples auto-correlation foreach parameter. If the model object
#' contains deviance and penalty parameters, then Deviance Information Criterion
#' (DIC) is calculated and appended to the summary.
#'
#' @param object a [nomad::nomad_model()] object containing the fitted mobility
#' @inherit mobility::summary
#'
#' @export
#' @examples
#' # Get nomad_model object
#' nmd_model <- nomad::model_db$zmb_cdr_2020_mod_dd_exp
#'
#' # Check model fit
#' nomad::summary(nmd_model)
summary <- function(object, probs, ac_lags, ...) UseMethod('summary')

#' @export
summary.nomad_model <- function(object,
                                probs = c(0.025, 0.975),
                                ac_lags = c(5, 10),
                                ...) {


  mobility::summary(object$get_model(), probs, ac_lags, ...)

}


#' Extract model residuals 'nomad_model' class
#'
#' This function takes a `nomad_model` object and extracts model residuals from
#' the underlying [mobility::mobility()].
#'
#' @param object a [nomad::nomad_model()] object containing the fitted mobility
#' @inherit mobility::residuals
#'
#' @export
#' @examples
#' # Get nomad_model object
#' nmd_model <- nomad::model_db$zmb_cdr_2020_mod_dd_exp
#'
#' # Get model residuals
#' nomad::residuals(nmd_model)
#'
#' # Get nomad_model object without underlying data
#' nmd_model <- nomad::model_db$zmb_fb_2020_mod_grav_exp
#'
#' # Model residuals not available
#' nomad::residuals(nmd_model)
residuals <- function(object, type, ...) UseMethod('residuals')

#' @export
residuals.nomad_model <- function(object, type = "deviance", ...) {

  if(is.null(object$get_check_res())) {
    mobility::residuals(object$get_model(), type, ...)
  } else {
    message("Residuals not available as underlying model data is not available.")
  }
}


#' Print 'nomad_model' class
#'
#' This function provides a simple print overview of a `nomad_model` object.
#'
#' @param x a [nomad::nomad_model()] object
#' @param name Name of the model. Defaults to the name of object x
#' @param ... further arguments passed to or from other methods
#' @export
print <- function(x, name, ...) UseMethod('print')

#' @export
print.nomad_model <- function(x, name = deparse(substitute(x)), ...) {

  message("Nomad mobility model:\n")

  data_names <- gsub("(.*)(_mod.*)", "\\1", name)
  mobility_model <- vapply(strsplit(name, "_"), FUN.VALUE = character(1), "[[", 5)
  model_type <- vapply(strsplit(name, "_"), FUN.VALUE = character(1), "[[", 6)
  df <- data.frame(mobility_model = mobility_model,
             model_type = model_type)

  message(paste(
    names(df),
    df[1,,drop=FALSE],
    sep = ": ",
    collapse = "\n"
  ))
  message("\nMobility Data:\n")


  print_mobility_data(x$get_data_name())
}

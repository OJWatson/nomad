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
#' nomad::check(nmd_model)
check <- function(object, plots, ...) UseMethod("check")

#' @export
check.nomad_model <- function(object, plots = TRUE, ...) {

  if (is.null(object$get_check_res())) {
    mobility::check(object$get_model(), plots, ...)
  } else {
    if (plots) {
      draw_check_plot(object)
    }
    object$get_check_res()
  }

}

#' Plot model fit checks for 'nomad_model' class
#'
#' This function plots the model-check diagnostics for a [nomad::nomad_model()]
#' object. For models where the original mobility data are unavailable, it draws
#' the saved check plot bundled with the package.
#'
#' @param x a [nomad::nomad_model()] object
#' @param ... further arguments passed to [mobility::check()] when underlying
#'   model data are available
#'
#' @export
plot.nomad_model <- function(x, ...) {

  if (is.null(x$get_check_res())) {
    mobility::check(x$get_model(), plots = TRUE, ...)
  } else {
    draw_check_plot(x)
  }

  invisible(x)
}

#' Prediction and simulation method for 'nomad_model' class
#'
#' This function uses the fitted [mobility::mobility()] object inside the the
#' [nomad::nomad_model()] to simulate a connectivity matrix based on
#' estimated parameters.
#'
#' @param object a [nomad::nomad_model()] object containing the fitted mobility
#'   model and its associated meta data
#' @param unit Distance unit of `newdata$D`: `"m"` or `"km"`. Distances are
#'   converted to the fitted units. With `NULL`, supply distances already in
#'   the model's units, shown by [model_profile()].
#' @param locations Optional locations used for prediction. If supplied as an
#'   `sf` object or a data frame/matrix with longitude and latitude columns,
#'   `nomad` will warn when locations cross international borders or do not
#'   match the source country for the fitted model.
#' @param duration Optional requested prediction duration, in days. If supplied,
#'   predictions are scaled from the fitted model source duration to this
#'   duration.
#' @param date_start,date_end Optional requested prediction period. Used to
#'   calculate `duration` when `duration` is not supplied.
#'
#' @details When \code{nsim = 1}, the prediction matrix is calculated
#'   using the mean point estimate of parameter values. If \code{nsim > 1}
#'   then an array that contains \code{nsim} number of simulated replications
#'   is returned based on the posterior distributions of each parameter.
#'
#'   Warnings will be shown if the `newdata` provided is unlikely to be well
#'   predicted by the model. These checks are advisory and are intended to help
#'   users notice mismatches before using predictions in downstream analyses.
#'   This can happen under several circumstances.
#'
#'   1) If the coordinates provided are at a spatial scale that is unsuitable
#'   given the spatial scale that the model was fit against. For example, if the
#'   model was fit using data collecting mobility between locations that are
#'   100s km apart on average but the coordinates are 1km apart on average.
#'
#'   2) If the supplied population or region count is far from the fitted source
#'   data.
#'
#'   3) If the coordinates provided span international borders. Currently, there
#'   are no models available in `nomad` that were fit using mobility data that
#'   includes international movements. As a result, any predictions made for
#'   international locations may poorly capture international mobility.
#'
#'   4) If requested prediction dates fall outside the fitted source period, or
#'   an unscaled prediction has an unknown source period. Scaling an unknown
#'   period is an error. Basic/finite radiation accepts only its original setting.
#'
#' @inherit mobility::predict
#'
#' @export
#' @examples
#' # Get nomad_model object
#' nmd_model <- nomad::model_db$zmb_cdr_2020_mod_dd_exp
#'
#' # Produce model predictions
#' predict(nmd_model)
#'
predict.nomad_model <- function(object,
                                newdata = NULL,
                                nsim = 1,
                                seed = NULL,
                                unit = NULL,
                                locations = NULL,
                                duration = NULL,
                                date_start = NULL,
                                date_end = NULL,
                                ...) {

  if (!is.numeric(nsim) || length(nsim) != 1L || !is.finite(nsim) ||
        nsim < 1 || nsim > .Machine$integer.max || nsim != as.integer(nsim)) {
    stop("nsim must be a positive integer", call. = FALSE)
  }
  requested <- requested_duration_days(duration, date_start, date_end)
  if (!is.null(requested) && is.null(source_duration_days(object))) {
    stop("Cannot scale ", object$get_model_name(), ": its prediction period is unknown.",
         call. = FALSE)
  }
  fitted <- object$get_model()
  newdata <- prepare_prediction_data(object, newdata, unit)
  order <- check_model_capabilities(object, fitted, newdata, nsim)
  check_prediction_data(object, newdata, locations, model_distance_unit(object))
  # mobility needs an existing RNG state to honour its seed argument.
  if (!is.null(seed) && !exists(".Random.seed", envir = .GlobalEnv, inherits = FALSE)) {
    set.seed(seed)
    on.exit(rm(".Random.seed", envir = .GlobalEnv), add = TRUE)
  }
  if (fitted$model == "radiation") {
    out <- mobility::predict(fitted, nsim = nsim, seed = seed, ...)
    if (!is.null(order)) out <- out[order[[1]], order[[2]], drop = FALSE]
  } else {
    if (!is.null(newdata)) fitted$data$S <- NULL
    out <- mobility::predict(fitted, newdata = newdata, nsim = nsim, seed = seed, ...)
  }
  attr(out, "model") <- fitted$model
  attr(out, "type") <- fitted$type
  scale_prediction_duration(out, object, duration, date_start, date_end)

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
#' summary(nmd_model)
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
#' residuals(nmd_model)
#'
#' # Get nomad_model object without underlying data
#' nmd_model <- nomad::model_db$zmb_fb_2020_mod_grav_exp
#'
#' # Model residuals not available
#' residuals(nmd_model)
residuals.nomad_model <- function(object, type = "deviance", ...) {

  if (is.null(object$get_check_res())) {
    mobility::residuals(object$get_model(), type, ...)
  } else {
    nomad_inform(
      c(
        "i" = "Residuals are not available because the underlying model data are not bundled."
      ),
      class = "nomad_message_residuals_unavailable"
    )
  }
}


#' Print 'nomad_model' class
#'
#' This function provides a simple print overview of a `nomad_model` object.
#'
#' @param x a [nomad::nomad_model()] object
#' @param ... further arguments passed to or from other methods
#' @export
print.nomad_model <- function(x,  ...) {

  cat("Nomad mobility model:\n\n")

  print_nomad_model(x)

  cat("\n\nMobility Data:\n\n")

  print_mobility_data(x$get_data_name())
}

#' @noRd
draw_check_plot <- function(object) {
  fp <- check_plot_file_path(object)
  if (file.exists(fp)) {
    img <- png::readPNG(fp)
    rasterImage <- grid::rasterGrob(img, interpolate = TRUE)

    grid::grid.newpage()
    grid::grid.draw(rasterImage)
  }

  invisible(object)
}

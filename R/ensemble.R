#' Create an ensemble of nomad models
#'
#' Creates a lightweight ensemble object that predicts from several
#' [nomad_model()] objects and combines predictions with user-supplied weights.
#'
#' @param models A [nomad_model()] object or a list of `nomad_model` objects.
#' @param weights Optional numeric weights, or a data frame returned by
#'   [model_weights()]. If omitted, all models are weighted equally. Weights are
#'   normalised to sum to one.
#'
#' @return A `nomad_ensemble` object.
#' @export
nomad_ensemble <- function(models, weights = NULL) {
  if (inherits(models, "nomad_model")) {
    models <- list(models)
  }
  if (!is.list(models) || !length(models) ||
        !all(vapply(models, inherits, logical(1), "nomad_model"))) {
    stop("models must be a nomad_model object or a list of nomad_model objects",
         call. = FALSE)
  }

  ids <- vapply(models, function(x) x$get_model_name(), character(1))
  labels <- names(models) %||% ids
  if (is.data.frame(weights)) {
    if (!all(c("name", "weight") %in% names(weights))) {
      stop("Weight tables must contain name and weight", call. = FALSE)
    }
    weights <- stats::setNames(weights$weight, weights$name)
    weights <- match_model_weights(weights, ids)
  } else if (!is.null(names(weights))) {
    target <- if (setequal(names(weights), labels)) labels else ids
    weights <- match_model_weights(weights, target)
  }
  if (is.null(weights)) weights <- rep(1, length(models))
  if (!is.numeric(weights) || length(weights) != length(models) ||
        any(!is.finite(weights)) || any(weights < 0) ||
        !is.finite(sum(weights)) || sum(weights) <= 0) {
    stop("weights must be finite, non-negative and have a positive finite total", call. = FALSE)
  }
  weights <- unname(weights / sum(weights))
  names(models) <- labels

  structure(
    list(models = models, weights = weights),
    class = "nomad_ensemble"
  )
}

#' Predict from a nomad model ensemble
#'
#' @param object A [nomad_ensemble()] object.
#' @param newdata Optional prediction data passed to each model.
#' @param ... Further arguments passed to [predict.nomad_model()].
#'
#' @return A weighted-average prediction matrix or array.
#' @export
predict.nomad_ensemble <- function(object, newdata = NULL, ...) {
  args <- list(...)
  periods <- vapply(object$models, function(model) source_duration_days(model) %||% NA_real_,
                    numeric(1))
  sources <- vapply(object$models, function(model) model$get_data_name(), character(1))
  requested <- requested_duration_days(args$duration, args$date_start, args$date_end)
  if ((anyNA(periods) && (!is.null(requested) || length(unique(sources)) > 1L)) ||
        (!anyNA(periods) && is.null(requested) && length(unique(periods)) > 1L)) {
    stop("Ensemble prediction periods are incompatible or unknown; use compatible models ",
         "and a common duration when source periods are known.", call. = FALSE)
  }
  for (model in object$models) {
    prepared <- prepare_prediction_data(model, newdata, args$unit)
    check_model_capabilities(model, model$get_model(), prepared, args$nsim %||% 1)
  }
  predictions <- lapply(object$models, function(model) {
    stats::predict(model, newdata = newdata, ...)
  })

  out <- weighted_prediction(predictions, object$weights)
  attr(out, "model") <- "ensemble"
  attr(out, "type") <- NULL
  attr(out, "data_name") <- unique(sources)
  attr(out, "component_models") <- vapply(object$models, function(x) {
    x$get_model_name()
  }, character(1))
  out
}

#' Compare two prediction matrices
#'
#' @param x,y Prediction matrices with the same dimensions.
#' @param relative If `TRUE`, return `(x - y) / y`; otherwise return `x - y`.
#'
#' @return A matrix of differences.
#' @export
prediction_difference <- function(x, y, relative = FALSE) {
  y <- align_prediction(x, y)
  out <- x - y
  if (relative) {
    zero <- y == 0
    out <- out / y
    if (any(zero)) {
      out[zero] <- NA_real_
      nomad_warn("Relative differences are NA where the baseline is zero.",
                 class = "nomad_warning_zero_baseline")
    }
  }
  out
}

#' Plot the difference between prediction matrices
#'
#' @param x,y Prediction matrices with the same dimensions.
#' @param relative If `TRUE`, plot `(x - y) / y`; otherwise plot `x - y`.
#' @param ... Further arguments passed to [graphics::image()].
#'
#' @return Invisibly returns the difference matrix.
#' @export
plot_prediction_difference <- function(x, y, relative = FALSE, ...) {
  out <- prediction_difference(x, y, relative = relative)
  graphics::image(
    t(out[rev(seq_len(nrow(out))), , drop = FALSE]),
    xlab = "",
    ylab = "",
    axes = FALSE,
    ...
  )

  invisible(out)
}

#' @noRd
weighted_prediction <- function(predictions, weights) {
  dims <- lapply(predictions, dim)
  if (!all(vapply(dims, identical, logical(1), dims[[1]]))) {
    stop("All ensemble model predictions must have the same dimensions",
         call. = FALSE)
  }

  predictions <- lapply(predictions, function(x) align_prediction(predictions[[1]], x))
  out <- predictions[[1]] * weights[[1]]
  if (length(predictions) > 1L) {
    for (i in seq.int(2L, length(predictions))) {
      out <- out + predictions[[i]] * weights[[i]]
    }
  }

  attr(out, "weights") <- weights
  out
}

#' @noRd
match_model_weights <- function(weights, ids) {
  if (anyDuplicated(names(weights)) || anyDuplicated(ids) ||
        !setequal(names(weights), ids)) {
    stop("Named weights must identify each model exactly once", call. = FALSE)
  }
  weights[ids]
}

#' @noRd
align_prediction <- function(reference, x) {
  if (!identical(dim(reference), dim(x))) {
    stop("Predictions must have the same dimensions", call. = FALSE)
  }
  indices <- lapply(dim(x), seq_len)
  for (i in seq_len(2L)) {
    a <- dimnames(reference)[[i]]
    b <- dimnames(x)[[i]]
    if (is.null(a) && is.null(b)) next
    if (is.null(a) || is.null(b) || anyNA(a) || anyNA(b) ||
          anyDuplicated(a) || anyDuplicated(b) || !setequal(a, b)) {
      stop("Predictions must identify the same target regions uniquely", call. = FALSE)
    }
    indices[[i]] <- match(a, b)
  }
  attrs <- attributes(x)
  x <- do.call(`[`, c(list(x), indices, list(drop = FALSE)))
  keep <- setdiff(names(attrs), c("dim", "dimnames", "names"))
  attributes(x)[keep] <- attrs[keep]
  x
}

#' Summarise predicted mobility matrices
#'
#' Calculates simple summary metrics for one predicted matrix or each simulated
#' matrix in a 3D prediction array.
#'
#' @param x A predicted mobility matrix, or a 3D array with simulations in the
#'   third dimension.
#'
#' @return A [tibble::tibble()] with one row per matrix.
#' @export
mobility_metrics <- function(x) {
  mats <- prediction_matrices(x)

  tibble::as_tibble(do.call(rbind, lapply(seq_along(mats), function(i) {
    matrix_metrics(mats[[i]], i)
  })))
}

#' Summarise uncertainty metrics
#'
#' Calculates lower, median, and upper quantiles for selected metrics from a
#' stochastic prediction array.
#'
#' @param x A 3D prediction array with simulations in the third dimension.
#' @param metrics Metrics to summarise. Must be columns returned by
#'   [mobility_metrics()].
#' @param probs Quantiles to calculate.
#'
#' @return A [tibble::tibble()] with one row per metric and probability.
#' @export
uncertainty_summary <- function(x,
                                metrics = c("total", "between_region"),
                                probs = c(0.025, 0.5, 0.975)) {
  metric_table <- mobility_metrics(x)
  missing <- setdiff(metrics, names(metric_table))
  if (length(missing)) {
    stop("metrics must be columns returned by mobility_metrics()",
         call. = FALSE)
  }

  out <- do.call(rbind, lapply(metrics, function(metric) {
    values <- stats::quantile(
      metric_table[[metric]],
      probs = probs,
      names = FALSE,
      na.rm = TRUE
    )
    data.frame(metric = metric, prob = probs, value = as.numeric(values))
  }))

  tibble::as_tibble(out)
}

#' Select representative uncertainty matrices
#'
#' Selects matrices closest to requested quantiles of a summary metric. This is
#' useful for inspecting lower, median, and upper stochastic prediction draws.
#'
#' @param x A 3D prediction array with simulations in the third dimension.
#' @param metric Metric to order by. Must be a column returned by
#'   [mobility_metrics()].
#' @param probs Quantiles to select.
#'
#' @return A named list of matrices, with the full metrics table attached as a
#'   `metrics` attribute.
#' @export
uncertainty_matrices <- function(x,
                                 metric = "total",
                                 probs = c(0.025, 0.5, 0.975)) {
  if (length(dim(x)) != 3L) {
    stop("x must be a 3D prediction array", call. = FALSE)
  }

  metrics <- mobility_metrics(x)
  if (!metric %in% names(metrics)) {
    stop("metric must be a column returned by mobility_metrics()", call. = FALSE)
  }

  values <- metrics[[metric]]
  targets <- stats::quantile(values, probs = probs, names = FALSE, na.rm = TRUE)
  index <- vapply(targets, function(target) {
    which.min(abs(values - target))
  }, integer(1))

  out <- lapply(index, function(i) x[, , i])
  names(out) <- paste0("q", as.character(probs))
  attr(out, "metrics") <- metrics
  attr(out, "metric") <- metric
  attr(out, "selected") <- tibble::tibble(
    name = names(out),
    prob = probs,
    simulation = metrics$simulation[index],
    value = values[index]
  )
  out
}

#' Plot representative uncertainty matrices
#'
#' Plots matrices selected by [uncertainty_matrices()] using base graphics.
#'
#' @param x A 3D prediction array with simulations in the third dimension.
#' @param metric Metric to order by. Must be a column returned by
#'   [mobility_metrics()].
#' @param probs Quantiles to select.
#' @param ... Further arguments passed to [graphics::image()].
#'
#' @return Invisibly returns the selected matrices.
#' @export
plot_uncertainty <- function(x,
                             metric = "total",
                             probs = c(0.025, 0.5, 0.975),
                             ...) {
  selected <- uncertainty_matrices(x, metric = metric, probs = probs)
  old_par <- graphics::par(no.readonly = TRUE)
  on.exit(graphics::par(old_par), add = TRUE)

  graphics::par(mfrow = c(1, length(selected)))
  selected_table <- attr(selected, "selected")
  for (i in seq_along(selected)) {
    graphics::image(
      t(selected[[i]][rev(seq_len(nrow(selected[[i]]))), , drop = FALSE]),
      main = sprintf(
        "%s\n%s = %s",
        names(selected)[i],
        metric,
        format(selected_table$value[[i]], digits = 3)
      ),
      xlab = "",
      ylab = "",
      axes = FALSE,
      ...
    )
  }

  invisible(selected)
}

#' @noRd
prediction_matrices <- function(x) {
  dims <- dim(x)
  if (length(dims) == 2L) {
    return(list(x))
  }
  if (length(dims) == 3L) {
    return(lapply(seq_len(dims[3]), function(i) x[, , i]))
  }

  stop("x must be a matrix or a 3D prediction array", call. = FALSE)
}

#' @noRd
matrix_metrics <- function(x, simulation) {
  diag_values <- diag(x)
  off_diag <- x[row(x) != col(x)]

  data.frame(
    simulation = simulation,
    total = sum(x, na.rm = TRUE),
    mean = mean(x, na.rm = TRUE),
    max = max(x, na.rm = TRUE),
    within_region = sum(diag_values, na.rm = TRUE),
    between_region = sum(off_diag, na.rm = TRUE)
  )
}

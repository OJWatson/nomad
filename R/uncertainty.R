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
#' Plots complete draws selected by [uncertainty_matrices()] as labelled heatmaps
#' with a shared colour scale. Requires ggplot2.
#'
#' @param x A 3D prediction array with simulations in the third dimension.
#' @param metric Metric to order by. Must be a column returned by
#'   [mobility_metrics()].
#' @param probs Quantiles to select.
#' @param scale Colour transformation: `"log1p"` (default) or `"identity"`.
#'   Log1p accommodates zero flows and makes smaller flows visible.
#' @param ... Further arguments passed to [ggplot2::geom_tile()].
#'
#' @return Invisibly returns the selected matrices.
#' @export
plot_uncertainty <- function(x,
                             metric = "total",
                             probs = c(0.025, 0.5, 0.975),
                             scale = c("log1p", "identity"),
                             ...) {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Install ggplot2 to plot uncertainty matrices", call. = FALSE)
  }
  scale <- match.arg(scale)
  selected <- uncertainty_matrices(x, metric = metric, probs = probs)
  selection <- attr(selected, "selected")
  origins <- rownames(selected[[1]])
  destinations <- colnames(selected[[1]])
  if (is.null(origins)) origins <- as.character(seq_len(nrow(selected[[1]])))
  if (is.null(destinations)) destinations <- as.character(seq_len(ncol(selected[[1]])))
  labels <- paste0(100 * selection$prob, "% quantile\n",
                   format(round(selection$value), big.mark = ",", scientific = FALSE, trim = TRUE),
                   " trips")
  cells <- do.call(rbind, lapply(seq_along(selected), function(i) {
    out <- expand.grid(origin = origins, destination = destinations,
                       stringsAsFactors = FALSE)
    out$trips <- as.vector(selected[[i]])
    out$draw <- labels[i]
    out
  }))
  cells$origin <- factor(cells$origin, levels = rev(origins))
  cells$destination <- factor(cells$destination, levels = destinations)
  cells$draw <- factor(cells$draw, levels = unique(labels))

  breaks <- if (scale == "log1p") {
    function(x) 10^pretty(log10(pmax(x, 1)), n = 3)
  } else {
    ggplot2::waiver()
  }
  plot <- ggplot2::ggplot(cells, ggplot2::aes(.data$destination, .data$origin,
                                              fill = .data$trips)) +
    ggplot2::geom_tile(...) +
    ggplot2::facet_wrap(~draw, nrow = 1) +
    ggplot2::scale_fill_viridis_c(option = "inferno", trans = scale, breaks = breaks,
                                  labels = function(x) {
                                    format(x, big.mark = ",", scientific = FALSE, trim = TRUE)
                                  }) +
    ggplot2::scale_x_discrete(expand = c(0, 0)) +
    ggplot2::scale_y_discrete(expand = c(0, 0)) +
    ggplot2::labs(x = "Destination", y = "Origin", fill = "Predicted trips",
                  caption = paste0("Draws ranked by ", gsub("_", " ", metric),
                                   "; the same colour scale is used in every panel.")) +
    ggplot2::theme_minimal(base_size = 11) +
    ggplot2::theme(
      panel.grid = ggplot2::element_blank(),
      axis.text.x = ggplot2::element_text(angle = 90, hjust = 1, vjust = 0.5),
      strip.text = ggplot2::element_text(face = "bold"),
      legend.position = "bottom",
      legend.key.width = grid::unit(1.5, "cm"),
      plot.caption = ggplot2::element_text(hjust = 0)
    )
  print(plot)
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

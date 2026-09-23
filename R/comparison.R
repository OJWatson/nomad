#' Compare two mobility models interactively
#'
#' Predicts two compatible models and displays an ensemble-weight slider.
#' Moving the slider combines the precomputed predictions without a server.
#'
#' @param model_a,model_b Fitted [nomad_model()] objects.
#' @param newdata Common prediction data, or NULL for the source setting.
#' @param weight Initial weight of model_b, between zero and one.
#' @param ... Arguments passed to prediction, including `unit` and `duration`.
#' @return An HTML widget. The display shows at most 12 busiest regions;
#'   reported totals include the complete matrices. Differences are ensemble minus A.
#' @export
compare_models <- function(model_a, model_b, newdata = NULL, weight = 0.5, ...) {
  if (!is.numeric(weight) || length(weight) != 1L || !is.finite(weight) ||
        weight < 0 || weight > 1) stop("weight must be between zero and one", call. = FALSE)
  ensemble <- nomad_ensemble(list(model_a, model_b), c(1 - weight, weight))
  combined <- stats::predict(ensemble, newdata = newdata, ...)
  a <- stats::predict(model_a, newdata = newdata, ...)
  b <- align_prediction(a, stats::predict(model_b, newdata = newdata, ...))
  if (length(dim(a)) != 2L) stop("Interactive comparison requires nsim = 1", call. = FALSE)
  if (any(!is.finite(a)) || any(!is.finite(b))) {
    stop("Interactive comparison requires finite predictions", call. = FALSE)
  }
  rows <- utils::head(order(rowSums(a + b), decreasing = TRUE), 12)
  cols <- utils::head(order(colSums(a + b), decreasing = TRUE), 12)
  matrix_rows <- function(x) lapply(rows, function(i) as.list(unname(x[i, cols])))
  htmlwidgets::createWidget(
    "nomad_comparison",
    list(a = matrix_rows(a), b = matrix_rows(b), rows = as.list(rownames(a)[rows]),
         cols = as.list(colnames(a)[cols]), total_a = sum(a), total_b = sum(b), weight = weight,
         label_a = model_a$get_model_name(), label_b = model_b$get_model_name(),
         period = attr(combined, "prediction_period_days")),
    width = "100%", height = 520, package = "nomad"
  )
}

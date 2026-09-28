#' Profile a fitted nomad model
#'
#' Summarises the source data and metadata attached to a fitted model. This is
#' useful for checking whether a prediction request is close to the setting used
#' to fit the model.
#'
#' @param model A [nomad_model()] object.
#'
#' @return A [tibble::tibble()] with one row.
#' @export
model_profile <- function(model) {
  assert_custom_class(model, "nomad_model")

  data <- model$get_model()$data
  metadata <- mobility_table(data_name = model$get_data_name())
  if (!nrow(metadata)) metadata <- list()
  duration <- source_duration_days(model)
  diagnostics <- fit_diagnostics(model$get_model(hydrate = FALSE))
  distance <- positive_values(data$D)
  population <- positive_values(data$N %||% data$N_orig)

  tibble::tibble(
    name = model$get_model_name(),
    data_name = model$get_data_name(),
    country = metadata$country %||% NA_character_,
    aggregation = metadata$aggregation %||% NA_character_,
    date_start = metadata$date_start %||% as.Date(NA),
    date_end = metadata$date_end %||% as.Date(NA),
    source_duration_days = duration %||% NA_real_,
    prediction_period_days = duration %||% NA_real_,
    distance_unit = model_distance_unit(model) %||% NA_character_,
    supports_newdata = model$get_model(hydrate = FALSE)$model != "radiation",
    supports_stochastic_draws = model$get_model(hydrate = FALSE)$model != "radiation",
    n_origin = data_dim(data$D, 1),
    n_dest = data_dim(data$D, 2),
    distance_min = data_quantile(distance, 0),
    distance_q25 = data_quantile(distance, 0.25),
    distance_median = data_quantile(distance, 0.5),
    distance_q75 = data_quantile(distance, 0.75),
    distance_max = data_quantile(distance, 1),
    population_total = data_sum(population),
    population_min = data_quantile(population, 0),
    population_median = data_quantile(population, 0.5),
    population_max = data_quantile(population, 1),
    max_rhat = diagnostics$max_rhat,
    min_n_eff = diagnostics$min_n_eff,
    rhat_above_1_1 = diagnostics$rhat_above_1_1,
    has_mobility_data = "M" %in% names(data),
    has_saved_check = !is.null(model$get_check_res())
  )
}

#' Suggest model weights from fit statistics
#'
#' Calculates transparent candidate weights from the model-fit statistics in
#' [model_table()]. These weights are intended as a starting point for
#' sensitivity analysis, not as a replacement for judgement about source data
#' relevance.
#'
#' @inheritParams model_table
#' @param metric Fit statistic used for weighting. `DIC`, `RMSE`, and `MAPE`
#'   treat lower values as better. `R2` treats higher values as better.
#'
#' @return A [tibble::tibble()] with one row per model and normalised `weight`.
#' @export
model_weights <- function(data_name = NULL,
                          country = NULL,
                          data_type = NULL,
                          aggregation = NULL,
                          mobility_model = NULL,
                          model_type = NULL,
                          metric = c("DIC", "RMSE", "MAPE", "R2")) {
  metric <- match.arg(metric)
  tbl <- model_table(
    data_name = data_name,
    country = country,
    data_type = data_type,
    aggregation = aggregation,
    mobility_model = mobility_model,
    model_type = model_type
  )
  if (!nrow(tbl)) {
    stop("No models matched the requested filters", call. = FALSE)
  }

  if (length(unique(tbl$data_name)) != 1L) {
    stop("Fit weights require models fitted to the same dataset; filter by data_name.",
         call. = FALSE)
  }
  values <- tbl[[metric]]
  if (any(!is.finite(values))) {
    stop(metric, " is missing or non-finite for: ",
         paste(tbl$name[!is.finite(values)], collapse = ", "),
         ". Choose an available metric or supply explicit ensemble weights.", call. = FALSE)
  }
  if (metric %in% c("RMSE", "MAPE") && any(values < 0)) {
    stop(metric, " cannot be negative", call. = FALSE)
  }
  if (metric %in% c("DIC", "RMSE", "MAPE")) {
    score <- lower_is_better_score(values, metric)
  } else {
    score <- pmax(values, 0)
  }

  if (sum(score) == 0) {
    stop("The requested metric gives no positive weights; supply explicit weights.", call. = FALSE)
  }

  tbl$weight_metric <- metric
  tbl$weight_score <- score
  tbl$weight <- score / sum(score)
  tbl
}

#' @noRd
lower_is_better_score <- function(values, metric) {
  if (metric == "DIC") {
    delta <- values - min(values, na.rm = TRUE)
    exp(-0.5 * delta)
  } else {
    if (any(values == 0)) as.numeric(values == 0) else min(values) / values
  }
}

#' @noRd
data_dim <- function(x, margin) {
  if (is.null(x)) {
    return(NA_integer_)
  }

  dim(x)[[margin]]
}

#' @noRd
data_quantile <- function(x, prob) {
  if (!length(x)) {
    return(NA_real_)
  }

  as.numeric(stats::quantile(x, probs = prob, names = FALSE, na.rm = TRUE))
}

#' @noRd
data_sum <- function(x) {
  if (!length(x)) {
    return(NA_real_)
  }

  sum(x, na.rm = TRUE)
}

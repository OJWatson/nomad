#' Query mobility datasets
#'
#' Returns the mobility dataset catalogue, optionally filtered by common fields
#' used when selecting an appropriate model.
#'
#' @param country Optional ISO3C country code or vector of codes.
#' @param data_name Optional mobility dataset name.
#' @param data_type Optional mobility data type, such as `"facebook"` or
#'   `"call data record"`.
#' @param aggregation Optional spatial aggregation level, such as `"admin_2"`.
#'
#' @return A [tibble::tibble()] containing rows from [nomad::mobility_db].
#' @export
mobility_table <- function(country = NULL,
                           data_name = NULL,
                           data_type = NULL,
                           aggregation = NULL) {
  out <- nomad::mobility_db

  if (!is.null(data_name)) {
    data_name_filter <- data_name
    out <- dplyr::filter(out, .data$name %in% data_name_filter)
  }
  if (!is.null(country)) {
    country_filter <- toupper(country)
    out <- dplyr::filter(out, .data$country %in% country_filter)
  }
  if (!is.null(data_type)) {
    data_type_filter <- data_type
    out <- dplyr::filter(out, .data$type %in% data_type_filter)
  }
  if (!is.null(aggregation)) {
    aggregation_filter <- aggregation
    out <- dplyr::filter(out, .data$aggregation %in% aggregation_filter)
  }

  tibble::as_tibble(out)
}

#' Query fitted nomad models
#'
#' Returns a table of fitted models in [nomad::model_db], their model-check
#' statistics, and the mobility dataset metadata they are linked to.
#'
#' @param data_name Optional mobility dataset name.
#' @param country Optional ISO3C country code or vector of codes.
#' @param data_type Optional mobility data type, such as `"facebook"` or
#'   `"call data record"`.
#' @param aggregation Optional spatial aggregation level, such as `"admin_2"`.
#' @param mobility_model Optional mobility model family, such as `"gravity"` or
#'   `"departure-diffusion"`.
#' @param model_type Optional model subtype, such as `"exp"`.
#'
#' @return A [tibble::tibble()] with one row per fitted model.
#' @export
model_table <- function(data_name = NULL,
                        country = NULL,
                        data_type = NULL,
                        aggregation = NULL,
                        mobility_model = NULL,
                        model_type = NULL) {
  out <- dplyr::bind_rows(lapply(names(nomad::model_db), model_table_row))

  mob <- dplyr::rename(
    nomad::mobility_db,
    data_name = "name",
    data_type = "type"
  )
  out <- dplyr::left_join(out, mob, by = "data_name")

  if (!is.null(data_name)) {
    data_name_filter <- data_name
    out <- dplyr::filter(out, .data$data_name %in% data_name_filter)
  }
  if (!is.null(country)) {
    country_filter <- toupper(country)
    out <- dplyr::filter(out, .data$country %in% country_filter)
  }
  if (!is.null(data_type)) {
    data_type_filter <- data_type
    out <- dplyr::filter(out, .data$data_type %in% data_type_filter)
  }
  if (!is.null(aggregation)) {
    aggregation_filter <- aggregation
    out <- dplyr::filter(out, .data$aggregation %in% aggregation_filter)
  }
  if (!is.null(mobility_model)) {
    mobility_model_filter <- mobility_model
    out <- dplyr::filter(out, .data$mobility_model %in% mobility_model_filter)
  }
  if (!is.null(model_type)) {
    model_type_filter <- model_type
    out <- dplyr::filter(out, .data$model_type %in% model_type_filter)
  }

  tibble::as_tibble(out)
}

#' @noRd
model_table_row <- function(name) {
  model <- nomad::model_db[[name]]
  fit <- check(model, plots = FALSE)
  underlying <- model$get_model(hydrate = FALSE)
  diagnostics <- fit_diagnostics(underlying)

  tibble::tibble(
    name = name,
    data_name = model$get_data_name(),
    mobility_model = underlying$model,
    model_type = underlying$type,
    hierarchical = isTRUE(underlying$hierarchical),
    max_rhat = diagnostics$max_rhat,
    min_n_eff = diagnostics$min_n_eff,
    rhat_above_1_1 = diagnostics$rhat_above_1_1,
    supports_newdata = underlying$model != "radiation",
    supports_stochastic_draws = underlying$model != "radiation",
    DIC = fit_value(fit, "DIC"),
    RMSE = fit_value(fit, "RMSE"),
    MAPE = fit_value(fit, "MAPE"),
    R2 = fit_value(fit, "R2")
  )
}

#' @noRd
fit_value <- function(fit, name) {
  value <- fit[[name]]
  if (is.null(value) || !length(value)) {
    return(NA_real_)
  }

  as.numeric(value[[1]])
}

#' @noRd
fit_diagnostics <- function(model) {
  statistic <- function(field, fun) {
    x <- model$summary
    if (is.null(x) || !field %in% colnames(x)) return(NA_real_)
    values <- x[, field]
    values <- values[is.finite(values)]
    if (!length(values)) NA_real_ else fun(values)
  }
  rhat <- statistic("Rhat", max)
  list(max_rhat = rhat, min_n_eff = statistic("n.eff", min), rhat_above_1_1 = rhat > 1.1)
}

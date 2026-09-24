#' @noRd
scale_prediction_duration <- function(x,
                                      object,
                                      duration = NULL,
                                      date_start = NULL,
                                      date_end = NULL) {
  requested <- requested_duration_days(duration, date_start, date_end)
  source <- source_duration_days(object)
  if (is.null(source)) {
    if (!is.null(requested)) {
      stop("Cannot scale ", object$get_model_name(),
           ": its prediction period is unknown. Omit duration for an unscaled prediction.",
           call. = FALSE)
    }
    nomad_warn("The model prediction period is unknown; returning unscaled predictions.",
               class = "nomad_warning_duration")
  }
  warn_prediction_period(object, date_start, date_end)
  scale <- if (is.null(requested)) 1 else requested / source
  out <- x * scale
  attr(out, "requested_duration_days") <- requested
  attr(out, "source_duration_days") <- source %||% NA_real_
  attr(out, "prediction_period_days") <- requested %||% source %||% NA_real_
  attr(out, "duration_scale") <- scale
  attr(out, "data_name") <- object$get_data_name()
  out
}

#' @noRd
warn_prediction_period <- function(object, date_start = NULL, date_end = NULL) {
  if (is.null(date_start) || is.null(date_end)) {
    return(invisible(NULL))
  }

  metadata <- mobility_table(data_name = object$get_data_name())
  if (nrow(metadata) != 1L || is.na(metadata$date_start) ||
        is.na(metadata$date_end)) {
    return(invisible(NULL))
  }

  date_start <- as.Date(date_start)
  date_end <- as.Date(date_end)
  if (date_start < metadata$date_start || date_end > metadata$date_end) {
    nomad_warn(
      c(
        "!" = "Requested prediction dates fall outside the fitted model source period.",
        "i" = sprintf(
          "Requested period: {.val %s} to {.val %s}; source period: {.val %s} to {.val %s}.",
          date_start,
          date_end,
          metadata$date_start,
          metadata$date_end
        ),
        "*" = "Duration scaling is linear and does not account for seasonal or behavioural changes."
      ),
      class = "nomad_warning_prediction_period"
    )
  }

  invisible(NULL)
}

#' @noRd
requested_duration_days <- function(duration = NULL,
                                    date_start = NULL,
                                    date_end = NULL) {
  if (!is.null(duration)) {
    if (!is.null(date_start) || !is.null(date_end)) {
      days <- duration_from_dates(date_start, date_end)
      if (as_duration_days(duration) != days) {
        stop("duration must agree with date_start and date_end", call. = FALSE)
      }
    }
    return(as_duration_days(duration))
  }

  if (is.null(date_start) && is.null(date_end)) {
    return(NULL)
  }

  duration_from_dates(date_start, date_end)
}

#' @noRd
source_duration_days <- function(object) {
  data <- mobility_table(data_name = object$get_data_name())
  days <- data$prediction_period_days
  if (length(days) != 1L || is.na(days)) return(NULL)
  as_duration_days(days)
}

#' @noRd
duration_from_dates <- function(date_start, date_end) {
  if (length(date_start) != 1L || length(date_end) != 1L ||
        is.na(date_start) || is.na(date_end)) {
    stop("Supply both date_start and date_end as single non-missing dates", call. = FALSE)
  }

  date_start <- as.Date(date_start)
  date_end <- as.Date(date_end)
  days <- as.numeric(date_end - date_start) + 1
  if (!is.finite(days) || days <= 0) {
    stop("date_end must be on or after date_start", call. = FALSE)
  }

  days
}

#' @noRd
as_duration_days <- function(duration) {
  if (inherits(duration, "difftime")) {
    duration <- as.numeric(duration, units = "days")
  }

  if (!is.numeric(duration) || length(duration) != 1L || is.na(duration) ||
        !is.finite(duration) || duration <= 0) {
    stop("duration must be a positive number of days", call. = FALSE)
  }

  as.numeric(duration)
}

#' @noRd
check_prediction_data <- function(object,
                                  newdata = NULL,
                                  locations = NULL,
                                  unit = NULL) {
  if (is.null(newdata)) {
    return(invisible(NULL))
  }

  source <- prediction_profile(object$get_model()$data)
  source_model <- model_profile(object)
  source$country <- source_model$country
  source$aggregation <- source_model$aggregation
  requested <- prediction_profile(newdata)

  warn_distance_scale(source, requested, unit)
  warn_region_count(source, requested)
  warn_population_scale(source, requested)
  warn_country_mismatch(object, newdata, locations)

  invisible(NULL)
}

#' @noRd
prediction_profile <- function(data) {
  D <- data$D
  N <- data$N %||% data$N_orig

  list(
    n = if (is.null(D)) NA_integer_ else nrow(D),
    distance = positive_values(D),
    population = positive_values(N)
  )
}

#' @noRd
positive_values <- function(x) {
  if (is.null(x)) {
    return(numeric())
  }

  x <- as.numeric(x)
  x[is.finite(x) & !is.na(x) & x > 0]
}

#' @noRd
warn_distance_scale <- function(source, requested, unit) {
  if (!length(source$distance) || !length(requested$distance)) {
    return(invisible(NULL))
  }

  source_median <- stats::median(source$distance)
  requested_median <- stats::median(requested$distance)
  ratio <- requested_median / source_median

  if (is.finite(ratio) && ratio < 0.1) {
    nomad_warn(
      c(
        "!" = "Prediction distances look much smaller than the fitted source data.",
        "i" = sprintf(
          "Median distance in {.code newdata$D}: {.val %s}; fitted model median: {.val %s%s}.",
          format(requested_median, digits = 3),
          format(source_median, digits = 3),
          unit_label(unit)
        ),
        "i" = sprintf(
          "This model was fitted to {.val %s} data, so predictions may be too fine-grained.",
          source_aggregation(source)
        ),
        "*" = "Check that your regions match the spatial scale of the source data."
      ),
      class = "nomad_warning_distance_scale"
    )
  } else if (is.finite(ratio) && ratio > 10) {
    nomad_warn(
      c(
        "!" = "Prediction distances look much larger than the fitted source data.",
        "i" = sprintf(
          "Median distance in {.code newdata$D}: {.val %s}; fitted model median: {.val %s%s}.",
          format(requested_median, digits = 3),
          format(source_median, digits = 3),
          unit_label(unit)
        ),
        "i" = sprintf(
          "This model was fitted to {.val %s} data, so predictions may be too coarse.",
          source_aggregation(source)
        ),
        "*" = "Check that your regions match the spatial scale of the source data."
      ),
      class = "nomad_warning_distance_scale"
    )
  }

  invisible(NULL)
}

#' @noRd
source_aggregation <- function(source) {
  if (is.null(source$aggregation) || is.na(source$aggregation)) {
    return("the source aggregation")
  }

  source$aggregation
}

#' @noRd
unit_label <- function(unit) {
  if (is.null(unit)) {
    return("")
  }

  paste0(" ", unit)
}

#' @noRd
warn_region_count <- function(source, requested) {
  if (is.na(source$n) || is.na(requested$n) || source$n == 0) {
    return(invisible(NULL))
  }

  ratio <- requested$n / source$n
  if (ratio < 0.2) {
    nomad_warn(
      c(
        "!" = "Prediction data have far fewer regions than the fitted source data.",
        "i" = sprintf(
          "{.code newdata} has {.val %s} regions; the fitted model has {.val %s}.",
          requested$n,
          source$n
        ),
        "*" = "Predictions may be coarser than the source data can support."
      ),
      class = "nomad_warning_region_count"
    )
  } else if (ratio > 5) {
    nomad_warn(
      c(
        "!" = "Prediction data have far more regions than the fitted source data.",
        "i" = sprintf(
          "{.code newdata} has {.val %s} regions; the fitted model has {.val %s}.",
          requested$n,
          source$n
        ),
        "*" = "Predictions may be finer than the source data can support."
      ),
      class = "nomad_warning_region_count"
    )
  }

  invisible(NULL)
}

#' @noRd
warn_population_scale <- function(source, requested) {
  if (!length(source$population) || !length(requested$population)) {
    return(invisible(NULL))
  }

  source_total <- sum(source$population)
  requested_total <- sum(requested$population)
  ratio <- requested_total / source_total

  if (is.finite(ratio) && ratio < 0.25) {
    nomad_warn(
      c(
        "!" = "Prediction population is much smaller than the fitted source population.",
        "i" = sprintf(
          "{.code newdata} population: {.val %s}; fitted model source population: {.val %s}.",
          format(requested_total, digits = 3),
          format(source_total, digits = 3)
        ),
        "*" = "Check that this model is suitable for the population scale being predicted."
      ),
      class = "nomad_warning_population_scale"
    )
  } else if (is.finite(ratio) && ratio > 4) {
    nomad_warn(
      c(
        "!" = "Prediction population is much larger than the fitted source population.",
        "i" = sprintf(
          "{.code newdata} population: {.val %s}; fitted model source population: {.val %s}.",
          format(requested_total, digits = 3),
          format(source_total, digits = 3)
        ),
        "*" = "Check that this model is suitable for the population scale being predicted."
      ),
      class = "nomad_warning_population_scale"
    )
  }

  invisible(NULL)
}

#' @noRd
warn_country_mismatch <- function(object, newdata, locations) {
  locations <- locations %||% newdata$locations %||% newdata$coords
  countries <- location_countries(locations)
  if (!length(countries)) {
    return(invisible(NULL))
  }

  countries <- unique(countries[!is.na(countries)])
  source_country <- mobility_table(data_name = object$get_data_name())$country
  if (length(countries) > 1L) {
    nomad_warn(
      c(
        "!" = "Prediction locations appear to span more than one country.",
        "i" = sprintf("Detected countries: {.val %s}.", paste(countries, collapse = ", ")),
        "*" = "Bundled models do not represent cross-border travel; use an appropriate model."
      ),
      class = "nomad_warning_country_mismatch"
    )
  } else if (length(source_country) == 1L && countries != source_country) {
    nomad_warn(
      c(
        "!" = "Prediction locations appear to be in a different country from the fitted model.",
        "i" = sprintf(
          "Prediction country: {.val %s}; fitted mobility data country: {.val %s}.",
          countries,
          source_country
        ),
        "*" = "Check that the selected model is appropriate before using these predictions."
      ),
      class = "nomad_warning_country_mismatch"
    )
  }

  invisible(NULL)
}

#' @noRd
location_countries <- function(locations) {
  if (is.null(locations) || !requireNamespace("rnaturalearth", quietly = TRUE)) {
    return(character())
  }

  locations <- locations_as_sf(locations)
  if (is.null(locations)) {
    return(character())
  }

  world <- rnaturalearth::ne_countries(scale = "small", returnclass = "sf")
  locations <- sf::st_transform(locations, sf::st_crs(world))
  old_s2 <- sf::sf_use_s2(FALSE)
  on.exit(sf::sf_use_s2(old_s2), add = TRUE)
  hits <- sf::st_intersects(locations, world)
  unique(world$iso_a3[unlist(hits)])
}

#' @noRd
locations_as_sf <- function(locations) {
  if (inherits(locations, "sf")) {
    return(locations)
  }

  if (is.matrix(locations)) {
    locations <- as.data.frame(locations)
  }

  if (!is.data.frame(locations)) {
    return(NULL)
  }

  nms <- names(locations)
  lon <- intersect(c("lon", "long", "longitude", "x"), nms)[1]
  lat <- intersect(c("lat", "latitude", "y"), nms)[1]
  if (is.na(lon) || is.na(lat)) {
    return(NULL)
  }

  sf::st_as_sf(locations, coords = c(lon, lat), crs = 4326)
}

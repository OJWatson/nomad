
#' Get population raster.
#'
#' Downloads the unconstrained individual countries 2000-2020 UN adjusted
#' (1km resolution) from the \href{https://www.worldpop.org/}{WorldPop server}.
#'
#' @param iso3c ISO3c Code
#' @param year Year of World Pop Survey
#'
#' @return Population raster
#' @importFrom rlang .data
#' @export
get_pop <- function(iso3c, year) {

  if (!is.character(iso3c) || length(iso3c) != 1L || is.na(iso3c) ||
        !grepl("^[A-Za-z]{3}$", iso3c)) stop("iso3c must be a three-letter code", call. = FALSE)
  if (!is.numeric(year) || length(year) != 1L || !is.finite(year) || year != round(year)) {
    stop("year must be a single integer", call. = FALSE)
  }
  iso3c <- toupper(iso3c)
  raster_meta <- population_metadata(iso3c)
  rows <- raster_meta$data
  if (is.null(rows) || !all(c("popyear", "files") %in% names(rows))) {
    stop("WorldPop returned no population metadata for ", iso3c, call. = FALSE)
  }
  files <- unique(unlist(rows$files[which(rows$popyear == year)]))
  files <- files[grepl("\\.tif($|\\?)", files)]
  if (length(files) != 1L) {
    stop("Expected one WorldPop raster for ", iso3c, " in ", year,
         "; found ", length(files), call. = FALSE)
  }
  raster_address <- tempfile(paste0(iso3c, "_", year, "_"), fileext = ".tif")
  download_population(files, raster_address)
  pop <- terra::rast(raster_address)
  names(pop) <- "pop"

  pop
}

#' Extract information from rasters
#'
#' @param iso3c_sf A simple feature shape file to extract for
#' @param pop The pop raster from \code{\link{get_pop}}
#'
#' @return Tibble with list columns of raw extracted values
#' @export
unpack_pop <- function(iso3c_sf, pop) {

  sitesv <- methods::as(iso3c_sf, "SpatVector")

  raw_values <- terra::extract(x = pop, y = sitesv) %>%
    dplyr::group_by(.data$ID) %>%
    dplyr::summarise(dplyr::across(dplyr::everything(), list)) %>%
    dplyr::select(-"ID") %>%
    dplyr::ungroup()

  sf_tibble <- tibble::as_tibble(sf::st_drop_geometry(iso3c_sf))
  out <- dplyr::bind_cols(sf_tibble, raw_values)

  out
}

#' @noRd
population_metadata <- function(iso3c) {
  url <- "https://www.worldpop.org/rest/data/pop/wpicuadj1km?iso3="
  jsonlite::fromJSON(paste0(url, iso3c))
}

#' @noRd
download_population <- function(url, destfile) {
  utils::download.file(url, destfile, mode = "wb")
}

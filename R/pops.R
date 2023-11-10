
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

  u <- "https://www.worldpop.org/rest/data/pop/wpicuadj1km?iso3="
  raster_meta <- jsonlite::fromJSON(paste0(u, iso3c))

  raster_files <- raster_meta$data %>%
    dplyr::filter(.data$popyear == year) %>%
    dplyr::select(.data$files) %>%
    unlist()

  raster_file <- raster_files[grepl(".tif", raster_files)]

  td <- tempdir()
  raster_address <- paste0(td, "/", iso3c, ".tif")
  df <- utils::download.file(url = raster_file, destfile = raster_address, mode = "wb")
  pop <- terra::rast(raster_address)
  names(pop) <- "pop"

  return(pop)
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
    dplyr::select(-(.data$ID)) %>%
    dplyr::ungroup()

  sf_tibble <- tibble::as_tibble(sf::st_drop_geometry(iso3c_sf))
  out <- dplyr::bind_cols(sf_tibble, raw_values)

  return(out)
}

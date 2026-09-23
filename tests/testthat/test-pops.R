test_that("population extraction preserves polygon identity and cell counts", {
  raster <- terra::rast(nrows = 2, ncols = 2, xmin = 0, xmax = 2, ymin = 0, ymax = 2,
                        crs = "EPSG:4326")
  terra::values(raster) <- c(1, 2, 3, 4)
  names(raster) <- "pop"
  left <- sf::st_polygon(list(rbind(c(0, 0), c(1, 0), c(1, 2), c(0, 2), c(0, 0))))
  right <- sf::st_polygon(list(rbind(c(1, 0), c(2, 0), c(2, 2), c(1, 2), c(1, 0))))
  regions <- sf::st_sf(region = c("left", "right"), geometry = sf::st_sfc(left, right, crs = 4326))
  out <- unpack_pop(regions, raster)
  expect_equal(out$region, c("left", "right"))
  expect_equal(vapply(out$pop, sum, numeric(1)), c(4, 6))
})

test_that("population downloads select exactly one requested country-year", {
  raster <- terra::rast(nrows = 1, ncols = 1)
  terra::values(raster) <- 12
  fixture <- tempfile(fileext = ".tif")
  terra::writeRaster(raster, fixture)
  testthat::local_mocked_bindings(
    population_metadata = function(iso3c) {
      expect_equal(iso3c, "ZMB")
      list(data = data.frame(popyear = c(2019, 2020),
                             files = I(list("https://example.org/old.tif",
                                            "https://example.org/selected.tif"))))
    },
    download_population = function(url, destfile) {
      expect_equal(url, "https://example.org/selected.tif")
      file.copy(fixture, destfile)
    }
  )
  expect_equal(as.numeric(terra::values(get_pop("zmb", 2020))), 12)
  expect_error(get_pop("ZMB", 2050), "found 0")
  expect_error(get_pop("Zambia", 2020), "three-letter")
})

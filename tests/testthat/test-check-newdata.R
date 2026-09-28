context("check newdata")

test_that("prediction checks warn for mismatched distance and population scale", {
  mod <- nomad::model_db$zmb_fb_2020_mod_grav_exp

  D <- matrix(c(0, 1, 1, 0), nrow = 2)
  dimnames(D) <- list(c("a", "b"), c("a", "b"))
  N <- c(a = 100, b = 100)

  expect_warning(
    check_prediction_data(mod, list(D = D, N = N)),
    class = "nomad_warning_distance_scale"
  )
  expect_warning(
    check_prediction_data(mod, list(D = D, N = N)),
    class = "nomad_warning_region_count"
  )
  expect_warning(
    check_prediction_data(mod, list(D = D, N = N)),
    class = "nomad_warning_population_scale"
  )
})

test_that("prediction checks warn for country mismatch and border crossing", {
  testthat::skip_if_not_installed("rnaturalearth")

  mod <- nomad::model_db$zmb_cdr_2020_mod_dd_exp
  newdata <- mod$get_model()$data

  expect_warning(
    check_prediction_data(
      mod,
      newdata,
      locations = data.frame(lon = 36.8, lat = -1.3)
    ),
    class = "nomad_warning_country_mismatch"
  )

  expect_warning(
    check_prediction_data(
      mod,
      newdata,
      locations = data.frame(lon = c(28.3, 36.8), lat = c(-15.4, -1.3))
    ),
    class = "nomad_warning_country_mismatch"
  )
})

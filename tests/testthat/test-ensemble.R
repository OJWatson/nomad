context("ensemble")

test_that("nomad_ensemble stores normalised weights", {
  mod <- nomad::model_db$zmb_fb_2020_mod_grav_exp
  ens <- nomad_ensemble(list(a = mod, b = mod), weights = c(1, 3))

  expect_s3_class(ens, "nomad_ensemble")
  expect_equal(ens$weights, c(0.25, 0.75))
  expect_error(nomad_ensemble(list(mod), weights = c(-1)), "weights")
})

test_that("weighted_prediction combines equal-shaped predictions", {
  a <- matrix(1, 2, 2)
  b <- matrix(3, 2, 2)
  out <- weighted_prediction(list(a, b), c(0.25, 0.75))

  expect_equal(as.numeric(out), as.numeric(matrix(2.5, 2, 2)))
  expect_equal(attr(out, "weights"), c(0.25, 0.75))
  expect_error(weighted_prediction(list(a, matrix(1, 3, 3)), c(0.5, 0.5)),
               "same dimensions")
})

test_that("predict.nomad_ensemble returns weighted prediction", {
  mod <- nomad::model_db$zmb_fb_2020_mod_grav_exp
  ens <- nomad_ensemble(list(mod, mod), weights = c(0.25, 0.75))

  expect_warning(out <- predict(ens), class = "nomad_warning_duration")
  expect_warning(ref <- predict(mod), class = "nomad_warning_duration")

  expect_equal(as.numeric(out), as.numeric(ref))
  expect_equal(attr(out, "weights"), c(0.25, 0.75))
})

test_that("prediction_difference calculates absolute and relative differences", {
  x <- matrix(c(2, 4, 6, 8), 2, 2)
  y <- matrix(c(1, 2, 3, 4), 2, 2)

  expect_equal(prediction_difference(x, y), y)
  expect_equal(prediction_difference(x, y, relative = TRUE), matrix(1, 2, 2))
  expect_error(prediction_difference(x, matrix(1, 3, 3)), "same dimensions")
})

test_that("plot_prediction_difference returns difference invisibly", {
  x <- matrix(2, 2, 2)
  y <- matrix(1, 2, 2)

  grDevices::pdf(tempfile(fileext = ".pdf"))
  on.exit(grDevices::dev.off(), add = TRUE)
  expect_silent(out <- plot_prediction_difference(x, y))
  expect_equal(out, matrix(1, 2, 2))
})


test_that("named weights and target identities determine ensemble results", {
  mods <- model_db[c("com_fb_2025_mod_grav_exp", "com_fb_2025_mod_dd_exp")]
  w <- data.frame(name = rev(names(mods)), weight = c(1, 3))
  expect_equal(nomad_ensemble(mods, w)$weights, c(0.75, 0.25))
  expect_error(nomad_ensemble(mods, c(Inf, 1)), "finite")
  a <- matrix(c(0, 20, 10, 0), 2, dimnames = list(c("a", "b"), c("a", "b")))
  b <- a[2:1, 2:1]
  expect_equal(as.numeric(weighted_prediction(list(a, b), c(0.5, 0.5))), as.numeric(a))
  expect_equal(prediction_difference(a, b), a * 0)
  dimnames(b) <- list(c("x", "y"), c("x", "y"))
  expect_error(prediction_difference(a, b), "same target")
  expect_warning(out <- prediction_difference(a, a, relative = TRUE), "baseline is zero")
  expect_true(all(is.na(diag(out))))
})

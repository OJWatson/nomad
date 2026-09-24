context("models")

## Code to add zmb_cdr_2020 models to database
test_that("model creation work", {

  # read inn pre built for ease
  mod <- readRDS("zmb_cdr_2020_mod_dd_exp.rds")

  # Convert to nomad model
  zmb_cdr_2020_mod_dd_exp <- nomad::nomad_model(
    model = mod,
    data_name = "zmb_cdr_2020"
  )

  # Add to the model database
  model_db <- nomad:::add_model_to_db(zmb_cdr_2020_mod_dd_exp)
  expect_s3_class(model_db$zmb_cdr_2020_mod_dd_exp, "nomad_model")


})

test_that("model summaries etc work", {

  # read inn pre built for ease
  mod <- nomad::model_db$zmb_fb_2020_mod_grav_exp

  grDevices::pdf(tempfile(fileext = ".pdf"))
  on.exit(grDevices::dev.off(), add = TRUE)

  check_out <- check(mod)
  capture <- recordPlot()

  # check it prduced a plot
  expect_true(class(capture) == "recordedplot")

  # check the check was right
  expect_true(all(names(check_out) == c("DIC", "RMSE", "MAPE", "R2")))

  # check print produces
  expect_output(print(mod))

  # check plot method produces
  expect_silent(plot(mod))
  capture <- recordPlot()
  expect_true(class(capture) == "recordedplot")

  # check summary
  summod <- summary(mod)
  expect_is(summod, "data.frame")

  # check predict
  expect_warning(pred <- predict(mod), class = "nomad_warning_duration")
  expect_is(pred, "matrix")
  expect_true(attr(pred, "model") == "gravity")
})

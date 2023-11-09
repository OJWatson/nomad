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

  # Update the package model database
  # usethis::use_data(model_db, overwrite = TRUE)

})

test_that("model summaries etc work", {

  # read inn pre built for ease
  mod <- nomad::model_db$zmb_fb_2020_mod_grav_exp

  check_out <- check(mod)
  capture <- recordPlot()

  # check it prduced a plot
  expect_true(class(capture) == "recordedplot")

  # check the check was right
  expect_true(all(names(check_out) == c("DIC", "RMSE", "MAPE", "R2")))

  # check print produces
  expect_message(print(mod))

  # check summary
  summod <- summary(mod)
  expect_is(summod, "data.frame")

  # check predict
  pred <- predict(mod)
  expect_is(pred, "matrix")
  expect_true(attr(pred, "model") == "gravity")
})

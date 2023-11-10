context("database")

## Code to add zmb_cdr_2020 models to database
test_that("database", {

  # read in pre built for ease
  model_db <- add_model_to_db(nomad::model_db$zmb_cdr_2020_mod_dd_exp, "test")
  expect_true("test" %in% names(model_db))

  model <- remake_model_in_db(model_db$test)

})

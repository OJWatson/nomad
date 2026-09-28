context("profile")

test_that("model_profile describes source data", {
  prof <- model_profile(nomad::model_db$zmb_cdr_2020_mod_dd_exp)

  expect_s3_class(prof, "tbl_df")
  expect_equal(prof$name, "zmb_cdr_2020_mod_dd_exp")
  expect_equal(prof$country, "ZMB")
  expect_equal(prof$aggregation, "admin_2")
  expect_true(is.na(prof$source_duration_days))
  expect_equal(prof$n_origin, 107)
  expect_true(prof$distance_median > 0)
  expect_true(prof$population_total > 0)
})

test_that("model_weights returns normalised candidate weights", {
  w <- model_weights(data_name = "zmb_fb_2025", metric = "RMSE")

  expect_s3_class(w, "tbl_df")
  expect_equal(sum(w$weight), 1)
  expect_true(all(w$weight >= 0))
  expect_true(all(c("weight_metric", "weight_score", "weight") %in% names(w)))

  one <- model_weights(data_name = "zmb_fb_2020", mobility_model = "gravity",
                       metric = "R2")
  expect_equal(one$name, "zmb_fb_2020_mod_grav_exp")
  expect_equal(one$weight, 1)
})

test_that("nomad_ensemble accepts model_weights output", {
  mod <- nomad::model_db$zmb_fb_2020_mod_grav_exp
  weights <- model_weights(data_name = "zmb_fb_2020", mobility_model = "gravity")

  ens <- nomad_ensemble(list(mod), weights = weights)
  expect_equal(ens$weights, 1)
})


test_that("missing metrics and cross-dataset fit weighting fail", {
  expect_error(model_weights(data_name = "com_fb_2025"), "DIC is missing")
  expect_error(model_weights(country = "ZMB", metric = "RMSE"), "same dataset")
  expect_equal(lower_is_better_score(c(0, 1), "RMSE"), c(1, 0))
})

test_that("one missing DIC cannot silently exclude a candidate", {
  testthat::local_mocked_bindings(model_table = function(...) {
    data.frame(name = c("a", "b"), data_name = "same", DIC = c(1, NA_real_))
  })
  expect_error(model_weights(), "DIC is missing or non-finite for: b")
})

test_that("stored convergence diagnostics are exposed without claiming convergence", {
  flagged <- model_profile(model_db$civ_fb_2025_mod_grav_exp)
  expect_equal(flagged$max_rhat, 20.3)
  expect_true(flagged$rhat_above_1_1)
  no_mcmc <- model_profile(model_db$com_fb_2025_mod_rad_basic)
  expect_true(is.na(no_mcmc$max_rhat))
  expect_true(is.na(no_mcmc$rhat_above_1_1))
})

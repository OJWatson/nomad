context("tables")

test_that("mobility_table filters mobility data", {
  tbl <- mobility_table(country = "zmb")

  expect_s3_class(tbl, "tbl_df")
  expect_true(all(tbl$country == "ZMB"))
  expect_true(all(c("zmb_cdr_2020", "zmb_fb_2020") %in% tbl$name))

  fb <- mobility_table(country = "ZMB", data_type = "facebook")
  expect_true(all(c("zmb_fb_2020", "zmb_fb_2025") %in% fb$name))

  cdr <- mobility_table(data_name = "zmb_cdr_2020")
  expect_equal(cdr$name, "zmb_cdr_2020")
})

test_that("model_table joins model checks and mobility metadata", {
  tbl <- model_table(country = "ZMB")

  expect_s3_class(tbl, "tbl_df")
  expect_true(all(c("name", "data_name", "mobility_model", "model_type",
                    "DIC", "RMSE", "MAPE", "R2", "country",
                    "aggregation") %in% names(tbl)))
  expect_equal(nrow(tbl), 14)
  expect_true(all(c("zmb_cdr_2020", "zmb_fb_2020", "zmb_fb_2025") %in% tbl$data_name))

  grav <- model_table(data_name = "zmb_fb_2020", mobility_model = "gravity")
  expect_equal(grav$name, "zmb_fb_2020_mod_grav_exp")
})

test_that("model names are generated from model metadata", {
  expect_equal(
    nomad::model_db$zmb_cdr_2020_mod_dd_exp$get_model_name(),
    "zmb_cdr_2020_mod_dd_exp"
  )
  expect_equal(
    nomad::model_db$zmb_fb_2020_mod_grav_exp$get_model_name(),
    "zmb_fb_2020_mod_grav_exp"
  )
})

test_that("catalogue availability and prediction periods match the fitted database", {
  missing <- mobility_table()[!mobility_table()$has_fitted_models, ]
  expect_setequal(missing$name, c("ken_cdr_2009", "nam_cdr_2014", "bfa_cdr_2016"))
  fb <- mobility_table(data_type = "facebook")
  new <- fb[grepl("2025$", fb$name), ]
  expect_equal(nrow(new), 51)
  expect_true(all(new$prediction_period_days == 21))
  expect_true(all(new$distance_unit == "m"))
  expect_setequal(new$country[new$aggregation == "admin_1"],
                  c("CPV", "COM", "LSO", "LBY", "MUS", "MYT", "SYC"))
})

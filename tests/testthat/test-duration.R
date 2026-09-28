test_that("prediction periods are independent of collection dates", {
  mod <- model_db$com_fb_2025_mod_grav_exp
  x <- matrix(1:4, 2)
  for (days in c(7, 21, 42)) {
    out <- scale_prediction_duration(x, mod, duration = days)
    expect_equal(as.numeric(out), as.numeric(x * days / 21))
    expect_equal(attr(out, "source_duration_days"), 21)
    expect_equal(attr(out, "prediction_period_days"), days)
  }
  expect_warning(warn_prediction_period(mod, "2026-01-01", "2026-01-31"),
                 class = "nomad_warning_prediction_period")
})

test_that("unknown periods cannot be scaled", {
  for (id in c("zmb_cdr_2020_mod_dd_exp", "zmb_fb_2020_mod_grav_exp")) {
    mod <- model_db[[id]]
    expect_error(predict(mod, duration = 10), "prediction period is unknown")
    expect_warning(out <- predict(mod), class = "nomad_warning_duration")
    expect_true(is.na(attr(out, "prediction_period_days")))
  }
})

test_that("requested dates and durations must be valid and consistent", {
  expect_equal(requested_duration_days(date_start = "2020-01-01", date_end = "2020-01-31"), 31)
  expect_error(requested_duration_days(duration = 0), "positive")
  expect_error(requested_duration_days(date_start = "2020-01-01"), "both")
  expect_error(requested_duration_days(date_start = "2020-02-01", date_end = "2020-01-31"),
               "on or after")
  expect_error(requested_duration_days(2, "2020-01-01", "2020-01-31"), "agree")
})

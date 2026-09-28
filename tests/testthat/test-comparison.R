test_that("interactive comparison retains full totals and labelled predictions", {
  a <- model_db$com_fb_2025_mod_grav_exp
  b <- model_db$com_fb_2025_mod_dd_exp
  widget <- compare_models(a, b)
  expect_s3_class(widget, "htmlwidget")
  expect_equal(widget$x$total_a, sum(predict(a)))
  expect_equal(widget$x$total_b, sum(predict(b)))
  expect_equal(widget$x$period, 21)
  expect_error(compare_models(a, b, weight = Inf), "between")
})

#------------------------------------------------
test_that("assert_custom_class working correctly", {
  expect_true(assert_custom_class(NULL, "NULL"))
  expect_true(assert_custom_class(data.frame(1:5), "data.frame"))

  expect_error(assert_custom_class(NULL, "foo"))
  expect_error(assert_custom_class(data.frame(1:5), "foo"))
})

#------------------------------------------------
test_that("assert_string working correctly", {
  expect_true(assert_string("foo"))
  expect_true(assert_string(c("foo", "bar")))

  expect_error(assert_string(NULL))
  expect_error(assert_string(5))
  expect_error(assert_string(1:5))
})

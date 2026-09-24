context("uncertainty")

test_that("mobility_metrics works for matrices and arrays", {
  mat <- matrix(1:4, nrow = 2)
  one <- mobility_metrics(mat)

  expect_s3_class(one, "tbl_df")
  expect_equal(one$total, 10)
  expect_equal(one$within_region, 5)
  expect_equal(one$between_region, 5)

  arr <- array(c(mat, mat * 2), dim = c(2, 2, 2))
  many <- mobility_metrics(arr)
  expect_equal(many$simulation, 1:2)
  expect_equal(many$total, c(10, 20))
})

test_that("uncertainty_matrices selects matrices by metric quantiles", {
  arr <- array(0, dim = c(2, 2, 3))
  arr[, , 1] <- matrix(1, 2, 2)
  arr[, , 2] <- matrix(5, 2, 2)
  arr[, , 3] <- matrix(10, 2, 2)

  selected <- uncertainty_matrices(arr, probs = c(0, 0.5, 1))

  expect_equal(names(selected), c("q0", "q0.5", "q1"))
  expect_equal(selected[[1]], arr[, , 1])
  expect_equal(selected[[2]], arr[, , 2])
  expect_equal(selected[[3]], arr[, , 3])
  expect_s3_class(attr(selected, "metrics"), "tbl_df")
  expect_s3_class(attr(selected, "selected"), "tbl_df")
  expect_equal(attr(selected, "selected")$simulation, 1:3)
})

test_that("plot_uncertainty returns selected matrices invisibly", {
  arr <- array(1:12, dim = c(2, 2, 3))

  grDevices::pdf(tempfile(fileext = ".pdf"))
  on.exit(grDevices::dev.off(), add = TRUE)
  expect_silent(out <- plot_uncertainty(arr, probs = c(0, 1)))
  expect_equal(length(out), 2)
})

test_that("uncertainty_summary returns quantiles by metric", {
  arr <- array(0, dim = c(2, 2, 3))
  arr[, , 1] <- matrix(1, 2, 2)
  arr[, , 2] <- matrix(5, 2, 2)
  arr[, , 3] <- matrix(10, 2, 2)

  out <- uncertainty_summary(arr, metrics = "total", probs = c(0, 0.5, 1))

  expect_s3_class(out, "tbl_df")
  expect_equal(out$metric, rep("total", 3))
  expect_equal(out$value, c(4, 20, 40))
  expect_error(uncertainty_summary(arr, metrics = "missing"), "metrics")
})

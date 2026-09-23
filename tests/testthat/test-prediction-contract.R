test_that("radiation rejects changed settings directly and in ensembles", {
  mod <- model_db$com_fb_2025_mod_rad_basic
  dat <- mod$get_model()$data[c("D", "N_orig", "N_dest")]
  ref <- predict(mod)
  expect_equal(as.numeric(predict(mod, newdata = dat)), as.numeric(ref))
  ids <- rev(rownames(dat$D))
  dat$D <- dat$D[ids, ids]
  dat$N_orig <- dat$N_orig[ids]
  dat$N_dest <- dat$N_dest[ids]
  expect_equal(as.numeric(predict(mod, newdata = dat)), as.numeric(ref[ids, ids]))
  dat$N_orig <- dat$N_orig * 2
  expect_error(predict(mod, newdata = dat), "original regions")
  expect_error(predict(nomad_ensemble(list(mod)), newdata = dat), "original regions")
  expect_error(predict(mod, nsim = 2), "parameter-free")
})

test_that("departure-diffusion recomputes intervening population without mutating source", {
  mod <- model_db$com_fb_2025_mod_dd_radiation
  original <- mod$get_model()$data$S
  D <- as.matrix(dist(c(0, 50000, 100000, 200000)))
  dimnames(D) <- list(letters[1:4], letters[1:4])
  N <- stats::setNames(c(1e5, 2e5, 3e5, 4e5), letters[1:4])
  dat <- list(D = D, N = N)
  raw <- mod$get_model()
  raw$data$S <- NULL
  expected <- mobility::predict(raw, newdata = dat)
  actual <- suppressWarnings(predict(mod, newdata = dat))
  expect_equal(as.numeric(actual), as.numeric(expected))
  expect_equal(dim(actual), c(4L, 4L))
  expect_equal(mod$get_model()$data$S, original)
  same <- mod$get_model()$data[c("D", "N_orig", "N_dest")]
  same$N_orig <- same$N_orig * 1.2
  expect_equal(as.numeric(predict(mod, newdata = same)),
               as.numeric(mobility::predict(raw, newdata = same)))
})

test_that("distance conversion and both prediction interfaces agree", {
  mod <- model_db$com_fb_2025_mod_grav_exp
  dat <- mod$get_model()$data[c("D", "N_orig", "N_dest")]
  metres <- predict(mod, newdata = dat, unit = "m")
  dat$D <- dat$D / 1000
  expect_equal(predict(mod, newdata = dat, unit = "km"), metres)
  expect_equal(mod$predict(newdata = dat, unit = "km"), metres)
  dat$D[1, 2] <- Inf
  expect_error(predict(mod, newdata = dat), "finite")
})

test_that("intervening population matches a hand-calculated tied-distance case", {
  mod <- model_db$com_fb_2025_mod_dd_radiation
  D <- as.matrix(dist(c(0, 1, 2))) * 50000
  dimnames(D) <- list(letters[1:3], letters[1:3])
  dat <- list(D = D, N = c(a = 10, b = 20, c = 30))
  raw <- mod$get_model()
  raw$data$S <- matrix(c(0, 0, 20, 30, 0, 10, 20, 0, 0), 3, byrow = TRUE)
  expected <- mobility::predict(raw, newdata = dat)
  actual <- suppressWarnings(predict(mod, newdata = dat))
  expect_equal(as.numeric(actual), as.numeric(expected))
})

context("algeria import")

test_that("Algeria Facebook metadata and models are available", {
  metadata <- mobility_table(data_name = "dza_fb_2025")
  expect_equal(nrow(metadata), 1)
  expect_equal(metadata$country, "DZA")
  expect_equal(metadata$type, "facebook")
  expect_equal(metadata$aggregation, "admin_2")

  models <- model_table(data_name = "dza_fb_2025")
  expect_equal(nrow(models), 12)
  expect_setequal(
    models$mobility_model,
    c("gravity", "radiation", "departure-diffusion")
  )
})

test_that("Algeria Facebook models are lightweight and hydrate shared data", {
  models <- nomad::model_db[grepl("^dza_fb_2025_", names(nomad::model_db))]
  expect_equal(length(models), 12)

  stored_fields <- lapply(models, function(model) {
    names(model$get_model(hydrate = FALSE)$data)
  })
  has_no_training_data <- vapply(stored_fields, function(fields) {
    !any(c("M", "D", "N_orig", "N_dest", "S") %in% fields)
  }, logical(1))
  expect_true(all(has_no_training_data))

  hydrated_fields <- lapply(models, function(model) {
    names(model$get_model()$data)
  })
  has_covariates <- vapply(hydrated_fields, function(fields) {
    all(c("D", "N_orig", "N_dest") %in% fields) && !"M" %in% fields
  }, logical(1))
  expect_true(all(has_covariates))

  expect_true("S" %in% names(nomad::model_db$dza_fb_2025_mod_rad_basic$get_model()$data))
  expect_true("S" %in% names(nomad::model_db$dza_fb_2025_mod_dd_radiation$get_model()$data))

  checks <- lapply(models, check, plots = FALSE)
  expect_true(all(vapply(checks, function(x) {
    all(c("DIC", "RMSE", "MAPE", "R2") %in% names(x))
  }, logical(1))))
})

test_that("Algeria representative check plot and prediction work", {
  model <- nomad::model_db$dza_fb_2025_mod_grav_exp
  expect_s3_class(model$get_model(), "mobility.model")

  plot_path <- system.file(
    "extdata",
    "model_checks",
    "dza_fb_2025",
    "dza_fb_2025_mod_grav_exp.png",
    package = "nomad"
  )
  expect_true(nzchar(plot_path))
  expect_true(file.exists(plot_path))

  pred <- predict(model)
  expect_equal(dim(pred), c(1504L, 1504L))
})

test_that("Algeria model-check plots are bundled per model", {
  models <- nomad::model_db[grepl("^dza_fb_2025_", names(nomad::model_db))]
  plot_paths <- vapply(names(models), function(name) {
    system.file(
      "extdata",
      "model_checks",
      "dza_fb_2025",
      paste0(name, ".png"),
      package = "nomad"
    )
  }, character(1))

  expect_true(all(nzchar(plot_paths)))
  expect_true(all(file.exists(plot_paths)))
})

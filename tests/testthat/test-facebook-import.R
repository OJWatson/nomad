context("facebook import")

test_that("all Facebook 2025 datasets and model families are available", {
  datasets <- mobility_table(data_type = "facebook")
  datasets <- datasets[grepl("_fb_2025$", datasets$name), ]
  expect_equal(nrow(datasets), 51)

  models <- model_table(data_type = "facebook")
  models <- models[grepl("_fb_2025$", models$data_name), ]
  expect_equal(nrow(models), 51 * 12)
  expect_true(all(table(models$data_name) == 12))
  expect_setequal(
    models$mobility_model,
    c("gravity", "radiation", "departure-diffusion")
  )
})

test_that("Facebook 2025 models are stripped and have bundled checks", {
  models <- nomad::model_db[grepl("_fb_2025_", names(nomad::model_db))]
  expect_equal(length(models), 51 * 12)

  heavy_fields <- vapply(models, function(model) {
    any(c("M", "D", "N_orig", "N_dest", "S") %in%
          names(model$get_model(hydrate = FALSE)$data))
  }, logical(1))
  expect_false(any(heavy_fields))

  has_checks <- vapply(models, function(model) {
    !is.null(model$get_check_res())
  }, logical(1))
  expect_true(all(has_checks))
})

test_that("Facebook 2025 shared data and check plots are bundled", {
  datasets <- mobility_table(data_type = "facebook")
  datasets <- datasets[grepl("_fb_2025$", datasets$name), ]

  shared <- system.file(
    "extdata",
    "model_data",
    paste0(datasets$name, ".rds"),
    package = "nomad"
  )
  expect_true(all(nzchar(shared)))
  expect_true(all(file.exists(shared)))

  plot_counts <- vapply(datasets$name, function(data_name) {
    path <- system.file(
      "extdata",
      "model_checks",
      data_name,
      package = "nomad"
    )
    length(list.files(path, pattern = "\\.png$"))
  }, integer(1))
  expect_true(all(plot_counts == 12))
})

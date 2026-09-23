read_zip_rds <- function(zipfile, filename) {
  # unzip() cannot stream directly into readRDS(), so extract just the file we
  # need into a disposable temporary directory.
  exdir <- tempfile("nomad_zip_")
  dir.create(exdir)
  on.exit(unlink(exdir, recursive = TRUE), add = TRUE)
  unzip(zipfile, files = filename, exdir = exdir)
  readRDS(file.path(exdir, filename))
}

truthy <- function(x) {
  # Keep environment-variable switches readable in the country scripts.
  tolower(x) %in% c("1", "true", "yes", "y")
}

facebook_model_specs <- function() {
  # Standard set of fitted Facebook models currently supplied in MODEL_OUTPUT.
  data.frame(
    code = c("gb", "gt", "gp", "ge", "gnp", "gne", "gsp", "rb", "rf", "dp", "de", "dr"),
    object = c("mod_gb", "mod_gt", "mod_gp", "mod_ge", "mod_gnp", "mod_gne",
               "mod_gsp", "mod_rb", "mod_rf", "mod_dp", "mod_de", "mod_dr"),
    file = paste0(c("mod_gb", "mod_gt", "mod_gp", "mod_ge", "mod_gnp", "mod_gne",
                    "mod_gsp", "mod_rb", "mod_rf", "mod_dp", "mod_de", "mod_dr"), ".rds"),
    model = c(rep("gravity", 7), rep("radiation", 2), rep("departure-diffusion", 3)),
    type = c("basic", "transport", "power", "exp", "power_norm", "exp_norm",
             "scaled_power", "basic", "finite", "power", "exp", "radiation"),
    stringsAsFactors = FALSE
  )
}

read_facebook_inputs <- function(model_dir,
                                 input_zip,
                                 input_country,
                                 expected_n,
                                 m_env = "") {
  # D and N are shareable and live in data-raw. M is private and is read from
  # a local override path or from MODEL_INPUT.zip, but is never bundled.
  D <- as.matrix(readRDS(file.path(model_dir, "D.rds")))
  N <- readRDS(file.path(model_dir, "N.rds"))
  M <- if (nzchar(m_env) && nzchar(Sys.getenv(m_env, ""))) {
    readRDS(Sys.getenv(m_env))
  } else {
    read_zip_rds(input_zip, file.path("MODEL_INPUT", input_country, "M.rds"))
  }
  M <- as.matrix(M)

  stopifnot(identical(dim(D), c(expected_n, expected_n)))
  stopifnot(length(N) == expected_n)
  stopifnot(identical(dim(M), c(expected_n, expected_n)))
  if (!identical(rownames(D), names(N)) ||
      !identical(rownames(D), rownames(M)) ||
      !identical(colnames(D), colnames(M))) {
    warning(
      "Facebook input names do not fully align; archived MODEL_OUTPUT objects ",
      "will be treated as the fitted-model source of truth.",
      call. = FALSE
    )
  }

  list(D = D, N = N, M = M)
}

fit_facebook_models <- function(D, N, M, specs = facebook_model_specs()) {
  # This is the provenance recipe: it records how the archived models would be
  # created from private M. Country scripts normally read MODEL_OUTPUT instead.
  set.seed(123L)
  out <- lapply(seq_len(nrow(specs)), function(i) {
    spec <- specs[i, ]
    args <- list(data = list(D = D, M = M, N = N), model = spec$model, type = spec$type)
    if (spec$model != "radiation") {
      args <- c(args, list(n_chain = 2, n_burn = 1000, n_samp = 1000,
                           n_thin = 1, DIC = FALSE))
    }
    if (spec$model == "departure-diffusion") {
      args$hierarchical <- FALSE
    }
    do.call(mobility::mobility, args)
  })
  stats::setNames(out, specs$object)
}

facebook_outputs_exist <- function(output_zip, output_country, specs = facebook_model_specs()) {
  # If a country has archived fitted models, use them rather than refitting.
  expected <- file.path("MODEL_OUTPUT", output_country, specs$file)
  all(expected %in% unzip(output_zip, list = TRUE)$Name)
}

read_facebook_models <- function(output_zip, output_country, specs = facebook_model_specs()) {
  # Read the fitted mobility.model objects produced by the original analysis.
  out <- lapply(specs$file, function(file) {
    read_zip_rds(output_zip, file.path("MODEL_OUTPUT", output_country, file))
  })
  stats::setNames(out, specs$object)
}

save_facebook_model_data <- function(data_name, D, N, models) {
  # Store repeated D/N/S data once per country. nomad_model$get_model() hydrates
  # these fields on demand, so each model_db entry can stay small.
  fitted_data <- models[[1]]$data
  shared <- list(
    D = fitted_data$D,
    N_orig = fitted_data$N_orig,
    N_dest = fitted_data$N_dest
  )
  s_model <- models[vapply(models, function(x) "S" %in% names(x$data), logical(1))]
  if (length(s_model)) {
    shared$S <- s_model[[1]]$data$S
  }

  path <- file.path(here::here(), "inst", "extdata", "model_data", paste0(data_name, ".rds"))
  dir.create(dirname(path), recursive = TRUE, showWarnings = FALSE)
  saveRDS(shared, path, compress = "xz")
}

facebook_plot_codes <- function(env = "NOMAD_FACEBOOK_CHECK_PLOTS") {
  # Default is no plot regeneration. Set an env var to "all" or a comma-
  # separated list such as "ge,rb" when new check plots are needed.
  value <- Sys.getenv(env, "none")
  out <- trimws(unlist(strsplit(value, ",", fixed = TRUE)))
  if (identical(out, "all")) {
    return(facebook_model_specs()$code)
  }
  if (identical(out, "none")) {
    return(character())
  }
  out
}

add_facebook_models_to_db <- function(data_name,
                                      models,
                                      model_dir,
                                      plot_codes = character(),
                                      specs = facebook_model_specs()) {
  # Wrap each mobility.model, save checks/plots if requested, remove private and
  # repeated training data, and attach a shared data reference.
  model_db <- nomad::model_db
  for (i in seq_len(nrow(specs))) {
    spec <- specs[i, ]
    mod <- models[[spec$object]]
    stopifnot(inherits(mod, "mobility.model"))
    stopifnot(identical(mod$model, spec$model))
    stopifnot(identical(mod$type, spec$type))

    has_s <- "S" %in% names(mod$data)
    data_fields <- c("D", "N_orig", "N_dest", if (has_s) "S")
    nmd <- nomad::nomad_model(mod, data_name = data_name)
    model_name <- nmd$get_model_name()
    existing_check <- tryCatch(model_db[[model_name]]$get_check_res(), error = function(e) NULL)

    if (spec$code %in% plot_codes) {
      model_check_path <- file.path(model_dir, "model_checks", paste0(model_name, ".png"))
      dir.create(dirname(model_check_path), recursive = TRUE, showWarnings = FALSE)
      nmd <- nomad::nomad_remove_model_data(
        nmd, M = TRUE, D = TRUE, N_orig = TRUE, N_dest = TRUE, S = has_s,
        save_model_checks = TRUE, filename = model_check_path,
        width = 8, height = 4, units = "in", res = 150
      )

      copy_loc <- file.path(
        here::here(), "inst", "extdata", "model_checks",
        data_name, basename(model_check_path)
      )
      dir.create(dirname(copy_loc), recursive = TRUE, showWarnings = FALSE)
      file.copy(model_check_path, copy_loc, overwrite = TRUE)
    } else {
      if (is.null(existing_check)) {
        existing_check <- nomad::check(nmd, plots = FALSE)
      }
      nmd$set_check_res(existing_check)
      nmd <- nomad::nomad_remove_model_data(
        nmd, M = TRUE, D = TRUE, N_orig = TRUE, N_dest = TRUE, S = has_s
      )
    }

    nmd$set_model_data_ref(data_name, data_fields)
    model_db[[model_name]] <- nmd
  }

  model_db[order(names(model_db))]
}

remake_model_db_for_current_class <- function(model_db) {
  # Rebuild R6 objects so saved model_db entries pick up the current class
  # methods without changing the fitted mobility.model contents.
  remake <- function(model) {
    underlying <- tryCatch(model$get_model(hydrate = FALSE), error = function(e) model$get_model())
    out <- nomad::nomad_model(
      model = underlying,
      data_name = model$get_data_name(),
      data_ref = tryCatch(model$get_data_ref(), error = function(e) NULL),
      data_fields = tryCatch(model$get_data_fields(), error = function(e) NULL)
    )
    out$set_check_res(model$get_check_res())
    out
  }
  lapply(model_db, remake)
}

## Code to fit and add mli_fb_2025 models to database
##
## D.rds and N.rds are shareable. M is private Facebook OD data and must not be
## committed or bundled.

source(file.path(here::here(), "data-raw", "functions", "facebook_models.R"))

if (requireNamespace("devtools", quietly = TRUE)) {
  devtools::load_all(here::here(), quiet = TRUE)
}

data_name <- "mli_fb_2025"
country <- "Mali"
model_dir <- file.path(here::here(), "data-raw", "models", data_name)
input_zip <- Sys.getenv("NOMAD_MODEL_INPUT_ZIP", file.path(here::here(), "analysis", "MODEL_INPUT.zip"))
output_zip <- Sys.getenv("NOMAD_MODEL_OUTPUT_ZIP", file.path(here::here(), "analysis", "MODEL_OUTPUT.zip"))

dat <- read_facebook_inputs(
  model_dir = model_dir,
  input_zip = input_zip,
  input_country = country,
  expected_n = 50L,
  m_env = "NOMAD_MLI_M_RDS"
)

specs <- facebook_model_specs()

# This is the fitting recipe. In normal package builds we read the archived
# MODEL_OUTPUT objects; set NOMAD_MLI_REFIT=true to refit from private M.
mods <- if (truthy(Sys.getenv("NOMAD_MLI_REFIT", "false")) ||
            !facebook_outputs_exist(output_zip, country, specs)) {
  fit_facebook_models(dat$D, dat$N, dat$M, specs)
} else {
  read_facebook_models(output_zip, country, specs)
}

save_facebook_model_data(data_name, dat$D, dat$N, mods)

model_db <- add_facebook_models_to_db(
  data_name = data_name,
  models = mods,
  model_dir = model_dir,
  plot_codes = facebook_plot_codes("NOMAD_MLI_CHECK_PLOTS"),
  specs = specs
)

model_db <- remake_model_db_for_current_class(model_db)
model_db <- model_db[order(names(model_db))]
usethis::use_data(model_db, overwrite = TRUE)


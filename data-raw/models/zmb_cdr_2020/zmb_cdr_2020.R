## Code to add zmb_cdr_2020 models to database

# Read in data sets
D <- readRDS(file.path(here::here(), "data-raw/models/zmb_cdr_2020/dist_data.rds"))
M <- readRDS(file.path(here::here(), "data-raw/models/zmb_cdr_2020/OD_data_diag.rds"))
N <- readRDS(file.path(here::here(), "data-raw/models/zmb_cdr_2020/pop_data.rds"))

# Convert to matrices
D <- as.matrix(D)
M <- as.matrix(M)

# Set seed for reproducibility
set.seed(123L)

# Create mobility model
mod <- mobility::mobility(
  data = list("D" = D, "M" = M, "N" = N),
  model = "departure-diffusion",
  type = "exp",
  DIC = TRUE)

# Convert to nomad model
zmb_cdr_2020_mod_dd_exp <- nomad::nomad_model(
  model = mod,
  data_name = "zmb_cdr_2020"
)

# Add to the model database
model_db <- nomad:::add_model_to_db(zmb_cdr_2020_mod_dd_exp)

# Update the package model database
usethis::use_data(model_db, overwrite = TRUE)

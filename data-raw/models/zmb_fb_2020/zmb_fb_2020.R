## Code to add zmb_fb_2020 models to database

# Read in data sets
D <- readRDS(file.path(here::here(), "data-raw/models/zmb_fb_2020/dist_data.rds"))
N <- readRDS(file.path(here::here(), "data-raw/models/zmb_fb_2020/pop_data.rds"))

# Read in data that is not publicly available
# We include the code to generate the model nonetheless
M <- read.csv(file.path(here::here(), "data-raw/models/zmb_fb_2020/M_fb.csv"), row.names = 1)

# Convert to matrices
D <- as.matrix(D)
M <- as.matrix(M)

# Set seed for reproducibility
set.seed(123L)

# Create mobility model
mod <- mobility::mobility(
  data = list("D" = D, "M" = M, "N" = N),
  model = "gravity",
  type = "exp",
  n_chain = 4,
  DIC = TRUE)

# Convert to nomad model
zmb_fb_2020_mod_grav_exp <- nomad::nomad_model(
  model = mod,
  data_name = "zmb_fb_2020"
)

# NOTE: Use nomad_remove_model_data to ensure the underlying data is not
# included and request that the model checks are saved for viewing later
# despite the data being removed
model_check_path <- file.path(here::here(), "data-raw/models/zmb_fb_2020/model_check.png")
zmb_fb_2020_mod_grav_exp <- nomad_remove_model_data(
  zmb_fb_2020_mod_grav_exp,
  M = TRUE,
  save_model_checks = TRUE,
  filename = model_check_path,
  width = 8, height = 4, units = "in", res = 300
  )

# Now copy the model check plot to the package external directory
copy_loc <- file.path(
  here::here(),
  "inst/extdata/model_checks",
  file.path(basename(dirname(model_check_path)), basename(model_check_path))
)
dir.create(dirname(copy_loc), recursive = TRUE, showWarnings = FALSE)
file.copy(model_check_path, copy_loc)

# Add to the model database
model_db <- nomad:::add_model_to_db(zmb_fb_2020_mod_grav_exp)

# Update the package model database
usethis::use_data(model_db, overwrite = TRUE)


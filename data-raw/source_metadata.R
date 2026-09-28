# Verify distance units and retain shareable source-region centroids.
library(sf)
input_zip <- Sys.getenv("NOMAD_MODEL_INPUT_ZIP", "analysis/MODEL_INPUT.zip")
files <- unzip(input_zip, list = TRUE)$Name
metadata <- read.csv("data-raw/facebook_mobility_db.csv")
admin_1 <- c("CPV", "COM", "LSO", "LBY", "MUS", "MYT", "SYC")
metadata$aggregation <- ifelse(metadata$country %in% admin_1, "admin_1", "admin_2")
units <- list()
locations <- list()
for (i in seq_len(nrow(metadata))) {
  id <- metadata$name[i]
  iso <- metadata$country[i]
  level <- sub("admin_", "", metadata$aggregation[i])
  pattern <- paste0("/gadm41_", iso, "_", level, "\\.(shp|shx|dbf|prj|cpg)$")
  selected <- files[grepl(pattern, files)]
  stopifnot(length(selected) >= 4)
  td <- tempfile("nomad_shape_")
  dir.create(td)
  unzip(input_zip, files = selected, exdir = td)
  shape <- st_read(file.path(td, selected[grepl("\\.shp$", selected)]), quiet = TRUE)
  suppressMessages(sf_use_s2(FALSE))
  centres <- suppressWarnings(st_centroid(st_geometry(shape)))
  suppressMessages(sf_use_s2(TRUE))
  xy <- st_coordinates(centres)
  shared <- readRDS(file.path("inst/extdata/model_data", paste0(id, ".rds")))
  D <- shared$D
  normalise <- function(x) gsub("^([A-Z]{3})\\.", "\\1", sub("_[0-9]+$", "", x))
  idx <- match(normalise(rownames(D)), normalise(shape[[paste0("GID_", level)]]))
  matched <- which(!is.na(idx))
  stopifnot(length(matched) >= 3L, !anyDuplicated(idx[matched]))
  sample <- matched[unique(round(seq(1, length(matched), length.out = min(30, length(matched)))))]
  reference <- as.matrix(st_distance(centres[idx[sample]]))
  reference <- units::drop_units(reference)
  actual <- D[sample, sample]
  keep <- upper.tri(reference) & reference > 0
  ratio <- stats::median(actual[keep] / reference[keep])
  unit <- if (abs(ratio - 1) < 0.05) "m" else if (abs(ratio * 1000 - 1) < 0.05) "km" else NA_character_
  stopifnot(!is.na(unit))
  units[[id]] <- data.frame(name = id, distance_unit = unit, reference_ratio = ratio,
                            matched_regions = length(matched), fitted_regions = nrow(D))
  locations[[id]] <- data.frame(data_name = id, region = rownames(D)[matched],
                               label = shape[[paste0("NAME_", level)]][idx[matched]],
                               lon = xy[idx[matched], 1], lat = xy[idx[matched], 2])
  unlink(td, recursive = TRUE)
  cat(id, unit, ratio, "\n")
}
write.csv(metadata, "data-raw/facebook_mobility_db.csv", row.names = FALSE, na = "NA")
write.csv(do.call(rbind, units), "data-raw/distance_units.csv", row.names = FALSE)
saveRDS(do.call(rbind, locations), "inst/extdata/source_locations.rds", compress = "xz")

# Database Descriptions --------------

#' Model database
#'
#' Database of all mobility models stored in `nomad`
#'
#' @docType data
#'
#' @format A named [list] of [nomad::nomad_model]s.
#'
#' Each model is named with a standard convention. For example, let's look at
#' `zmb_cdr_2020_mod_dd_exp`. Each of the names in the snake case name convention
#' refer either to the data that the model was fit using or the type of model
#' that was fit.
#'
#' `zmb_cdr_2020_mod_dd_exp`:
#'
#' - `zmb`: ISO3C county code for where data was collected.
#' - `cdr`: type of mobility data. cdr = Call Data Record.
#' - `2020`: year of data collection.
#' - `mod`: signifies the following labels relate to the model.
#' - `dd`: mobility model. dd = Departure-Diffusion.
#' - `exp`: sub-type of mobility model. exp = Exponential.
#'
#' The naming conventions help with documenting the models and enable linking
#' to [nomad::mobility_db] to query further information about the underlying
#' mobility data the model was fit using. All names in the snake case model name
#' before `mod` refer to the mobility data.
#' @docType data
"model_db"

#' Mobility database
#'
#' Meta database of all mobility data sets that have been
#' used in the creation of the models stored in `nomad`
#'
#' @docType data
#'
#' @format A [tibble::tibble()] of mobility metadata with the following fields:
#'
#' `mobility_db`:
#'
#' - `name`: name of mobility data.
#' - `country`: ISO3C country code for where data was collected.
#' - `date_start`: start date of data collection.
#' - `date_end`: end date of data collection.
#' - `n`: number of data records.
#' - `type`: type of mobility data, e.g. call data records, facebook.
#' - `sampling_scheme`: free text description of sample scheme.
#' - `censoring`: free text description of any censoring.
#' - `aggregation`: spatial scale of aggregation, e.g. admin_2.
#' - `publication`: URL for associated publication or raw data.
#' - `has_fitted_models`: whether at least one fitted model is in `model_db`.
#' - `prediction_period_days`: interval represented by predictions; NA if unknown.
#' - `distance_unit`: fitted distance unit (`m` or `km`); NA if unknown.
#' - `provenance`: fitting recipe and supplied model attribution.
#'
#' @rdname mobility_db
#' @aliases mobility_db
#'
#'
"mobility_db"

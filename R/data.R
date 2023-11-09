# Database Descriptions --------------

#' Mobility database
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
#'  \code{zmb_cdr_2020_mod_dd_exp}:
#'    \itemize{
#'      \item{`zmb`:  }{ISO3C county code for where data was collected}
#'      \item{`cdr`:  }{Type of mobility data. cdr = Call Data Record}
#'      \item{`2020`:  }{Year of data collection}
#'      \item{`mod`:  }{mod signifies the following labels relate to the model}
#'      \item{`dd`:  }{Which mobility model. dd = Departure-Diffusion}
#'      \item{`exp`:  }{Sub-Type of mobility model. exp = Exponential}
#'      }
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
#' @format A [tibble::tibble()] of mobility metadata with 10 variables:
#'
#'  \code{mobility_db}:
#'    \itemize{
#'      \item{`name`:  }{Name of mobility data}
#'      \item{`country`:  }{ISO3C country code for where data was collected}
#'      \item{`date_start`:  }{Start date of data collection}
#'      \item{`date_end`:  }{End date of data collection}
#'      \item{`n`:  }{Number of data records}
#'      \item{`type`: }{Type of mobility data, e.g. call data records, facebook}
#'      \item{`sampling_scheme`:  }{Free text description of sample scheme}
#'      \item{`censoring`:  }{Free text description of any censoring}
#'      \item{`aggregation`:  }{Spatial scale of aggregation, e.g. admin_2}
#'      \item{`url`:  }{URL for associated publication or raw data}
#'      }
#'
#' @rdname mobility_db
#' @aliases mobility_db
#'
#'
"mobility_db"

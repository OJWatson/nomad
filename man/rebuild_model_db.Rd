% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/database.R
\name{rebuild_model_db}
\alias{rebuild_model_db}
\title{Rebuild model_db}
\usage{
rebuild_model_db()
}
\description{
Loops through \link{model_db} and remakes each model
before savig model_db using \code{\link[usethis:use_data]{usethis::use_data()}}
}

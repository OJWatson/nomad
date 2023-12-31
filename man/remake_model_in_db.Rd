% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/database.R
\name{remake_model_in_db}
\alias{remake_model_in_db}
\title{Remake model_db model from current}
\usage{
remake_model_in_db(model)
}
\arguments{
\item{model}{A \code{\link[=nomad_model]{nomad_model()}} object}
}
\value{
\code{\link[=nomad_model]{nomad_model()}}
}
\description{
When new features get added to the \code{\link[=nomad_model]{nomad_model()}} R6 class over
time, it will be important to have a way of updating the models in
\link{model_db} to reflect these changes without having to either refit
the underlying mobility model. \code{remake_model_in_db} provides this
functionality.
}

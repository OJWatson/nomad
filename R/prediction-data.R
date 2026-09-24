#' @noRd
model_distance_unit <- function(object) {
  unit <- mobility_table(data_name = object$get_data_name())$distance_unit
  if (length(unit) != 1L || is.na(unit)) return(NULL)
  unit
}

#' @noRd
prepare_prediction_data <- function(object, newdata, unit = NULL) {
  if (is.null(newdata)) return(NULL)
  if (!is.list(newdata) || is.null(newdata$D)) {
    stop("newdata must contain D and either N or N_orig/N_dest", call. = FALSE)
  }
  D <- newdata$D
  if (!is.matrix(D) || !is.numeric(D) || any(!is.finite(D)) || any(D < 0)) {
    stop("D must be a finite, non-negative numeric matrix", call. = FALSE)
  }
  for (ids in list(rownames(D), colnames(D))) {
    if (is.null(ids) || anyNA(ids) || any(!nzchar(ids)) || anyDuplicated(ids)) {
      stop("D must have unique, non-missing origin and destination names", call. = FALSE)
    }
  }
  newdata$N_orig <- newdata$N %||% newdata$N_orig
  newdata$N_dest <- newdata$N %||% newdata$N_dest
  for (field in c("N_orig", "N_dest")) {
    N <- newdata[[field]]
    ids <- if (field == "N_orig") rownames(D) else colnames(D)
    if (!is.numeric(N) || any(!is.finite(N)) || any(N <= 0) ||
          is.null(names(N)) || anyDuplicated(names(N)) || !setequal(names(N), ids)) {
      stop(field, " must contain one positive finite population per named region", call. = FALSE)
    }
    newdata[[field]] <- N[ids]
  }
  if (!is.null(unit)) {
    unit <- match.arg(unit, c("m", "km"))
    source <- model_distance_unit(object)
    if (is.null(source)) stop("The model distance unit is unknown; cannot convert D", call. = FALSE)
    factors <- c(m = 1, km = 1000)
    D <- D * unname(factors[unit] / factors[source])
  }
  list(D = D, N_orig = newdata$N_orig, N_dest = newdata$N_dest,
       locations = newdata$locations %||% newdata$coords)
}

#' @noRd
check_model_capabilities <- function(object, fitted, newdata, nsim) {
  if (fitted$model != "radiation") return(NULL)
  id <- object$get_model_name()
  if (nsim != 1) {
    stop(id, " is parameter-free and cannot produce stochastic draws; use nsim = 1.",
         call. = FALSE)
  }
  if (is.null(newdata)) return(NULL)
  source <- fitted$data
  rows <- rownames(newdata$D)
  cols <- colnames(newdata$D)
  same <- setequal(rows, rownames(source$D)) && setequal(cols, colnames(source$D))
  if (same) {
    same <- isTRUE(all.equal(newdata$D, source$D[rows, cols, drop = FALSE], tolerance = 1e-10)) &&
      isTRUE(all.equal(newdata$N_orig, source$N_orig[rows], tolerance = 1e-10)) &&
      isTRUE(all.equal(newdata$N_dest, source$N_dest[cols], tolerance = 1e-10))
  }
  if (!same) {
    stop(id, " uses the original regions, populations and trip totals. ",
         "It cannot predict for this new setting. Use predict(model) for its source setting, ",
         "choose a transferable nomad model, or calculate a new radiation model with mobility.",
         call. = FALSE)
  }
  list(rows, cols)
}

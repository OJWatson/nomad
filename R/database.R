add_model_to_db <- function(nomad_model,
                            name = deparse(substitute(nomad_model))) {

  # Get package model_db structure
  model_db <- nomad::model_db

  # Add and sort models
  model_db[[name]] <- nomad_model
  model_db <- model_db[order(names(model_db))]

  # Return updated model_db
  model_db
}

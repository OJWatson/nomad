# Package index

## Nomad model

Creation of a nomad model

- [`nomad_ensemble()`](https://ojwatson.github.io/nomad/reference/nomad_ensemble.md)
  : Create an ensemble of nomad models
- [`nomad_model()`](https://ojwatson.github.io/nomad/reference/nomad_model.md)
  : Create nomad_model
- [`nomad_model_`](https://ojwatson.github.io/nomad/reference/nomad_model_.md)
  : R6 Class for mobility models
- [`nomad_remove_model_data()`](https://ojwatson.github.io/nomad/reference/nomad_remove_model_data.md)
  : Remove mobility data that mobility model was trained on

## Modeling and simulation

Predicting from, summarizing, and checking mobility model objects

- [`print(`*`<nomad_model>`*`)`](https://ojwatson.github.io/nomad/reference/print.nomad_model.md)
  : Print 'nomad_model' class
- [`plot(`*`<nomad_model>`*`)`](https://ojwatson.github.io/nomad/reference/plot.nomad_model.md)
  : Plot model fit checks for 'nomad_model' class
- [`summary(`*`<nomad_model>`*`)`](https://ojwatson.github.io/nomad/reference/summary.nomad_model.md)
  : Calculate summary statistics for 'nomad_model' class
- [`predict(`*`<nomad_model>`*`)`](https://ojwatson.github.io/nomad/reference/predict.nomad_model.md)
  : Prediction and simulation method for 'nomad_model' class
- [`residuals(`*`<nomad_model>`*`)`](https://ojwatson.github.io/nomad/reference/residuals.nomad_model.md)
  : Extract model residuals 'nomad_model' class
- [`check()`](https://ojwatson.github.io/nomad/reference/check.md) :
  Check goodness of fit for 'nomad_model' class
- [`mobility_metrics()`](https://ojwatson.github.io/nomad/reference/mobility_metrics.md)
  : Summarise predicted mobility matrices
- [`uncertainty_summary()`](https://ojwatson.github.io/nomad/reference/uncertainty_summary.md)
  : Summarise uncertainty metrics
- [`uncertainty_matrices()`](https://ojwatson.github.io/nomad/reference/uncertainty_matrices.md)
  : Select representative uncertainty matrices
- [`plot_uncertainty()`](https://ojwatson.github.io/nomad/reference/plot_uncertainty.md)
  : Plot representative uncertainty matrices
- [`compare_models()`](https://ojwatson.github.io/nomad/reference/compare_models.md)
  : Compare two mobility models interactively
- [`nomad_ensemble()`](https://ojwatson.github.io/nomad/reference/nomad_ensemble.md)
  : Create an ensemble of nomad models
- [`predict(`*`<nomad_ensemble>`*`)`](https://ojwatson.github.io/nomad/reference/predict.nomad_ensemble.md)
  : Predict from a nomad model ensemble
- [`prediction_difference()`](https://ojwatson.github.io/nomad/reference/prediction_difference.md)
  : Compare two prediction matrices
- [`plot_prediction_difference()`](https://ojwatson.github.io/nomad/reference/plot_prediction_difference.md)
  : Plot the difference between prediction matrices

## Data Objects

Mobility database and Mobility Models database

- [`mobility_db`](https://ojwatson.github.io/nomad/reference/mobility_db.md)
  : Mobility database
- [`model_db`](https://ojwatson.github.io/nomad/reference/model_db.md) :
  Model database
- [`mobility_table()`](https://ojwatson.github.io/nomad/reference/mobility_table.md)
  : Query mobility datasets
- [`model_table()`](https://ojwatson.github.io/nomad/reference/model_table.md)
  : Query fitted nomad models
- [`model_profile()`](https://ojwatson.github.io/nomad/reference/model_profile.md)
  : Profile a fitted nomad model
- [`model_weights()`](https://ojwatson.github.io/nomad/reference/model_weights.md)
  : Suggest model weights from fit statistics

## Population Helpers

Functions to fetch population sizes

- [`get_pop()`](https://ojwatson.github.io/nomad/reference/get_pop.md) :
  Get population raster.
- [`unpack_pop()`](https://ojwatson.github.io/nomad/reference/unpack_pop.md)
  : Extract information from rasters

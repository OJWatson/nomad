# R6 Class for mobility models

A nomad mobility model

## Methods

### Public methods

- [`nomad_model_$new()`](#method-nomad_model-new)

- [`nomad_model_$predict()`](#method-nomad_model-predict)

- [`nomad_model_$check_coordinates()`](#method-nomad_model-check_coordinates)

- [`nomad_model_$remove_model_data()`](#method-nomad_model-remove_model_data)

- [`nomad_model_$get_model()`](#method-nomad_model-get_model)

- [`nomad_model_$get_data_name()`](#method-nomad_model-get_data_name)

- [`nomad_model_$get_data_ref()`](#method-nomad_model-get_data_ref)

- [`nomad_model_$get_data_fields()`](#method-nomad_model-get_data_fields)

- [`nomad_model_$get_check_res()`](#method-nomad_model-get_check_res)

- [`nomad_model_$set_check_res()`](#method-nomad_model-set_check_res)

- [`nomad_model_$set_model_data_ref()`](#method-nomad_model-set_model_data_ref)

- [`nomad_model_$get_model_name()`](#method-nomad_model-get_model_name)

------------------------------------------------------------------------

### Method `new()`

Create a new `nomad` mobility model

#### Usage

    nomad_model_$new(model, data_name, data_ref = NULL, data_fields = NULL)

#### Arguments

- `model`:

  [`mobility::mobility()`](https://rdrr.io/pkg/mobility/man/mobility.html)
  model

- `data_name`:

  The model's name to link to
  [`nomad::mobility_db`](https://ojwatson.github.io/nomad/reference/mobility_db.md)

- `data_ref`:

  Optional internal reference to shared package model data.

- `data_fields`:

  Optional character vector of shared data fields.

#### Returns

A new `nomad_model` object. Prediction and simulation method for
'mobility.model' class

This function uses a fitted `mobility.model` object to simulate a
connectivity matrix based on estimated parameters.

------------------------------------------------------------------------

### Method [`predict()`](https://rdrr.io/r/stats/predict.html)

#### Usage

    nomad_model_$predict(newdata = NULL, nsim = 1, seed = NULL, ...)

#### Arguments

- `newdata`:

  a list containing new data to used in model prediction. If `NULL` (the
  default) the function will simulate the model with the data used for
  fitting. See `mobility::predict()`

- `nsim`:

  number of simulations (default = 1)

- `seed`:

  optional integer specifying the call to `set.seed` prior to model
  simulation (default = `NULL`)

- `...`:

  further arguments passed to or from other methods

#### Details

When `nsim = 1`, the prediction matrix is calculated using the mean
point estimate of parameter values. If `nsim > 1` then returns and array
that contains `nsim` number of simulated replications using independent,
zero-truncated normal approximations to the parameter summaries. See
[`predict.nomad_model()`](https://ojwatson.github.io/nomad/reference/predict.nomad_model.md)
for limitations.

#### Returns

a vector, matrix, or array containing predicted or simulated mobility
values. Check coordinates

This function uses a fitted `mobility.model` object to simulate a
connectivity matrix based on estimated parameters.

------------------------------------------------------------------------

### Method `check_coordinates()`

#### Usage

    nomad_model_$check_coordinates(newdata)

#### Arguments

- `newdata`:

  List of `newdata` that is passed to mobility::predict Remove data
  model was trained on

------------------------------------------------------------------------

### Method `remove_model_data()`

#### Usage

    nomad_model_$remove_model_data(
      M = FALSE,
      D = FALSE,
      N_orig = FALSE,
      N_dest = FALSE,
      S = FALSE,
      save_model_checks = FALSE,
      ...
    )

#### Arguments

- `M`:

  Mobility Data

- `D`:

  Distance Data

- `N_orig`:

  Population Origin Data

- `N_dest`:

  Population Destination Data

- `S`:

  Radiation intervening opportunity matrix

- `save_model_checks`:

  Logical to save model check results. Default = FALSE

- `...`:

  further arguments passed to
  [`png()`](https://rdrr.io/r/grDevices/png.html) for saving model check
  plot Get model object

------------------------------------------------------------------------

### Method `get_model()`

#### Usage

    nomad_model_$get_model(hydrate = TRUE)

#### Arguments

- `hydrate`:

  If `TRUE`, attach any shared package data referenced by this model
  before returning it.

#### Returns

Underlying
[`mobility::mobility()`](https://rdrr.io/pkg/mobility/man/mobility.html)
model Get data name

------------------------------------------------------------------------

### Method `get_data_name()`

#### Usage

    nomad_model_$get_data_name()

#### Returns

Data name Get shared model data reference

------------------------------------------------------------------------

### Method `get_data_ref()`

#### Usage

    nomad_model_$get_data_ref()

#### Returns

Shared data reference or `NULL` Get shared model data fields

------------------------------------------------------------------------

### Method `get_data_fields()`

#### Usage

    nomad_model_$get_data_fields()

#### Returns

Character vector of shared data fields or `NULL` Get check results

------------------------------------------------------------------------

### Method `get_check_res()`

#### Usage

    nomad_model_$get_check_res()

#### Returns

Results of model check Set check results

------------------------------------------------------------------------

### Method `set_check_res()`

#### Usage

    nomad_model_$set_check_res(check_res)

#### Arguments

- `check_res`:

  Results of model check Set shared model data reference

------------------------------------------------------------------------

### Method `set_model_data_ref()`

#### Usage

    nomad_model_$set_model_data_ref(data_ref = NULL, data_fields = NULL)

#### Arguments

- `data_ref`:

  Shared data reference

- `data_fields`:

  Shared model data fields Get the model's name

------------------------------------------------------------------------

### Method `get_model_name()`

#### Usage

    nomad_model_$get_model_name()

#### Returns

Model name

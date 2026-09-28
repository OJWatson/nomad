# Remove mobility data that mobility model was trained on

Remove mobility data that mobility model was trained on

## Usage

``` r
nomad_remove_model_data(
  model,
  M = FALSE,
  D = FALSE,
  N_orig = FALSE,
  N_dest = FALSE,
  S = FALSE,
  save_model_checks = FALSE,
  ...
)
```

## Arguments

- model:

  [`nomad_model()`](https://ojwatson.github.io/nomad/reference/nomad_model.md)
  model

- M:

  Mobility Data. Default = FALSE (i.e. do not remove)

- D:

  Distance Data. Default = FALSE

- N_orig:

  Population Origin Data. Default = FALSE

- N_dest:

  Population Destination Data. Default = FALSE

- S:

  Radiation intervening opportunity matrix. Default = FALSE

- save_model_checks:

  Logical to save model check results. Default = FALSE

- ...:

  further arguments passed to
  [`png()`](https://rdrr.io/r/grDevices/png.html) for saving model check
  plot

## Details

Specify `TRUE` to remove a data type.

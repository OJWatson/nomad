# Suggest model weights from fit statistics

Calculates transparent candidate weights from the model-fit statistics
in
[`model_table()`](https://ojwatson.github.io/nomad/reference/model_table.md).
These weights are intended as a starting point for sensitivity analysis,
not as a replacement for judgement about source data relevance.

## Usage

``` r
model_weights(
  data_name = NULL,
  country = NULL,
  data_type = NULL,
  aggregation = NULL,
  mobility_model = NULL,
  model_type = NULL,
  metric = c("DIC", "RMSE", "MAPE", "R2")
)
```

## Arguments

- data_name:

  Optional mobility dataset name.

- country:

  Optional ISO3C country code or vector of codes.

- data_type:

  Optional mobility data type, such as `"facebook"` or
  `"call data record"`.

- aggregation:

  Optional spatial aggregation level, such as `"admin_2"`.

- mobility_model:

  Optional mobility model family, such as `"gravity"` or
  `"departure-diffusion"`.

- model_type:

  Optional model subtype, such as `"exp"`.

- metric:

  Fit statistic used for weighting. `DIC`, `RMSE`, and `MAPE` treat
  lower values as better. `R2` treats higher values as better.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with one row per model and normalised `weight`.

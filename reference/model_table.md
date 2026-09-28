# Query fitted nomad models

Returns a table of fitted models in
[model_db](https://ojwatson.github.io/nomad/reference/model_db.md),
their model-check statistics, and the mobility dataset metadata they are
linked to.

## Usage

``` r
model_table(
  data_name = NULL,
  country = NULL,
  data_type = NULL,
  aggregation = NULL,
  mobility_model = NULL,
  model_type = NULL
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

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with one row per fitted model.

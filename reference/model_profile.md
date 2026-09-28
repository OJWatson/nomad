# Profile a fitted nomad model

Summarises the source data and metadata attached to a fitted model. This
is useful for checking whether a prediction request is close to the
setting used to fit the model.

## Usage

``` r
model_profile(model)
```

## Arguments

- model:

  A
  [`nomad_model()`](https://ojwatson.github.io/nomad/reference/nomad_model.md)
  object.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with one row.

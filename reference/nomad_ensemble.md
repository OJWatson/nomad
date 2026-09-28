# Create an ensemble of nomad models

Creates a lightweight ensemble object that predicts from several
[`nomad_model()`](https://ojwatson.github.io/nomad/reference/nomad_model.md)
objects and combines predictions with user-supplied weights.

## Usage

``` r
nomad_ensemble(models, weights = NULL)
```

## Arguments

- models:

  A
  [`nomad_model()`](https://ojwatson.github.io/nomad/reference/nomad_model.md)
  object or a list of `nomad_model` objects.

- weights:

  Optional numeric weights, or a data frame returned by
  [`model_weights()`](https://ojwatson.github.io/nomad/reference/model_weights.md).
  If omitted, all models are weighted equally. Weights are normalised to
  sum to one.

## Value

A `nomad_ensemble` object.

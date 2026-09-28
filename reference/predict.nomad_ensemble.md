# Predict from a nomad model ensemble

Predict from a nomad model ensemble

## Usage

``` r
# S3 method for class 'nomad_ensemble'
predict(object, newdata = NULL, ...)
```

## Arguments

- object:

  A
  [`nomad_ensemble()`](https://ojwatson.github.io/nomad/reference/nomad_ensemble.md)
  object.

- newdata:

  Optional prediction data passed to each model.

- ...:

  Further arguments passed to
  [`predict.nomad_model()`](https://ojwatson.github.io/nomad/reference/predict.nomad_model.md).

## Value

A weighted-average prediction matrix or array.

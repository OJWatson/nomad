# Plot model fit checks for 'nomad_model' class

This function plots the model-check diagnostics for a
[`nomad_model()`](https://ojwatson.github.io/nomad/reference/nomad_model.md)
object. For models where the original mobility data are unavailable, it
draws the saved check plot bundled with the package.

## Usage

``` r
# S3 method for class 'nomad_model'
plot(x, ...)
```

## Arguments

- x:

  a
  [`nomad_model()`](https://ojwatson.github.io/nomad/reference/nomad_model.md)
  object

- ...:

  further arguments passed to
  [`mobility::check()`](https://rdrr.io/pkg/mobility/man/check.html)
  when underlying model data are available

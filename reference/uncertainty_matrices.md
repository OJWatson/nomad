# Select representative uncertainty matrices

Selects matrices closest to requested quantiles of a summary metric.
This is useful for inspecting lower, median, and upper stochastic
prediction draws.

## Usage

``` r
uncertainty_matrices(x, metric = "total", probs = c(0.025, 0.5, 0.975))
```

## Arguments

- x:

  A 3D prediction array with simulations in the third dimension.

- metric:

  Metric to order by. Must be a column returned by
  [`mobility_metrics()`](https://ojwatson.github.io/nomad/reference/mobility_metrics.md).

- probs:

  Quantiles to select.

## Value

A named list of matrices, with the full metrics table attached as a
`metrics` attribute.

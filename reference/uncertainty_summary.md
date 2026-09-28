# Summarise uncertainty metrics

Calculates lower, median, and upper quantiles for selected metrics from
a stochastic prediction array.

## Usage

``` r
uncertainty_summary(
  x,
  metrics = c("total", "between_region"),
  probs = c(0.025, 0.5, 0.975)
)
```

## Arguments

- x:

  A 3D prediction array with simulations in the third dimension.

- metrics:

  Metrics to summarise. Must be columns returned by
  [`mobility_metrics()`](https://ojwatson.github.io/nomad/reference/mobility_metrics.md).

- probs:

  Quantiles to calculate.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with one row per metric and probability.

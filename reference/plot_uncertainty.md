# Plot representative uncertainty matrices

Plots complete draws selected by
[`uncertainty_matrices()`](https://ojwatson.github.io/nomad/reference/uncertainty_matrices.md)
as labelled heatmaps with a shared colour scale. Requires ggplot2.

## Usage

``` r
plot_uncertainty(
  x,
  metric = "total",
  probs = c(0.025, 0.5, 0.975),
  scale = c("log1p", "identity"),
  ...
)
```

## Arguments

- x:

  A 3D prediction array with simulations in the third dimension.

- metric:

  Metric to order by. Must be a column returned by
  [`mobility_metrics()`](https://ojwatson.github.io/nomad/reference/mobility_metrics.md).

- probs:

  Quantiles to select.

- scale:

  Colour transformation: `"log1p"` (default) or `"identity"`. Log1p
  accommodates zero flows and makes smaller flows visible.

- ...:

  Further arguments passed to
  [`ggplot2::geom_tile()`](https://ggplot2.tidyverse.org/reference/geom_tile.html).

## Value

Invisibly returns the selected matrices.

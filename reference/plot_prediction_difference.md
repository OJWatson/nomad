# Plot the difference between prediction matrices

Plot the difference between prediction matrices

## Usage

``` r
plot_prediction_difference(x, y, relative = FALSE, ...)
```

## Arguments

- x, y:

  Prediction matrices with the same dimensions.

- relative:

  If `TRUE`, plot `(x - y) / y`; otherwise plot `x - y`.

- ...:

  Further arguments passed to
  [`graphics::image()`](https://rdrr.io/r/graphics/image.html).

## Value

Invisibly returns the difference matrix.

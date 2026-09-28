# Compare two prediction matrices

Compare two prediction matrices

## Usage

``` r
prediction_difference(x, y, relative = FALSE)
```

## Arguments

- x, y:

  Prediction matrices with the same dimensions.

- relative:

  If `TRUE`, return `(x - y) / y`; otherwise return `x - y`.

## Value

A matrix of differences.

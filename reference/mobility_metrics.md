# Summarise predicted mobility matrices

Calculates simple summary metrics for one predicted matrix or each
simulated matrix in a 3D prediction array.

## Usage

``` r
mobility_metrics(x)
```

## Arguments

- x:

  A predicted mobility matrix, or a 3D array with simulations in the
  third dimension.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with one row per matrix.

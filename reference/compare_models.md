# Compare two mobility models interactively

Predicts two compatible models and displays an ensemble-weight slider.
Moving the slider combines the precomputed predictions without a server.

## Usage

``` r
compare_models(model_a, model_b, newdata = NULL, weight = 0.5, ...)
```

## Arguments

- model_a, model_b:

  Fitted
  [`nomad_model()`](https://ojwatson.github.io/nomad/reference/nomad_model.md)
  objects.

- newdata:

  Common prediction data, or NULL for the source setting.

- weight:

  Initial weight of model_b, between zero and one.

- ...:

  Arguments passed to prediction, including `unit` and `duration`.

## Value

An HTML widget. The display shows at most 12 busiest regions; reported
totals include the complete matrices. Differences are ensemble minus A.

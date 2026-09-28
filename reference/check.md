# Check goodness of fit for 'nomad_model' class

This function takes a `nomad_model` object and calculates goodness of
fit metrics for the underlying
[`mobility::mobility()`](https://rdrr.io/pkg/mobility/man/mobility.html).
If the Deviance Information Criterin (DIC) was calculated in the
supplied model object, it is included in output. When plots = TRUE, two
plots are shown containing the posterior distribution of trip counts
compared to observed data and a Normal Q-Q plot showing the quantiles of
model residuals against those expected from a Normal distribution.

## Usage

``` r
check(object, plots, ...)
```

## Arguments

- object:

  a
  [`nomad_model()`](https://ojwatson.github.io/nomad/reference/nomad_model.md)
  object containing the fitted mobility

- plots:

  logical indicating whether to plot the Posterior Predictive Check and
  Normal Q-Q Plot (default = `TRUE`)

- ...:

  further arguments passed to or from other methods

## Value

a list of goodness of fit measures

## Details

Goodness of fit metrics include:

- DIC:

  [Deviance Information
  Criterion](https://en.wikipedia.org/wiki/Deviance_information_criterion)

- RMSE:

  [Root Mean Squared
  Error](https://en.wikipedia.org/wiki/Root-mean-square_deviation)

- MAPE:

  [Mean Absolute Percent
  Error](https://en.wikipedia.org/wiki/Mean_absolute_percentage_error)

- R2:

  [R-squared](https://en.wikipedia.org/wiki/Coefficient_of_determination)

## See also

Other model:
[`compare()`](https://rdrr.io/pkg/mobility/man/compare.html),
[`fit_jags()`](https://rdrr.io/pkg/mobility/man/fit_jags.html),
[`fit_prob_travel()`](https://rdrr.io/pkg/mobility/man/fit_prob_travel.html),
[`mobility()`](https://rdrr.io/pkg/mobility/man/mobility.html),
[`predict()`](https://rdrr.io/r/stats/predict.html),
[`residuals()`](https://rdrr.io/r/stats/residuals.html),
[`summary()`](https://rdrr.io/pkg/mobility/man/summary.html)

## Author

John Giles

## Examples

``` r
# Get nomad_model object
nmd_model <- nomad::model_db$zmb_cdr_2020_mod_dd_exp

# Check model fit
nomad::check(nmd_model)

#> $DIC
#> [1] 76328739
#> 
#> $RMSE
#> [1] 172445.4
#> 
#> $MAPE
#> [1] 23473.45
#> 
#> $R2
#> [1] 0.7952939
#> 

# Get nomad_model object without underlying data
nmd_model <- nomad::model_db$zmb_fb_2020_mod_grav_exp

# Model check statistics are still available as these are
# saved when model data is removed from object
nomad::check(nmd_model)

#> $DIC
#> [1] 12442470
#> 
#> $RMSE
#> [1] 447193.4
#> 
#> $MAPE
#> [1] 55.19494
#> 
#> $R2
#> [1] 0.3721586
#> 
```

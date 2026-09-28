# Calculate summary statistics for 'nomad_model' class

This function takes a `nomad_model` object and calculates summary
statistics for the underlying
[`mobility::mobility()`](https://rdrr.io/pkg/mobility/man/mobility.html).
This is a wrapper function of
[MCMCvis::MCMCsummary](https://rdrr.io/pkg/MCMCvis/man/MCMCsummary.html)
that calculates summary statistics for each parameter in a
[`mobility::mobility()`](https://rdrr.io/pkg/mobility/man/mobility.html)
object.

## Usage

``` r
# S3 method for class 'nomad_model'
summary(object, probs = c(0.025, 0.975), ac_lags = c(5, 10), ...)
```

## Arguments

- object:

  a
  [`nomad_model()`](https://ojwatson.github.io/nomad/reference/nomad_model.md)
  object containing the fitted mobility

- probs:

  numeric vector giving the quantiles to calculate for each parameter
  (default = `c(0.025, 0.5, 0.975)`)

- ac_lags:

  numeric vector of lags over which to calculate autocorrelation of
  samples within chains (default = `c(2,5,10)`)

- ...:

  further arguments passed to or from other methods

## Value

a dataframe with summary statistics

## Details

Summary statistics are calculated for all parameters across each chain
along with convergance diagnosics like the Gelman-Rubin convergence
diagnostic and (Rhat) and samples auto-correlation foreach parameter. If
the model object contains deviance and penalty parameters, then Deviance
Information Criterion (DIC) is calculated and appended to the summary.

## See also

Other model: [`check()`](https://rdrr.io/pkg/mobility/man/check.html),
[`compare()`](https://rdrr.io/pkg/mobility/man/compare.html),
[`fit_jags()`](https://rdrr.io/pkg/mobility/man/fit_jags.html),
[`fit_prob_travel()`](https://rdrr.io/pkg/mobility/man/fit_prob_travel.html),
[`mobility()`](https://rdrr.io/pkg/mobility/man/mobility.html),
[`predict()`](https://rdrr.io/r/stats/predict.html),
[`residuals()`](https://rdrr.io/r/stats/residuals.html)

## Author

John Giles

## Examples

``` r
# Get nomad_model object
nmd_model <- nomad::model_db$zmb_cdr_2020_mod_dd_exp

# Check model fit
summary(nmd_model)
#>                  mean           sd         Q2.5        Q97.5 Rhat n.eff   AC5
#> delta    5.938836e+04 1.549880e+01 5.935755e+04 5.941836e+04 1.00  1899 -0.01
#> omega    9.111981e-01 2.835149e-04 9.106320e-01 9.117415e-01 1.00  1418 -0.01
#> tau      6.560246e-02 1.776256e-05 6.556752e-02 6.563678e-02 1.01  1239  0.02
#> theta    1.197415e+01 8.497188e-04 1.197248e+01 1.197584e+01 1.00  2256  0.00
#> DIC      7.632874e+07 5.146209e+01 7.632864e+07 7.632884e+07 1.00  1877 -0.01
#> deviance 7.632873e+07 5.146209e+01 7.632863e+07 7.632883e+07 1.00  1877 -0.01
#> pD       3.933670e+00           NA           NA           NA   NA    NA    NA
#>           AC10
#> delta     0.02
#> omega    -0.02
#> tau      -0.02
#> theta     0.01
#> DIC       0.02
#> deviance  0.02
#> pD          NA
```

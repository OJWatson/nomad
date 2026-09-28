# Create nomad_model

A nomad mobility model

## Usage

``` r
nomad_model(model, data_name, data_ref = NULL, data_fields = NULL)
```

## Arguments

- model:

  [`mobility::mobility()`](https://rdrr.io/pkg/mobility/man/mobility.html)
  model

- data_name:

  The model's name to link to
  [`nomad::mobility_db`](https://ojwatson.github.io/nomad/reference/mobility_db.md)

- data_ref:

  Optional internal reference to shared package model data.

- data_fields:

  Optional character vector of shared data fields to attach when the
  model is hydrated.

## Value

A new `nomad_model` object.

## Examples

``` r
# Get mobility.model object
mob_model <- nomad::model_db$zmb_fb_2020_mod_grav_exp$get_model()

# Create nomad_model object
new_mod <- nomad_model(mob_model, data_name = "zmb_fb_2020")
```

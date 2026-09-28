# Model database

Database of all mobility models stored in `nomad`

## Usage

``` r
model_db
```

## Format

A named [list](https://rdrr.io/r/base/list.html) of
[nomad_model](https://ojwatson.github.io/nomad/reference/nomad_model.md)s.

Each model is named with a standard convention. For example, let's look
at `zmb_cdr_2020_mod_dd_exp`. Each of the names in the snake case name
convention refer either to the data that the model was fit using or the
type of model that was fit.

`zmb_cdr_2020_mod_dd_exp`:

- `zmb`: ISO3C county code for where data was collected.

- `cdr`: type of mobility data. cdr = Call Data Record.

- `2020`: year of data collection.

- `mod`: signifies the following labels relate to the model.

- `dd`: mobility model. dd = Departure-Diffusion.

- `exp`: sub-type of mobility model. exp = Exponential.

The naming conventions help with documenting the models and enable
linking to
[mobility_db](https://ojwatson.github.io/nomad/reference/mobility_db.md)
to query further information about the underlying mobility data the
model was fit using. All names in the snake case model name before `mod`
refer to the mobility data.

# Mobility database

Meta database of all mobility data sets that have been used in the
creation of the models stored in `nomad`

## Usage

``` r
mobility_db
```

## Format

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of mobility metadata with the following fields:

`mobility_db`:

- `name`: name of mobility data.

- `country`: ISO3C country code for where data was collected.

- `date_start`: start date of data collection.

- `date_end`: end date of data collection.

- `n`: number of data records.

- `type`: type of mobility data, e.g. call data records, facebook.

- `sampling_scheme`: free text description of sample scheme.

- `censoring`: free text description of any censoring.

- `aggregation`: spatial scale of aggregation, e.g. admin_2.

- `publication`: URL for associated publication or raw data.

- `has_fitted_models`: whether at least one fitted model is in
  `model_db`.

- `prediction_period_days`: interval represented by predictions; NA if
  unknown.

- `distance_unit`: fitted distance unit (`m` or `km`); NA if unknown.

- `provenance`: fitting recipe and supplied model attribution.

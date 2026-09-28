# Query mobility datasets

Returns the mobility dataset catalogue, optionally filtered by common
fields used when selecting an appropriate model.

## Usage

``` r
mobility_table(
  country = NULL,
  data_name = NULL,
  data_type = NULL,
  aggregation = NULL
)
```

## Arguments

- country:

  Optional ISO3C country code or vector of codes.

- data_name:

  Optional mobility dataset name.

- data_type:

  Optional mobility data type, such as `"facebook"` or
  `"call data record"`.

- aggregation:

  Optional spatial aggregation level, such as `"admin_2"`.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
containing rows from
[mobility_db](https://ojwatson.github.io/nomad/reference/mobility_db.md).

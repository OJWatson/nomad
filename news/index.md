# Changelog

## nomad 0.2.0

- Adds 612 Facebook fits across 51 country/territory datasets, with fit
  diagnostics and source-region maps
  ([\#10](https://github.com/OJWatson/nomad/issues/10)).
- Adds model profiles and spatial-scale queries
  ([\#9](https://github.com/OJWatson/nomad/issues/9)).
- Checks prediction locations, spatial scale and population size, and
  converts declared distance units
  ([\#11](https://github.com/OJWatson/nomad/issues/11),
  [\#12](https://github.com/OJWatson/nomad/issues/12),
  [\#18](https://github.com/OJWatson/nomad/issues/18)).
- Supports prediction durations, with an error when the source period is
  unknown ([\#17](https://github.com/OJWatson/nomad/issues/17)).
- Adds weighted ensembles, uncertainty summaries and prediction
  comparisons ([\#13](https://github.com/OJWatson/nomad/issues/13),
  [\#14](https://github.com/OJWatson/nomad/issues/14),
  [\#15](https://github.com/OJWatson/nomad/issues/15)).
- Adds model-selection and outbreak guides, and improves the README and
  catalogue ([\#16](https://github.com/OJWatson/nomad/issues/16)).
- Fixes radiation prediction, seeded simulation and Windows builds.

## nomad 0.1.0

- Introduces `nomad_model` and the original Zambia CDR and Facebook
  fits, including support for models whose trip data cannot be shared
  ([\#1](https://github.com/OJWatson/nomad/issues/1),
  [\#2](https://github.com/OJWatson/nomad/issues/2)).
- Adds model diagnostics and a browsable model/data catalogue
  ([\#3](https://github.com/OJWatson/nomad/issues/3),
  [\#4](https://github.com/OJWatson/nomad/issues/4),
  [\#5](https://github.com/OJWatson/nomad/issues/5)).
- Adds WorldPop downloads and population extraction for spatial
  boundaries ([\#6](https://github.com/OJWatson/nomad/issues/6),
  [\#7](https://github.com/OJWatson/nomad/issues/7)).
- Adds an introductory workflow and package website
  ([\#8](https://github.com/OJWatson/nomad/issues/8)).

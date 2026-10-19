# Package Structure

This vignette describes how `nomad` links fitted models to information
about their source data, and what happens when we use a model to make a
prediction. It may be useful if you want to understand the package
objects or contribute a model of your own.

## Core Objects

The central object is a `nomad_model`, which contains a
[`mobility::mobility()`](https://rdrr.io/pkg/mobility/man/mobility.html)
model together with its source metadata and saved fit checks. It is an
R6 object, so its methods can be called with `$`, for example
`model$get_model()` to retrieve the underlying mobility model. Functions
such as `predict(model)` and `summary(model)` provide the usual R
interface to common operations.

The package data objects are:

1.  `model_db`: a named list of fitted `nomad_model` objects.
2.  `mobility_db`: a table describing the source mobility datasets.

The link between them is the source data name. For example,
`zmb_fb_2020_mod_grav_exp` is a model fit to the `zmb_fb_2020` mobility
dataset.

## User Workflow

A typical analysis has five steps:

1.  Search
    [`mobility_table()`](https://ojwatson.github.io/nomad/reference/mobility_table.md)
    and
    [`model_table()`](https://ojwatson.github.io/nomad/reference/model_table.md)
    for relevant source data and fitted models.
2.  Inspect the source scale with
    [`model_profile()`](https://ojwatson.github.io/nomad/reference/model_profile.md).
3.  Prepare prediction data: a distance matrix and population vector.
4.  Predict a mobility matrix with
    [`predict()`](https://rdrr.io/r/stats/predict.html).
5.  Inspect warnings and compare predictions or ensembles to see how
    model choice affects the analysis.

Population helpers such as
[`get_pop()`](https://ojwatson.github.io/nomad/reference/get_pop.md) and
[`unpack_pop()`](https://ojwatson.github.io/nomad/reference/unpack_pop.md)
support the data preparation step, but users can also supply their own
population vectors and distance matrices directly.

## From stored fit to prediction

The model database contains 612 Facebook fits across 51 country or
territory datasets, together with the two original Zambia fits. Several
model families can be fit to the same dataset, which is why there are
many more models than source datasets. The `has_fitted_models` column in
`mobility_db` is calculated from this link and tells us whether an entry
has models available for use. This also allows a dataset to be described
in the catalogue before its models have been contributed to the model
database.

For the newer Facebook datasets, the observed trip matrices are private
and are removed before the models are packaged. The distances and
population sizes are stored separately in `inst/extdata/model_data`,
with one copy per dataset shared by its fitted models. Calling
`get_model()` restores these covariates when they are needed for a
prediction. We also retain the supplied fit statistics and diagnostic
plots, allowing users to inspect the source fit without access to the
underlying trip observations.

Both `predict(model)` and `model$predict()` use the same prediction
method. Before calling `mobility`, this method checks that the supplied
distances and populations refer to the same regions, matches named
inputs to their required order, and converts distances from the user’s
declared units to those used for fitting. It also checks whether the
model supports prediction for the requested setting. These checks are
useful when comparing several models, since their original datasets may
use different units or contain different sets of regions.

Most model families can predict for new populations and distances using
their fitted parameters. Basic and finite radiation models instead
retain a prediction matrix tied to their original regions and
populations. `nomad` checks this restriction before asking `mobility`
for a prediction, including when the model is part of an ensemble. This
prevents a stored matrix from being returned as though it described a
different set of regions. A new radiation prediction needs to be
calculated from the inputs for that new setting.

Duration conversion takes place using the prediction period in the model
metadata. This period describes the interval represented by the
predicted counts and can differ from the dates over which observations
were collected. For example, a matrix averaged across several weekly
observations would still need a period for the counts in each matrix,
rather than the length of the whole collection window. Allowing an
unknown period in the metadata means that a contributed model can still
be included before all its source information is available. Its unscaled
predictions can be explored with a warning, while operations that
require the missing information, such as conversion to a chosen number
of days, raise an error. Completing the metadata makes the same model
useful for a wider range of analyses.

An ensemble calls the prediction method for each component before
combining the results. The output matrices are matched by their
target-region names, so the models can have been fit in different places
as long as they can predict for the same requested regions. Their
prediction periods must also agree, or be convertible to a common
duration. Finally, named weights are matched to their models and used to
average the aligned trip counts. Matching by name makes this independent
of the order in which models happen to appear in a table.

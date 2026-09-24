# nomad 0.2.0

* Adds 612 supplied Facebook fits across 51 country/territory datasets, with
  shared public covariates, saved diagnostics and JHU fitting provenance.
* Surfaces stored R-hat and effective sample size diagnostics without altering
  supplied parameters; flagged fits require scientific review.
* Adds explicit fitted-model availability, prediction periods and distance units.
  New Facebook predictions represent 21 days. Original Zambia periods remain
  unknown; duration conversion now errors rather than guessing from collection dates.
* Converts declared prediction distances to fitted units. The original Zambia
  CDR fit uses metres and the original Facebook fit uses kilometres.
* Repairs departure-diffusion radiation prediction for new regions and unifies
  S3 and R6 prediction. Basic/finite radiation supports its original setting;
  unsupported direct/ensemble requests now produce explanatory errors.
* Makes seeded prediction reproducible in a fresh R session without changing
  the caller's random-number state.
* Matches named weights and target regions, rejects invalid weights and missing
  requested fit metrics, and handles zero-error weights and zero baselines.
  Scripts relying on silent equal-weight fallback must choose weights explicitly.
* Adds source-region mapping and `compare_models()`, a reusable interactive
  ensemble comparison. Vignettes explain the workflow and fold long code blocks.
* Simplifies the outbreak example to fully observed stochastic SIR infections,
  with fixed transmission assumptions and no fitted reporting fraction.
* Updates package workflows, restores Windows checks, and adds offline population
  helper tests. CRAN distribution and the three missing older CDR fits are deferred.

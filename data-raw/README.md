# Rebuilding the model catalogue

The country scripts document fitting with `mobility` and importing the supplied
JHU Facebook model archives. Normal imports preserve archived parameters; the
`NOMAD_<ISO>_REFIT` switches explicitly request refitting. Private `M` inputs are
read locally and excluded from version control and installed model objects.

The current source archives are `MODEL_INPUT.zip` and `MODEL_OUTPUT.zip`, with
the supplied README documenting an average 21-day target matrix. Collection dates
remain separate metadata. `NOMAD_MODEL_INPUT_ZIP` and `NOMAD_MODEL_OUTPUT_ZIP`
can point to archives outside the default local `analysis` directory.

From the repository root:

1. Run country scripts when importing new supplied fits. They preserve public
   covariates once per dataset and save diagnostic references in model wrappers.
2. Run `source("data-raw/source_metadata.R")` with the input archive available.
   This checks fitted distance scales against centroid distances in metres and
   saves the source points used by the catalogue map. Its GADM ID matching ignores
   version suffixes and the optional separator after the country code; it does
   not claim identical boundary versions. All current source regions match.
3. Run `source("data-raw/mobility_db.R")` after model registration. This derives
   `has_fitted_models` from the actual database and adds periods, units and provenance.
4. Run `nomad:::rebuild_model_db()` when wrapper methods change, then regenerate
   metadata and documentation. This rebuilds wrappers without fitting parameters.

The original Zambia CDR fit uses metres; the original Facebook fit uses
kilometres. Their shared-region distances differ by exactly 1,000. The original
Facebook public D/N files now match the 19-region fitted object. Both original
prediction periods remain NA pending provider confirmation.

The three metadata-only CDR entries are intentionally retained without fits.
Add their data/recipes when available; do not substitute newer Facebook fits.

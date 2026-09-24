# Separate mobility generics patch (#19)

`mobility-generics.patch` targets upstream commit
`c9ef27c55d30ef01545860620c9e6bf97e85487b`. It removes custom exported
`predict`, `summary` and `residuals` generics while retaining their registered
S3 methods. `check` remains a package generic.

The patched package was installed into an isolated library. With its namespace
loaded, `stats::predict()`, `base::summary()` and `stats::residuals()` successfully
dispatched on the original Zambia fitted object.

This is an upstream proposal, not the dependency used by this release. Removing
exports changes qualified calls such as `mobility::predict()`, so an upstream
release needs migration notes and downstream compatibility changes. nomad pins
its tested mobility revision while that proposal is reviewed.

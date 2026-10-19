# Models and Mobility Data

This page brings together the mobility datasets and fitted models
available in `nomad`. If you have a particular country in mind, you can
start by finding its datasets in the first table, then use the map to
explore their coverage. The model table and diagnostic plots further
down the page show which models were fit to those data and how well they
reproduced the observed flows.

You can browse everything here without running any code. Each section
also has an expandable code panel if you would like to make the same
tables or plots in R, for example to restrict a comparison to the
datasets relevant to your analysis.

## Mobility Data

The first table describes the source data. Alongside the country, it
helps to look at the spatial scale and collection dates, since these
determine which movements a model has been fit to explain. For example,
movement between large administrative areas may provide little
information about short journeys within a town. Expanding a row gives
more detail on how the data were sampled and whether flows below a
reporting threshold were suppressed. Both can affect the observed
pattern of movement.

To find a dataset, type its name or country code in the search box, or
click a column heading to sort the table. The fitted-models column
distinguishes entries we can already use for prediction from datasets
for which we currently hold only metadata. Those entries remain in the
table so that the catalogue also records data that may become available
later.

Show how to browse mobility datasets in R

``` r

datasets <- mobility_table()
reactable::reactable(
  datasets[, c("name", "country", "type", "n", "aggregation", "date_start",
                "date_end", "has_fitted_models")],
  searchable = TRUE, resizable = TRUE, wrap = FALSE,
  bordered = TRUE, highlight = TRUE,
  showPageSizeOptions = TRUE, pageSizeOptions = c(4, 8, 12, 24), defaultPageSize = 8,
  defaultSorted = list(date_start = "desc"),
  defaultColDef = reactable::colDef(minWidth = 100),
  theme = reactable::reactableTheme(highlightColor = "#eaf4f8"),
  columns = list(
    name = reactable::colDef(name = "Dataset", sticky = "left", minWidth = 175,
                             style = list(borderRight = "1px solid #ccd5da")),
    country = reactable::colDef(name = "ISO3", minWidth = 65),
    type = reactable::colDef(name = "Data", minWidth = 130),
    n = reactable::colDef(name = "Records", minWidth = 140, format = reactable::colFormat(digits = 0, separators = TRUE)),
    aggregation = reactable::colDef(name = "Spatial scale"),
    date_start = reactable::colDef(name = "Start"),
    date_end = reactable::colDef(name = "End"),
    has_fitted_models = reactable::colDef(name = "Fitted models", minWidth = 140,
                                          cell = function(x) if (x) "Yes" else "Not yet")
  ),
  details = function(index) {
    row <- datasets[index, ]
    period <- if (is.na(row$prediction_period_days)) "Unknown" else
      paste(row$prediction_period_days, "days")
    htmltools::tags$div(style = "padding: 12px; white-space: normal;",
      htmltools::tags$p(htmltools::tags$b("Sampling: "), row$sampling_scheme),
      htmltools::tags$p(htmltools::tags$b("Censoring: "),
                        if (is.na(row$censoring)) "Not specified" else row$censoring),
      htmltools::tags$p(htmltools::tags$b("Prediction period: "), period),
      if (!is.na(row$publication)) htmltools::tags$a("Publication", href = row$publication)
    )
  }
)
```

The start and end dates refer to the collection window. They do not
necessarily tell us the period represented by a predicted trip count,
particularly when the matrix used for fitting is an average of repeated
observations. You can see the prediction period by expanding the
dataset’s row. Predictions from the newer Facebook models represent trip
counts over 21 days.

The catalogue can also include shared data and models whose source
metadata are incomplete. The Zambia Facebook and CDR models from 2020
are examples for which the prediction period is unavailable. Keeping
these models accessible allows us to explore their movement patterns,
but the missing period limits their use for predicting trip totals over
a particular duration. An unknown entry in the table is therefore a
reason to consider what information your analysis requires.

## Where are the data from?

The map gives an overview of where the catalogued data come from. Use
the buttons in the top right to switch between Facebook and call data
records, then click a country to see its dataset details. Where several
datasets cover the same country and source, the map displays the most
recent one. You can find the others in the table above.

Darker shading indicates a larger number of records. This helps show the
scale of each dataset, although it should not be interpreted as a direct
comparison of travel rates because the sampling methods, record
definitions and collection periods differ. For the newer Facebook
datasets, the source-region selector also adds the administrative
centroids used in the model inputs. This lets you look more closely at
the spatial scale represented by a particular dataset.

Show how to make the coverage map in R

``` r

world <- rnaturalearth::ne_countries(scale = "medium", type = "map_units",
                                       returnclass = "sf")
locations <- readRDS(system.file("extdata", "source_locations.rds", package = "nomad"))
map_data <- datasets[order(datasets$date_end, decreasing = TRUE, na.last = TRUE), ]
map_data <- map_data[!duplicated(paste(map_data$country, map_data$type)), ]
world$country <- world$iso_a3
world$country[world$country == "-99"] <- world$adm0_a3[world$country == "-99"]
coverage <- merge(world[, c("country", "name_long")], map_data, by = "country")
coverage$log_records <- log10(coverage$n)
coverage$popup <- paste0(
  "<b>", coverage$name_long, "</b><br>", coverage$name,
  "<br>", coverage$date_start, " to ", coverage$date_end,
  "<br>Records: ", format(round(coverage$n), big.mark = ",", scientific = FALSE, trim = TRUE),
  "<br>Spatial scale: ", coverage$aggregation,
  "<br>Fitted models: ", ifelse(coverage$has_fitted_models, "available", "not yet available")
)
palette <- leaflet::colorBin("YlOrBr", domain = coverage$log_records, bins = 5)
map <- leaflet::leaflet(coverage, width = "100%", height = 550)
map <- leaflet::addMapPane(map, "land", zIndex = 200)
map <- leaflet::addPolygons(map, data = world,
  color = "#bdc8cc", weight = 0.5, fillColor = "#f7f7f2", fillOpacity = 1,
  options = leaflet::pathOptions(pane = "land", interactive = FALSE,
    attribution = 'Boundaries: <a href="https://www.naturalearthdata.com/">Natural Earth</a>'))
for (source in c("facebook", "call data record")) {
  layer <- coverage[coverage$type == source, ]
  group <- if (source == "facebook") "Facebook" else "Call data records"
  map <- leaflet::addPolygons(map, data = layer, group = group,
    fillColor = ~palette(log_records), fillOpacity = 0.75,
    color = "#8c949b", weight = 1, popup = ~popup, label = ~name_long,
    highlightOptions = leaflet::highlightOptions(weight = 3, color = "#2c3e50",
                                                  bringToFront = TRUE))
}
map <- leaflet::addLayersControl(map, baseGroups = c("Facebook", "Call data records"),
                                 options = leaflet::layersControlOptions(collapsed = FALSE))
map <- leaflet::hideGroup(map, "Call data records")
map <- leaflet::addLegend(map, pal = palette, values = ~log_records,
                          title = "Records (log10)", position = "bottomleft")
ids <- sort(unique(locations$data_name))
for (id in ids) {
  points <- locations[locations$data_name == id, ]
  map <- leaflet::addCircleMarkers(map, data = points, lng = ~lon, lat = ~lat,
    radius = 3, color = "#2166ac", fillOpacity = 0.85, group = id,
    popup = ~htmltools::htmlEscape(label))
}
map <- leaflet::hideGroup(map, ids)
map <- leaflet::fitBounds(map, lng1 = -26, lat1 = -36, lng2 = 63, lat2 = 39)
htmlwidgets::onRender(map, '
function(el, x, ids) {
  var map = this;
  var control = L.control({position: "topright"});
  control.onAdd = function() {
    var label = L.DomUtil.create("label");
    label.style.cssText = "background: white; padding: 8px; border-radius: 4px";
    label.textContent = "Source regions: ";
    var select = document.createElement("select");
    select.setAttribute("aria-label", "Source dataset");
    var none = document.createElement("option");
    none.value = ""; none.textContent = "Country coverage";
    select.appendChild(none);
    ids.forEach(function(id) {
      var option = document.createElement("option");
      option.value = id; option.textContent = id;
      select.appendChild(option);
    });
    select.onchange = function() {
      ids.forEach(function(id) {
        var group = map.layerManager.getLayerGroup(id);
        if (group) map.removeLayer(group);
      });
      var selected = map.layerManager.getLayerGroup(select.value);
      if (selected && select.value) {
        map.addLayer(selected);
        map.fitBounds(L.featureGroup(selected.getLayers()).getBounds());
      } else {
        map.fitBounds([[-36, -26], [39, 63]]);
      }
    };
    label.appendChild(select);
    L.DomEvent.disableClickPropagation(label);
    L.DomEvent.disableScrollPropagation(label);
    return label;
  };
  control.addTo(map);
}', data = ids)
```

## Model Performance

Once you have identified a source dataset, use its name to find the
corresponding fits in the model table. You can also filter the columns
by country, model family or type. Clicking a fit statistic sorts the
table, which is useful for comparing models fit to the same
observations.

The error measures need to be interpreted in relation to those
observations. A small RMSE for a dataset with relatively few trips does
not demonstrate a better model than a larger RMSE for a dataset with
much higher counts. It is therefore helpful to narrow the table to one
dataset before comparing fit errors, and then inspect the plots below to
understand which flows each model misses. Some statistics were not
supplied for every fit. In particular, missing values for the deviance
information criterion (DIC) mean that those models cannot be included
when calculating weights from that statistic.

Show how to compare fitted models in R

``` r

models <- model_table()
reactable::reactable(
  models[, c("name", "country", "mobility_model", "model_type", "RMSE", "MAPE",
              "R2", "DIC", "max_rhat", "supports_newdata")],
  searchable = TRUE, filterable = TRUE, resizable = TRUE, wrap = FALSE,
  bordered = TRUE, highlight = TRUE,
  defaultSorted = list(R2 = "desc"),
  showPageSizeOptions = TRUE, pageSizeOptions = c(4, 8, 12, 24), defaultPageSize = 8,
  theme = reactable::reactableTheme(highlightColor = "#eaf4f8"),
  defaultColDef = reactable::colDef(minWidth = 90),
  columns = list(
    name = reactable::colDef(name = "Model", sticky = "left", minWidth = 260,
                             style = list(borderRight = "1px solid #ccd5da")),
    country = reactable::colDef(name = "ISO3", minWidth = 65),
    mobility_model = reactable::colDef(name = "Family", minWidth = 150),
    model_type = reactable::colDef(name = "Type", minWidth = 120),
    RMSE = reactable::colDef(format = reactable::colFormat(digits = 1, separators = TRUE)),
    MAPE = reactable::colDef(format = reactable::colFormat(digits = 2)),
    R2 = reactable::colDef(format = reactable::colFormat(digits = 3)),
    DIC = reactable::colDef(format = reactable::colFormat(digits = 0, separators = TRUE)),
    max_rhat = reactable::colDef(name = "Max R-hat"),
    supports_newdata = reactable::colDef(name = "New regions", minWidth = 100)
  )
)
```

The maximum R-hat column summarises a different aspect of the fit. R-hat
compares variation within and between sampling chains, so a high value
suggests that the chains have not adequately explored the same parameter
distribution. Those fits need further convergence review before relying
on their parameter estimates. A value close to one is encouraging, but
you should also inspect the parameter-level summaries available through
`summary(model)` and consider whether the source data suit your
application.

The final column indicates whether a model can predict for new regions.
Basic and finite radiation models are restricted to their original
regions and populations, even when their stored fit statistics look
favourable. Other model families can be applied to new inputs, with
checks and warnings described in the [model selection
vignette](https://ojwatson.github.io/nomad/articles/selecting-a-model.md).

## Model Fit Checks

Choose a model from the dropdown to inspect its saved diagnostic plot.
The first panel compares observed and predicted flows, while the
residual panel shows the differences between them. For example, a model
may reproduce the largest flows reasonably well but consistently miss
smaller ones. Such a pattern can matter for an analysis of how infection
reaches less connected regions, even when the overall error appears
small.

These plots describe agreement with the data used to fit each model.
They help us understand that fit, but do not tell us how well it will
predict movement in a different place or period. The code below the plot
shows how to retrieve the same checks and parameter summaries for a
selected model in R.

Model: ago_fb_2025_mod_dd_exp ago_fb_2025_mod_dd_power
ago_fb_2025_mod_dd_radiation ago_fb_2025_mod_grav_basic
ago_fb_2025_mod_grav_exp ago_fb_2025_mod_grav_exp_norm
ago_fb_2025_mod_grav_power ago_fb_2025_mod_grav_power_norm
ago_fb_2025_mod_grav_scaled_power ago_fb_2025_mod_grav_transport
ago_fb_2025_mod_rad_basic ago_fb_2025_mod_rad_finite
bdi_fb_2025_mod_dd_exp bdi_fb_2025_mod_dd_power
bdi_fb_2025_mod_dd_radiation bdi_fb_2025_mod_grav_basic
bdi_fb_2025_mod_grav_exp bdi_fb_2025_mod_grav_exp_norm
bdi_fb_2025_mod_grav_power bdi_fb_2025_mod_grav_power_norm
bdi_fb_2025_mod_grav_scaled_power bdi_fb_2025_mod_grav_transport
bdi_fb_2025_mod_rad_basic bdi_fb_2025_mod_rad_finite
ben_fb_2025_mod_dd_exp ben_fb_2025_mod_dd_power
ben_fb_2025_mod_dd_radiation ben_fb_2025_mod_grav_basic
ben_fb_2025_mod_grav_exp ben_fb_2025_mod_grav_exp_norm
ben_fb_2025_mod_grav_power ben_fb_2025_mod_grav_power_norm
ben_fb_2025_mod_grav_scaled_power ben_fb_2025_mod_grav_transport
ben_fb_2025_mod_rad_basic ben_fb_2025_mod_rad_finite
bfa_fb_2025_mod_dd_exp bfa_fb_2025_mod_dd_power
bfa_fb_2025_mod_dd_radiation bfa_fb_2025_mod_grav_basic
bfa_fb_2025_mod_grav_exp bfa_fb_2025_mod_grav_exp_norm
bfa_fb_2025_mod_grav_power bfa_fb_2025_mod_grav_power_norm
bfa_fb_2025_mod_grav_scaled_power bfa_fb_2025_mod_grav_transport
bfa_fb_2025_mod_rad_basic bfa_fb_2025_mod_rad_finite
bwa_fb_2025_mod_dd_exp bwa_fb_2025_mod_dd_power
bwa_fb_2025_mod_dd_radiation bwa_fb_2025_mod_grav_basic
bwa_fb_2025_mod_grav_exp bwa_fb_2025_mod_grav_exp_norm
bwa_fb_2025_mod_grav_power bwa_fb_2025_mod_grav_power_norm
bwa_fb_2025_mod_grav_scaled_power bwa_fb_2025_mod_grav_transport
bwa_fb_2025_mod_rad_basic bwa_fb_2025_mod_rad_finite
caf_fb_2025_mod_dd_exp caf_fb_2025_mod_dd_power
caf_fb_2025_mod_dd_radiation caf_fb_2025_mod_grav_basic
caf_fb_2025_mod_grav_exp caf_fb_2025_mod_grav_exp_norm
caf_fb_2025_mod_grav_power caf_fb_2025_mod_grav_power_norm
caf_fb_2025_mod_grav_scaled_power caf_fb_2025_mod_grav_transport
caf_fb_2025_mod_rad_basic caf_fb_2025_mod_rad_finite
civ_fb_2025_mod_dd_exp civ_fb_2025_mod_dd_power
civ_fb_2025_mod_dd_radiation civ_fb_2025_mod_grav_basic
civ_fb_2025_mod_grav_exp civ_fb_2025_mod_grav_exp_norm
civ_fb_2025_mod_grav_power civ_fb_2025_mod_grav_power_norm
civ_fb_2025_mod_grav_scaled_power civ_fb_2025_mod_grav_transport
civ_fb_2025_mod_rad_basic civ_fb_2025_mod_rad_finite
cmr_fb_2025_mod_dd_exp cmr_fb_2025_mod_dd_power
cmr_fb_2025_mod_dd_radiation cmr_fb_2025_mod_grav_basic
cmr_fb_2025_mod_grav_exp cmr_fb_2025_mod_grav_exp_norm
cmr_fb_2025_mod_grav_power cmr_fb_2025_mod_grav_power_norm
cmr_fb_2025_mod_grav_scaled_power cmr_fb_2025_mod_grav_transport
cmr_fb_2025_mod_rad_basic cmr_fb_2025_mod_rad_finite
com_fb_2025_mod_dd_exp com_fb_2025_mod_dd_power
com_fb_2025_mod_dd_radiation com_fb_2025_mod_grav_basic
com_fb_2025_mod_grav_exp com_fb_2025_mod_grav_exp_norm
com_fb_2025_mod_grav_power com_fb_2025_mod_grav_power_norm
com_fb_2025_mod_grav_scaled_power com_fb_2025_mod_grav_transport
com_fb_2025_mod_rad_basic com_fb_2025_mod_rad_finite
cpv_fb_2025_mod_dd_exp cpv_fb_2025_mod_dd_power
cpv_fb_2025_mod_dd_radiation cpv_fb_2025_mod_grav_basic
cpv_fb_2025_mod_grav_exp cpv_fb_2025_mod_grav_exp_norm
cpv_fb_2025_mod_grav_power cpv_fb_2025_mod_grav_power_norm
cpv_fb_2025_mod_grav_scaled_power cpv_fb_2025_mod_grav_transport
cpv_fb_2025_mod_rad_basic cpv_fb_2025_mod_rad_finite
dji_fb_2025_mod_dd_exp dji_fb_2025_mod_dd_power
dji_fb_2025_mod_dd_radiation dji_fb_2025_mod_grav_basic
dji_fb_2025_mod_grav_exp dji_fb_2025_mod_grav_exp_norm
dji_fb_2025_mod_grav_power dji_fb_2025_mod_grav_power_norm
dji_fb_2025_mod_grav_scaled_power dji_fb_2025_mod_grav_transport
dji_fb_2025_mod_rad_basic dji_fb_2025_mod_rad_finite
dza_fb_2025_mod_dd_exp dza_fb_2025_mod_dd_power
dza_fb_2025_mod_dd_radiation dza_fb_2025_mod_grav_basic
dza_fb_2025_mod_grav_exp dza_fb_2025_mod_grav_exp_norm
dza_fb_2025_mod_grav_power dza_fb_2025_mod_grav_power_norm
dza_fb_2025_mod_grav_scaled_power dza_fb_2025_mod_grav_transport
dza_fb_2025_mod_rad_basic dza_fb_2025_mod_rad_finite
egy_fb_2025_mod_dd_exp egy_fb_2025_mod_dd_power
egy_fb_2025_mod_dd_radiation egy_fb_2025_mod_grav_basic
egy_fb_2025_mod_grav_exp egy_fb_2025_mod_grav_exp_norm
egy_fb_2025_mod_grav_power egy_fb_2025_mod_grav_power_norm
egy_fb_2025_mod_grav_scaled_power egy_fb_2025_mod_grav_transport
egy_fb_2025_mod_rad_basic egy_fb_2025_mod_rad_finite
eri_fb_2025_mod_dd_exp eri_fb_2025_mod_dd_power
eri_fb_2025_mod_dd_radiation eri_fb_2025_mod_grav_basic
eri_fb_2025_mod_grav_exp eri_fb_2025_mod_grav_exp_norm
eri_fb_2025_mod_grav_power eri_fb_2025_mod_grav_power_norm
eri_fb_2025_mod_grav_scaled_power eri_fb_2025_mod_grav_transport
eri_fb_2025_mod_rad_basic eri_fb_2025_mod_rad_finite
eth_fb_2025_mod_dd_exp eth_fb_2025_mod_dd_power
eth_fb_2025_mod_dd_radiation eth_fb_2025_mod_grav_basic
eth_fb_2025_mod_grav_exp eth_fb_2025_mod_grav_exp_norm
eth_fb_2025_mod_grav_power eth_fb_2025_mod_grav_power_norm
eth_fb_2025_mod_grav_scaled_power eth_fb_2025_mod_grav_transport
eth_fb_2025_mod_rad_basic eth_fb_2025_mod_rad_finite
gab_fb_2025_mod_dd_exp gab_fb_2025_mod_dd_power
gab_fb_2025_mod_dd_radiation gab_fb_2025_mod_grav_basic
gab_fb_2025_mod_grav_exp gab_fb_2025_mod_grav_exp_norm
gab_fb_2025_mod_grav_power gab_fb_2025_mod_grav_power_norm
gab_fb_2025_mod_grav_scaled_power gab_fb_2025_mod_grav_transport
gab_fb_2025_mod_rad_basic gab_fb_2025_mod_rad_finite
gha_fb_2025_mod_dd_exp gha_fb_2025_mod_dd_power
gha_fb_2025_mod_dd_radiation gha_fb_2025_mod_grav_basic
gha_fb_2025_mod_grav_exp gha_fb_2025_mod_grav_exp_norm
gha_fb_2025_mod_grav_power gha_fb_2025_mod_grav_power_norm
gha_fb_2025_mod_grav_scaled_power gha_fb_2025_mod_grav_transport
gha_fb_2025_mod_rad_basic gha_fb_2025_mod_rad_finite
gin_fb_2025_mod_dd_exp gin_fb_2025_mod_dd_power
gin_fb_2025_mod_dd_radiation gin_fb_2025_mod_grav_basic
gin_fb_2025_mod_grav_exp gin_fb_2025_mod_grav_exp_norm
gin_fb_2025_mod_grav_power gin_fb_2025_mod_grav_power_norm
gin_fb_2025_mod_grav_scaled_power gin_fb_2025_mod_grav_transport
gin_fb_2025_mod_rad_basic gin_fb_2025_mod_rad_finite
gmb_fb_2025_mod_dd_exp gmb_fb_2025_mod_dd_power
gmb_fb_2025_mod_dd_radiation gmb_fb_2025_mod_grav_basic
gmb_fb_2025_mod_grav_exp gmb_fb_2025_mod_grav_exp_norm
gmb_fb_2025_mod_grav_power gmb_fb_2025_mod_grav_power_norm
gmb_fb_2025_mod_grav_scaled_power gmb_fb_2025_mod_grav_transport
gmb_fb_2025_mod_rad_basic gmb_fb_2025_mod_rad_finite
gnb_fb_2025_mod_dd_exp gnb_fb_2025_mod_dd_power
gnb_fb_2025_mod_dd_radiation gnb_fb_2025_mod_grav_basic
gnb_fb_2025_mod_grav_exp gnb_fb_2025_mod_grav_exp_norm
gnb_fb_2025_mod_grav_power gnb_fb_2025_mod_grav_power_norm
gnb_fb_2025_mod_grav_scaled_power gnb_fb_2025_mod_grav_transport
gnb_fb_2025_mod_rad_basic gnb_fb_2025_mod_rad_finite
gnq_fb_2025_mod_dd_exp gnq_fb_2025_mod_dd_power
gnq_fb_2025_mod_dd_radiation gnq_fb_2025_mod_grav_basic
gnq_fb_2025_mod_grav_exp gnq_fb_2025_mod_grav_exp_norm
gnq_fb_2025_mod_grav_power gnq_fb_2025_mod_grav_power_norm
gnq_fb_2025_mod_grav_scaled_power gnq_fb_2025_mod_grav_transport
gnq_fb_2025_mod_rad_basic gnq_fb_2025_mod_rad_finite
ken_fb_2025_mod_dd_exp ken_fb_2025_mod_dd_power
ken_fb_2025_mod_dd_radiation ken_fb_2025_mod_grav_basic
ken_fb_2025_mod_grav_exp ken_fb_2025_mod_grav_exp_norm
ken_fb_2025_mod_grav_power ken_fb_2025_mod_grav_power_norm
ken_fb_2025_mod_grav_scaled_power ken_fb_2025_mod_grav_transport
ken_fb_2025_mod_rad_basic ken_fb_2025_mod_rad_finite
lbr_fb_2025_mod_dd_exp lbr_fb_2025_mod_dd_power
lbr_fb_2025_mod_dd_radiation lbr_fb_2025_mod_grav_basic
lbr_fb_2025_mod_grav_exp lbr_fb_2025_mod_grav_exp_norm
lbr_fb_2025_mod_grav_power lbr_fb_2025_mod_grav_power_norm
lbr_fb_2025_mod_grav_scaled_power lbr_fb_2025_mod_grav_transport
lbr_fb_2025_mod_rad_basic lbr_fb_2025_mod_rad_finite
lby_fb_2025_mod_dd_exp lby_fb_2025_mod_dd_power
lby_fb_2025_mod_dd_radiation lby_fb_2025_mod_grav_basic
lby_fb_2025_mod_grav_exp lby_fb_2025_mod_grav_exp_norm
lby_fb_2025_mod_grav_power lby_fb_2025_mod_grav_power_norm
lby_fb_2025_mod_grav_scaled_power lby_fb_2025_mod_grav_transport
lby_fb_2025_mod_rad_basic lby_fb_2025_mod_rad_finite
lso_fb_2025_mod_dd_exp lso_fb_2025_mod_dd_power
lso_fb_2025_mod_dd_radiation lso_fb_2025_mod_grav_basic
lso_fb_2025_mod_grav_exp lso_fb_2025_mod_grav_exp_norm
lso_fb_2025_mod_grav_power lso_fb_2025_mod_grav_power_norm
lso_fb_2025_mod_grav_scaled_power lso_fb_2025_mod_grav_transport
lso_fb_2025_mod_rad_basic lso_fb_2025_mod_rad_finite
mar_fb_2025_mod_dd_exp mar_fb_2025_mod_dd_power
mar_fb_2025_mod_dd_radiation mar_fb_2025_mod_grav_basic
mar_fb_2025_mod_grav_exp mar_fb_2025_mod_grav_exp_norm
mar_fb_2025_mod_grav_power mar_fb_2025_mod_grav_power_norm
mar_fb_2025_mod_grav_scaled_power mar_fb_2025_mod_grav_transport
mar_fb_2025_mod_rad_basic mar_fb_2025_mod_rad_finite
mdg_fb_2025_mod_dd_exp mdg_fb_2025_mod_dd_power
mdg_fb_2025_mod_dd_radiation mdg_fb_2025_mod_grav_basic
mdg_fb_2025_mod_grav_exp mdg_fb_2025_mod_grav_exp_norm
mdg_fb_2025_mod_grav_power mdg_fb_2025_mod_grav_power_norm
mdg_fb_2025_mod_grav_scaled_power mdg_fb_2025_mod_grav_transport
mdg_fb_2025_mod_rad_basic mdg_fb_2025_mod_rad_finite
mli_fb_2025_mod_dd_exp mli_fb_2025_mod_dd_power
mli_fb_2025_mod_dd_radiation mli_fb_2025_mod_grav_basic
mli_fb_2025_mod_grav_exp mli_fb_2025_mod_grav_exp_norm
mli_fb_2025_mod_grav_power mli_fb_2025_mod_grav_power_norm
mli_fb_2025_mod_grav_scaled_power mli_fb_2025_mod_grav_transport
mli_fb_2025_mod_rad_basic mli_fb_2025_mod_rad_finite
moz_fb_2025_mod_dd_exp moz_fb_2025_mod_dd_power
moz_fb_2025_mod_dd_radiation moz_fb_2025_mod_grav_basic
moz_fb_2025_mod_grav_exp moz_fb_2025_mod_grav_exp_norm
moz_fb_2025_mod_grav_power moz_fb_2025_mod_grav_power_norm
moz_fb_2025_mod_grav_scaled_power moz_fb_2025_mod_grav_transport
moz_fb_2025_mod_rad_basic moz_fb_2025_mod_rad_finite
mrt_fb_2025_mod_dd_exp mrt_fb_2025_mod_dd_power
mrt_fb_2025_mod_dd_radiation mrt_fb_2025_mod_grav_basic
mrt_fb_2025_mod_grav_exp mrt_fb_2025_mod_grav_exp_norm
mrt_fb_2025_mod_grav_power mrt_fb_2025_mod_grav_power_norm
mrt_fb_2025_mod_grav_scaled_power mrt_fb_2025_mod_grav_transport
mrt_fb_2025_mod_rad_basic mrt_fb_2025_mod_rad_finite
mus_fb_2025_mod_dd_exp mus_fb_2025_mod_dd_power
mus_fb_2025_mod_dd_radiation mus_fb_2025_mod_grav_basic
mus_fb_2025_mod_grav_exp mus_fb_2025_mod_grav_exp_norm
mus_fb_2025_mod_grav_power mus_fb_2025_mod_grav_power_norm
mus_fb_2025_mod_grav_scaled_power mus_fb_2025_mod_grav_transport
mus_fb_2025_mod_rad_basic mus_fb_2025_mod_rad_finite
mwi_fb_2025_mod_dd_exp mwi_fb_2025_mod_dd_power
mwi_fb_2025_mod_dd_radiation mwi_fb_2025_mod_grav_basic
mwi_fb_2025_mod_grav_exp mwi_fb_2025_mod_grav_exp_norm
mwi_fb_2025_mod_grav_power mwi_fb_2025_mod_grav_power_norm
mwi_fb_2025_mod_grav_scaled_power mwi_fb_2025_mod_grav_transport
mwi_fb_2025_mod_rad_basic mwi_fb_2025_mod_rad_finite
myt_fb_2025_mod_dd_exp myt_fb_2025_mod_dd_power
myt_fb_2025_mod_dd_radiation myt_fb_2025_mod_grav_basic
myt_fb_2025_mod_grav_exp myt_fb_2025_mod_grav_exp_norm
myt_fb_2025_mod_grav_power myt_fb_2025_mod_grav_power_norm
myt_fb_2025_mod_grav_scaled_power myt_fb_2025_mod_grav_transport
myt_fb_2025_mod_rad_basic myt_fb_2025_mod_rad_finite
nam_fb_2025_mod_dd_exp nam_fb_2025_mod_dd_power
nam_fb_2025_mod_dd_radiation nam_fb_2025_mod_grav_basic
nam_fb_2025_mod_grav_exp nam_fb_2025_mod_grav_exp_norm
nam_fb_2025_mod_grav_power nam_fb_2025_mod_grav_power_norm
nam_fb_2025_mod_grav_scaled_power nam_fb_2025_mod_grav_transport
nam_fb_2025_mod_rad_basic nam_fb_2025_mod_rad_finite
ner_fb_2025_mod_dd_exp ner_fb_2025_mod_dd_power
ner_fb_2025_mod_dd_radiation ner_fb_2025_mod_grav_basic
ner_fb_2025_mod_grav_exp ner_fb_2025_mod_grav_exp_norm
ner_fb_2025_mod_grav_power ner_fb_2025_mod_grav_power_norm
ner_fb_2025_mod_grav_scaled_power ner_fb_2025_mod_grav_transport
ner_fb_2025_mod_rad_basic ner_fb_2025_mod_rad_finite
nga_fb_2025_mod_dd_exp nga_fb_2025_mod_dd_power
nga_fb_2025_mod_dd_radiation nga_fb_2025_mod_grav_basic
nga_fb_2025_mod_grav_exp nga_fb_2025_mod_grav_exp_norm
nga_fb_2025_mod_grav_power nga_fb_2025_mod_grav_power_norm
nga_fb_2025_mod_grav_scaled_power nga_fb_2025_mod_grav_transport
nga_fb_2025_mod_rad_basic nga_fb_2025_mod_rad_finite
rwa_fb_2025_mod_dd_exp rwa_fb_2025_mod_dd_power
rwa_fb_2025_mod_dd_radiation rwa_fb_2025_mod_grav_basic
rwa_fb_2025_mod_grav_exp rwa_fb_2025_mod_grav_exp_norm
rwa_fb_2025_mod_grav_power rwa_fb_2025_mod_grav_power_norm
rwa_fb_2025_mod_grav_scaled_power rwa_fb_2025_mod_grav_transport
rwa_fb_2025_mod_rad_basic rwa_fb_2025_mod_rad_finite
sen_fb_2025_mod_dd_exp sen_fb_2025_mod_dd_power
sen_fb_2025_mod_dd_radiation sen_fb_2025_mod_grav_basic
sen_fb_2025_mod_grav_exp sen_fb_2025_mod_grav_exp_norm
sen_fb_2025_mod_grav_power sen_fb_2025_mod_grav_power_norm
sen_fb_2025_mod_grav_scaled_power sen_fb_2025_mod_grav_transport
sen_fb_2025_mod_rad_basic sen_fb_2025_mod_rad_finite
sle_fb_2025_mod_dd_exp sle_fb_2025_mod_dd_power
sle_fb_2025_mod_dd_radiation sle_fb_2025_mod_grav_basic
sle_fb_2025_mod_grav_exp sle_fb_2025_mod_grav_exp_norm
sle_fb_2025_mod_grav_power sle_fb_2025_mod_grav_power_norm
sle_fb_2025_mod_grav_scaled_power sle_fb_2025_mod_grav_transport
sle_fb_2025_mod_rad_basic sle_fb_2025_mod_rad_finite
ssd_fb_2025_mod_dd_exp ssd_fb_2025_mod_dd_power
ssd_fb_2025_mod_dd_radiation ssd_fb_2025_mod_grav_basic
ssd_fb_2025_mod_grav_exp ssd_fb_2025_mod_grav_exp_norm
ssd_fb_2025_mod_grav_power ssd_fb_2025_mod_grav_power_norm
ssd_fb_2025_mod_grav_scaled_power ssd_fb_2025_mod_grav_transport
ssd_fb_2025_mod_rad_basic ssd_fb_2025_mod_rad_finite
stp_fb_2025_mod_dd_exp stp_fb_2025_mod_dd_power
stp_fb_2025_mod_dd_radiation stp_fb_2025_mod_grav_basic
stp_fb_2025_mod_grav_exp stp_fb_2025_mod_grav_exp_norm
stp_fb_2025_mod_grav_power stp_fb_2025_mod_grav_power_norm
stp_fb_2025_mod_grav_scaled_power stp_fb_2025_mod_grav_transport
stp_fb_2025_mod_rad_basic stp_fb_2025_mod_rad_finite
swz_fb_2025_mod_dd_exp swz_fb_2025_mod_dd_power
swz_fb_2025_mod_dd_radiation swz_fb_2025_mod_grav_basic
swz_fb_2025_mod_grav_exp swz_fb_2025_mod_grav_exp_norm
swz_fb_2025_mod_grav_power swz_fb_2025_mod_grav_power_norm
swz_fb_2025_mod_grav_scaled_power swz_fb_2025_mod_grav_transport
swz_fb_2025_mod_rad_basic swz_fb_2025_mod_rad_finite
syc_fb_2025_mod_dd_exp syc_fb_2025_mod_dd_power
syc_fb_2025_mod_dd_radiation syc_fb_2025_mod_grav_basic
syc_fb_2025_mod_grav_exp syc_fb_2025_mod_grav_exp_norm
syc_fb_2025_mod_grav_power syc_fb_2025_mod_grav_power_norm
syc_fb_2025_mod_grav_scaled_power syc_fb_2025_mod_grav_transport
syc_fb_2025_mod_rad_basic syc_fb_2025_mod_rad_finite
tcd_fb_2025_mod_dd_exp tcd_fb_2025_mod_dd_power
tcd_fb_2025_mod_dd_radiation tcd_fb_2025_mod_grav_basic
tcd_fb_2025_mod_grav_exp tcd_fb_2025_mod_grav_exp_norm
tcd_fb_2025_mod_grav_power tcd_fb_2025_mod_grav_power_norm
tcd_fb_2025_mod_grav_scaled_power tcd_fb_2025_mod_grav_transport
tcd_fb_2025_mod_rad_basic tcd_fb_2025_mod_rad_finite
tgo_fb_2025_mod_dd_exp tgo_fb_2025_mod_dd_power
tgo_fb_2025_mod_dd_radiation tgo_fb_2025_mod_grav_basic
tgo_fb_2025_mod_grav_exp tgo_fb_2025_mod_grav_exp_norm
tgo_fb_2025_mod_grav_power tgo_fb_2025_mod_grav_power_norm
tgo_fb_2025_mod_grav_scaled_power tgo_fb_2025_mod_grav_transport
tgo_fb_2025_mod_rad_basic tgo_fb_2025_mod_rad_finite
tun_fb_2025_mod_dd_exp tun_fb_2025_mod_dd_power
tun_fb_2025_mod_dd_radiation tun_fb_2025_mod_grav_basic
tun_fb_2025_mod_grav_exp tun_fb_2025_mod_grav_exp_norm
tun_fb_2025_mod_grav_power tun_fb_2025_mod_grav_power_norm
tun_fb_2025_mod_grav_scaled_power tun_fb_2025_mod_grav_transport
tun_fb_2025_mod_rad_basic tun_fb_2025_mod_rad_finite
tza_fb_2025_mod_dd_exp tza_fb_2025_mod_dd_power
tza_fb_2025_mod_dd_radiation tza_fb_2025_mod_grav_basic
tza_fb_2025_mod_grav_exp tza_fb_2025_mod_grav_exp_norm
tza_fb_2025_mod_grav_power tza_fb_2025_mod_grav_power_norm
tza_fb_2025_mod_grav_scaled_power tza_fb_2025_mod_grav_transport
tza_fb_2025_mod_rad_basic tza_fb_2025_mod_rad_finite
uga_fb_2025_mod_dd_exp uga_fb_2025_mod_dd_power
uga_fb_2025_mod_dd_radiation uga_fb_2025_mod_grav_basic
uga_fb_2025_mod_grav_exp uga_fb_2025_mod_grav_exp_norm
uga_fb_2025_mod_grav_power uga_fb_2025_mod_grav_power_norm
uga_fb_2025_mod_grav_scaled_power uga_fb_2025_mod_grav_transport
uga_fb_2025_mod_rad_basic uga_fb_2025_mod_rad_finite
zaf_fb_2025_mod_dd_exp zaf_fb_2025_mod_dd_power
zaf_fb_2025_mod_dd_radiation zaf_fb_2025_mod_grav_basic
zaf_fb_2025_mod_grav_exp zaf_fb_2025_mod_grav_exp_norm
zaf_fb_2025_mod_grav_power zaf_fb_2025_mod_grav_power_norm
zaf_fb_2025_mod_grav_scaled_power zaf_fb_2025_mod_grav_transport
zaf_fb_2025_mod_rad_basic zaf_fb_2025_mod_rad_finite
zmb_cdr_2020_mod_dd_exp zmb_fb_2020_mod_grav_exp zmb_fb_2025_mod_dd_exp
zmb_fb_2025_mod_dd_power zmb_fb_2025_mod_dd_radiation
zmb_fb_2025_mod_grav_basic zmb_fb_2025_mod_grav_exp
zmb_fb_2025_mod_grav_exp_norm zmb_fb_2025_mod_grav_power
zmb_fb_2025_mod_grav_power_norm zmb_fb_2025_mod_grav_scaled_power
zmb_fb_2025_mod_grav_transport zmb_fb_2025_mod_rad_basic
zmb_fb_2025_mod_rad_finite zwe_fb_2025_mod_dd_exp
zwe_fb_2025_mod_dd_power zwe_fb_2025_mod_dd_radiation
zwe_fb_2025_mod_grav_basic zwe_fb_2025_mod_grav_exp
zwe_fb_2025_mod_grav_exp_norm zwe_fb_2025_mod_grav_power
zwe_fb_2025_mod_grav_power_norm zwe_fb_2025_mod_grav_scaled_power
zwe_fb_2025_mod_grav_transport zwe_fb_2025_mod_rad_basic
zwe_fb_2025_mod_rad_finite![Fit diagnostics for
zmb_fb_2025_mod_grav_exp_norm](model_checks/zmb_fb_2025_mod_grav_exp_norm.png)

Show how to inspect the same fit in R

``` r

model <- model_db$zmb_fb_2025_mod_grav_exp_norm
check(model, plots = FALSE)
plot(model)
summary(model)
```

Continue to [Selecting a mobility
model](https://ojwatson.github.io/nomad/articles/selecting-a-model.md)
for a worked comparison of predictions, uncertainty and ensembles.

local({
  # Fold a whole code chunk while leaving its results visible.
  source_hook <- knitr::knit_hooks$get("source")
  chunk_hook <- knitr::knit_hooks$get("chunk")
  fold_source <- function(options) {
    lines <- strsplit(paste(options$code, collapse = "\n"), "\n", fixed = TRUE)[[1]]
    knitr::is_html_output() && isTRUE(options$echo) &&
      !identical(options$fold, FALSE) &&
      (isTRUE(options$fold) || length(lines) >= 12L)
  }
  knitr::knit_hooks$set(
    source = function(x, options) {
      if (fold_source(options)) "" else source_hook(x, options)
    },
    chunk = function(x, options) {
      if (fold_source(options)) {
        label <- options$fold_label
        if (is.null(label)) label <- "Show code for this step"
        x <- paste0("\n<details><summary>", htmltools::htmlEscape(label),
                    "</summary>\n\n", source_hook(options$code, options),
                    "\n\n</details>\n\n", x)
      }
      chunk_hook(x, options)
    }
  )
})

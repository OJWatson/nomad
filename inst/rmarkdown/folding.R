local({
  # Fold a whole code chunk while leaving its results visible.
  source_hook <- knitr::knit_hooks$get("source")
  warning_hook <- knitr::knit_hooks$get("warning")
  warnings <- new.env(parent = emptyenv())
  chunk_hook <- knitr::knit_hooks$get("chunk")
  fold_source <- function(options) {
    lines <- strsplit(paste(options$code, collapse = "\n"), "\n", fixed = TRUE)[[1]]
    knitr::is_html_output() && isTRUE(options$echo) &&
      !identical(options$fold, FALSE) &&
      (isTRUE(options$fold) || length(lines) >= 12L)
  }
  knitr::knit_hooks$set(
    warning = function(x, options) {
      out <- warning_hook(x, options)
      if (knitr::is_html_output() && isTRUE(options$fold_warnings)) {
        warnings[[options$label]] <- paste0(warnings[[options$label]], out)
        ""
      } else {
        out
      }
    },
    source = function(x, options) {
      if (fold_source(options)) "" else source_hook(x, options)
    },
    chunk = function(x, options) {
      if (!is.null(warnings[[options$label]])) {
        x <- paste0(x, "\n<details class=\"nomad-warnings\">",
                    "<summary>Show prediction warnings</summary>\n\n",
                    warnings[[options$label]], "\n\n</details>\n\n")
        rm(list = options$label, envir = warnings)
      }
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

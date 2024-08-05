source("renv/activate.R")

options(tidyverse.quiet = TRUE)

if (interactive()) {
  if (as.logical(Sys.getenv("ATTACH_STARTUP_PKGS"))) {
    usethis::ui_todo("Attaching development supporting packages...")
    suppressPackageStartupMessages(suppressWarnings({
      library(usethis)
      ui_done("Library {ui_value('usethis')} attached.")
      library(checkmate)
      ui_done("Library {ui_value('checkmate')} attached.")
      library(devtools)
      ui_done("Library {ui_value('devtools')} attached.")
      library(targets)
      ui_done("Library {ui_value('targets')} attached.")
      library(testthat)
      ui_done("Library {ui_value('testthat')} attached.")
    }))
  }


  .run <- function(...) {
    source(here::here("dev/run.R")) # check and make pipeline.
    .run(...)
  }
  ui_info("Exexute {ui_code('.run()')} to make the pipeline.")

  .background_run <- function(...) {
    stopifnot(requireNamespace("rstudioapi"))
    rstudioapi::jobRunScript(
      here::here("dev/background_run.R"),
      workingDir = here::here()
    )
  }
  ui_info(paste0(
    "Exexute {ui_code('.background_run()')} to make the pipeline ",
    "as a background job in RStudio."
  ))
}

library(targets)
library(tarchetypes) # Load other packages as needed.
library(here)

tar_option_set(
  packages = c("tibble"),
  format = "qs",
  error = "continue"
)

tar_source()

# Targets ---------------------
list(
  tar_target(
    name = jecfa_raw,
    command = create_df(n = 7)
  ),
  tar_target(
    name = jecfa,
    command = process_df(jecfa_raw)
  ),


# Report ----------------------
  tar_render(
    jecfa_ws,
    here("jecfa_ws.Rmd")
  ),

# Share -----------------------
  tar_target(
    objectToShare,
    list(
      jecfa_raw = jecfa_raw,
      jecfa = jecfa
    )
  ),
  tar_target(
    shareOutputNow,
    share_objects(objectToShare, last = FALSE),
    format = "file",
    pattern = map(objectToShare)
  ),
  tar_target(
    shareOutput,
    share_objects(objectToShare),
    format = "file",
    pattern = map(objectToShare)
  )
)

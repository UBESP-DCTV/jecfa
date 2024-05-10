# ## Creiamo il db con i 95 url problematici
#
# empties <- tar_read(jecfa_oks) |>
#   purrr::map_lgl(
#     \(x) ("tbl_df" %in% class(x)) && (nrow(x) == 0)
#   ) |>
#   which() |>
#   purrr::map_chr(
#     \(id) stringr::str_c(
#       "https://",
#       "apps.who.int/",
#       "food-additives-contaminants-jecfa-database/Home/Chemical/",
#       id
#     )
#   ) |>
#   tibble::as_tibble()

# ## Salviamo il file
# empties |>
#   rio::export("empties.xlsx")

# Apriamoli tutti in un colpo nel browser per vederli
rio::import("empties.xlsx") |>
  purrr::pull("value") |>
  purrr::walk(browseURL)

get_jecfa_type <- function(tox_link) {
  type <- tox_link |>
    substr(
      nchar(tox_link) - 3,
      nchar(tox_link)
    )

  ifelse(
    type %in% c(".pdf", ".htm", "html"),
    type, "other"
  )
}

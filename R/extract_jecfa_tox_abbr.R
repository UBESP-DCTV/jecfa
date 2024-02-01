extract_jecfa_tox_abbr <- function(tox_monograph) {
  aux <- tox_monograph |>
    sapply(extract_initial_part) |>
    sapply(extract_initial_partII) |>
    sapply(extract_initial_partIII)

  aux <- ifelse(
    substr(aux, 1, 3) == "See",
    substr(aux, 5, nchar(aux)),
    aux
  )

  aux <- ifelse(
    substr(aux, 1, 2) == '">',
    substr(aux, 3, nchar(aux)),
    aux
  )

  aux <- ifelse(
    substr(aux, 1, 3) != "FAS" &
      substr(aux, 1, 12) != "NOT PREPARED",
    "NOT A FAS",
    aux
  )

  aux
}

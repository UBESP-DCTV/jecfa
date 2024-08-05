#' Extracts JECFA abbreviation
#'
#' This function extracts the abbreviation of a JECFA monograph.
#'
#' @param tox_monograph A character vector with the JECFA monograph
#'
#' @return A character vector with the abbreviation of the JECFA
#'   monograph
#' @export
#'
#' @examples
#' compose_jecfa_list(1) |>
#'   get_result() |>
#'   dplyr::pull("Tox Monograph1") |>
#'   extract_jecfa_tox_abbr()
extract_jecfa_tox_abbr <- function(tox_monograph) {
  aux <- tox_monograph |>
    sapply(extract_initial_part) |>
    sapply(extract_initial_part_bis) |>
    sapply(extract_initial_part_ter)

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


extract_initial_part <- function(input_string) {
  unlist(strsplit(input_string, "-"))[1]
}

extract_initial_part_bis <- function(input_string) {
  unlist(strsplit(input_string, "/"))[1]
}

extract_initial_part_ter <- function(input_string) {
  unlist(strsplit(input_string, "JECFA"))[1]
}

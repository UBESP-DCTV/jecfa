#' Get the type of JECFA link
#'
#' @param tox_link A character string with the JECFA link
#'
#' @return A character string with the type of JECFA link
#' @export
#'
#' @examples
#' compose_jecfa_list(1) |>
#'   get_result() |>
#'   dplyr::pull("Tox Monograph_sourcelink1") |>
#'   get_jecfa_type()
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

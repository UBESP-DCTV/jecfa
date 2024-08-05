#' Get JECFA URL parts
#'
#' @param tox_link A URL from the JECFA database
#'
#' @return A data frame with the URL parts
#' @export
#'
#' @examples
#' compose_jecfa_list(1) |>
#'   get_result() |>
#'   dplyr::pull("Tox Monograph_sourcelink1") |>
#'   get_jecfa_url_parts()
#'
get_jecfa_url_parts <- function(tox_link) {
  m <- regexec("^(([^:]+)://)?([^:/]+)(:([0-9]+))?(/.*)", tox_link)
  parts <- do.call(
    rbind,
    lapply(regmatches(tox_link, m), `[`, c(3L, 4L, 6L, 7L))
  )
  colnames(parts) <- c("protocol", "host", "port", "path")
  parts
}

#' Extract JECFA report
#'
#' This function extracts and clean the JECFA report code.
#'
#' @param report (chr) The JECFA report code as reported in the JECFA
#'   database
#'
#' @return (chr) The cleaned JECFA report code
#' @export
#'
#' @examples
#' compose_jecfa_list(1) |>
#'   get_result() |>
#'   dplyr::pull("Report1") |>
#'   extract_jecfa_report_clean()
extract_jecfa_report_clean <- function(report) {
  aux <- ifelse(
    substr(report, 1, 2) == '">',
    substr(report, 3, nchar(report)),
    report
  )

  ifelse(
    substr(aux, 1, 3) %in% c("See", "see"),
    substr(aux, 5, nchar(aux)),
    aux
  )
}

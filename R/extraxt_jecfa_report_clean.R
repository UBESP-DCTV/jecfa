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

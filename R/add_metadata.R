add_metadata <- function(jecfa) {
  jecfa |>
    dplyr::mutate(
      type = get_jecfa_type(Tox.Monograph_sourcelink),
      host = get_jecfa_url_parts(Tox.Monograph_sourcelink)[, 2],
      Tox_monograph_abbr = extract_jecfa_tox_abbr(Tox.Monograph),
      Report_clean = extract_jecfa_report_clean(Report),
      FAS = dplyr::case_when(
        nchar(FAS) > 3 ~ substr(FAS, 1, 2),
        FAS != "" ~ FAS,
        # From here FAS == ""
        substr(Tox_monograph_abbr, 1, 6) == "FAS 74" ~ "74",
        substr(Tox_monograph_abbr, 1, 6) == "FAS 60", "60",
        substr(Tox_monograph_abbr, 1, 6) == "FAS 27", "27",
        TRUE ~ FAS
      ),
      RefID = dplyr::row_number()
    )
}

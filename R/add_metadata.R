add_metadata <- function(jecfa) {
  jecfa |>
    dplyr::mutate(
      type = get_jecfa_type(Tox.Monograph_sourcelink),
      host = get_jecfa_url_parts(Tox.Monograph_sourcelink)[, 2],
      Tox_monograph_abbr = extract_jecfa_tox_abbr(Tox.Monograph),
      Report_clean = extract_jecfa_report_clean(Report)
    )
}

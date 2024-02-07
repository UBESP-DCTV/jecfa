process_df <- function(df_clean) {
  df_clean |>
    dplyr::mutate(
      FAS = dplyr::if_else(
        stringr::str_detect(`Tox Monograph1`, "^FAS .*$"),
        stringr::str_sub(`Tox Monograph1`, 5),
        ""
      ),
      FAS = stringr::str_split(FAS, "/", simplify = TRUE)[, 1],
      FAS = stringr::str_split(FAS, "-", simplify = TRUE)[, 1]
    ) |>
    dplyr::rename(
      CAS.number = `CAS number`,
      Functional.Class = `Functional Class`,
      Chemical.Names = `Chemical Names`,
      JECFA.number = `JECFA number`,
      COE.number = `COE number`,
      FEMA.number = `FEMA number`,
      Report = Report1,
      Report_sourcelink = `Report_sourcelink1`,
      Tox.Monograph = `Tox Monograph1`,
      Tox.Monograph_sourcelink = `Tox Monograph_sourcelink1`,
      Specification = Specification1,
      Specification_sourcelink = `Specification_sourcelink1`,
      Evaluation.year = `Evaluation year1`
    ) |>
    dplyr::select(
      Report,
      Report_sourcelink,
      Tox.Monograph,
      Tox.Monograph_sourcelink,
      Specification,
      Specification_sourcelink,
      Synonyms,
      CAS.number,
      Functional.Class,
      Evaluation.year,
      Chemical.Names,
      JECFA.number,
      COE.number,
      FEMA.number,
      JECFA_name,
      URL,
      FAS
    )
}

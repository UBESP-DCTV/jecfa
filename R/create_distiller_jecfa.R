#' Create JECFA distiller
#'
#' This function creates a distiller db from the JECFA data.
#'
#' @param jecfa_tm_full A tibble with the JECFA data
#'
#' @return A tibble with the distiller data
#' @export
create_distiller_jecfa <- function(jecfa_tm_full) {
  jecfa_tm_full |>
    dplyr::select(-c(matching_pages, any_match)) |>
    tidyr::pivot_wider(
      names_from = keywords,
      values_from = keyword_match,
      values_fill = list(keyword_match = FALSE)
    ) |>
    dplyr::filter(bmd | bmr | `benchmark dose` | `benchmark-dose`) |>
    dplyr::mutate(
      Chemical.Names_conc = paste0(Chemical.Names, collapse = ", "),
      URL_conc = paste0(URL, collapse = ", "),
      .by = c(
        Functional.Class,
        CAS.number,
        Evaluation.year,
        COE.number,
        FEMA.number
      )
    ) |>
    dplyr::distinct(
      Functional.Class,
      CAS.number,
      Evaluation.year,
      COE.number,
      FEMA.number,
      .keep_all = TRUE
    ) |>
    dplyr::arrange(file) |>
    dplyr::mutate(
      ref_distiller = dplyr::row_number(),
      CAS.number_1 = CAS.number |>
        stringr::str_sub(3, nchar(CAS.number) - 2)
    )
}

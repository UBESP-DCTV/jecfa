compose_tbl1 <- function(jecfa) {
  jecfa |>
    dplyr::select(host, type) |>
    gtsummary::tbl_summary(
      missing = "always",
      by = type,
      # label = list(host ~ "Link to Tox Monograph"),
      statistic = list(host ~ "{n} ({p})"),
      sort = gtsummary::all_categorical() ~ "frequency"
    ) |>
    gtsummary::modify_table_styling(
      columns = label,
      rows = label == "Unknown",
      footnote = "corrupt link such as /food-additives-contaminants-jecfa-database/Document/Index/989"
    ) |>
    gtsummary::modify_caption("**Table 1. Description of the link to the monograph**")
}

compose_tbl2 <- function(jecfa) {
  jecfa |>
    # dplyr::filter(Tox.Monograph_sourcelink == "http://www.inchem.org/pages/jecfa.html") |>
    #      dplyr::select(Tox.Monograph, Chemical.Names) |>
    dplyr::select(Tox_monograph_abbr) |>
    gtsummary::tbl_summary(
      missing = "always",
      #            label = list(Tox.Monograph_sourcelink ~ "Link"),
      sort = gtsummary::all_categorical() ~ "alphanumeric",
    ) |>
    gtsummary::modify_table_styling(
      columns = label,
      rows = label == "NOT A FAS",
      footnote = "Used by authors for content that does not conform to a FAS format"
    ) |>
    gtsummary::modify_caption("**Table 2. Distribution of pre-processed Tox.Monograph variable**")
}

compose_tbl3 <- function(jecfa) {
  jecfa |>
    dplyr::filter(Tox_monograph_abbr %in% c("NOT A FAS", "NOT PREPARED", NA)) |>
    dplyr::select(host, Tox.Monograph_sourcelink, Tox_monograph_abbr, type) |>
    gtsummary::tbl_summary(
      missing = "always",
      #            label = list(Tox.Monograph_sourcelink ~ "Link"),
      sort = gtsummary::all_categorical() ~ "alphanumeric",
      by = type
    ) |>
    gtsummary::modify_caption("**Table 3. Distribution of strange cases**")
}

compose_tbl4 <- function(jecfa) {
  jecfa |>
    dplyr::filter(Tox_monograph_abbr %in% c("NOT PREPARED", "NOT A FAS", NA)) |>
    dplyr::select(Report_sourcelink, Report) |>
    gtsummary::tbl_summary(
      missing = "no",
      #            label = list(Tox.Monograph_sourcelink ~ "Link"),
      sort = gtsummary::all_categorical() ~ "alphanumeric",
    ) |>
    gtsummary::modify_caption("**Table 4. Distribution of strange cases**")
}


prepare_keydb_for_tbl <- function(x) {
  x |>
    dplyr::select(source, file, ref_id, keywords, keyword_match) |>
    dplyr::filter(keyword_match) |>
    dplyr::mutate(
      keywords = keywords |>
        stringr::str_replace_all("-", " ") |>
        stringr::str_replace_all("modeling", "modelling")
    ) |>
    dplyr::distinct() |>
    tidyr::pivot_wider(
      id_cols = c(source, file, ref_id),
      names_from = keywords,
      values_from = keyword_match,
      values_fill = list(keyword_match = FALSE)
    )
}

keyword_summary <- function(key_db, by, title) {
  key_db |>
    gtsummary::tbl_summary(
      include = c(-ref_id, -file),
      missing = "no",
      percent = "col",
      by = {{ by }}
    ) |>
    gtsummary::modify_table_styling(
      columns = label,
      rows = variable == "dose response",
      footnote = "both dose-response and dose response terms were searched for"
    ) |>
    gtsummary::modify_table_styling(
      columns = label,
      rows = variable == "benchmark dose",
      footnote = "both benchmark-dose and benchmark dose terms were searched for"
    ) |>
    gtsummary::modify_table_styling(
      columns = label,
      rows = variable == "modelling",
      footnote = "both modelling and modeling terms were searched for"
    ) |>
    gtsummary::modify_caption(title)

}


compose_tbl5 <- function(keywordMatching) {
  keywordMatching |>
    prepare_keydb_for_tbl() |>
    keyword_summary(
      by = source,
      title = "**Table 5. Distribution of retrieved words by source document**"
    )
}


compose_tbl6 <- function(keywordMatching) {
  keywordMatching |>
    prepare_keydb_for_tbl() |>
    gtsummary::tbl_strata(
      strata = source,
      ~ .x |>
        keyword_summary(
          by = bmd,
          title = "**Table 6. Distribution by text bmd and document source**"
        )
    )
}

compose_tbl7 <- function(keywordMatching) {
  keywordMatching |>
    prepare_keydb_for_tbl() |>
    gtsummary::tbl_strata(
      strata = source,
      ~ .x |>
        keyword_summary(
          by = "dose response",
          title = "**Table 7. Distribution by text dose response and document source**"
        )
    )
}


compose_tbl8 <- function(jecfa_tm_full) {
  jecfa_tm_full |>
    dplyr::mutate(
      source = tidyr::replace_na(source, "Unknown"),
      Monograph = dplyr::case_when(
        is.na(Tox_monograph_abbr) ~ "no",
        stringr::str_sub(
            Tox_monograph_abbr, 1, 12
          ) == "NOT PREPARED" ~ "no",
        TRUE ~ "yes"
      ),
      Report = dplyr::if_else(Report == "", "no", "yes")
    ) |>
    dplyr::select(source, Monograph, Report) |>
    gtsummary::tbl_summary(
      missing = "no",
      percent = "col",
      by = source
    ) |>
    gtsummary::modify_caption(
      "**Table 8. Distribution of retrieved documents**"
    )
}


compose_tbl9 <- function(jecfa_tm_full) {
  jecfa_tm_full |>
    dplyr::select(-c(matching_pages, any_match)) |>
    tidyr::pivot_wider(
      names_from = keywords,
      values_from = keyword_match,
      values_fill = list(keyword_match = FALSE)
    ) |>
    dplyr::mutate(
      source = dplyr::if_else(
        source == "0",
        "Unknown",
        source
      ),
      unique1 = !duplicated(cbind(
          Functional.Class, CAS.number, Evaluation.year,
          COE.number, FEMA.number
        )) |>
        as.logical(),
      unique2 = !duplicated(cbind(
          Functional.Class, CAS.number, Evaluation.year, COE.number
        )) |>
        as.logical(),
      unique3 = !duplicated(cbind(
          Functional.Class, CAS.number, Evaluation.year
        )) |>
        as.logical(),
      unique4 = !duplicated(cbind(CAS.number, Evaluation.year)) |>
        as.logical()
    ) |>
    dplyr::select(unique1, unique2, unique3, unique4, source) |>
    gtsummary::tbl_summary(
      missing = "no",
      missing_text = "Unknown",
      percent = "col",
      by = source,
      type = list(c(unique1, unique2, unique3, unique4) ~ "dichotomous")
    ) |>
   gtsummary::modify_table_styling(
      columns = label,
      rows = variable == "unique1",
      footnote = "unique combination of Functional.Class, CAS.number, Evaluation.year, COE.number, FEMA.number"
    ) |>
    gtsummary::modify_table_styling(
      columns = label,
      rows = variable == "unique2",
      footnote = "unique combination of Functional.Class, CAS.number, Evaluation.year, COE.number"
    ) |>
    gtsummary::modify_table_styling(
      columns = label,
      rows = variable == "unique3",
      footnote = "unique combination of Functional.Class, CAS.number, Evaluation.year"
    ) |>
    gtsummary::add_overall() |>
    gtsummary::modify_table_styling(
      columns = label,
      rows = variable == "unique4",
      footnote = "unique combination of CAS.number, Evaluation.year"
    ) |>
    gtsummary::remove_row_type(
      variables = c(unique1, unique2, unique3, unique4),
      type = "level", level_value = ("FALSE")
    ) |>
   gtsummary::modify_caption("**Table 9. Distribution of unique records depending on the set of variables considered**")
}


compose_tbl10 <- function(jecfa_tm_full) {
  jecfa_tm_full |>
    dplyr::select(-c(matching_pages, any_match)) |>
    tidyr::pivot_wider(
      names_from = keywords,
      values_from = keyword_match,
      values_fill = list(keyword_match = FALSE)
    ) |>
    dplyr::filter(bmd | bmr | `benchmark dose` | `benchmark-dose`) |>
    dplyr::mutate(
      Some_id = dplyr::if_else(CAS.number == "0" & COE.number == "0" & FEMA.number == "0", "Unknown", ">=1 Present"),
      unique1 = !duplicated(cbind(
          Functional.Class, CAS.number, Evaluation.year,
          COE.number, FEMA.number
        )) |>
        as.logical()
    ) |>
    dplyr::select(Functional.Class, CAS.number, Some_id, COE.number, FEMA.number, unique1) |>
    dplyr::mutate(
      dplyr::across(
        c(Functional.Class, CAS.number, COE.number, FEMA.number),
        ~ dplyr::case_when(
          . == "0" ~ FALSE,
          TRUE ~ TRUE
        ),
        .names = "{.col} (non_missing)"
      ),
      .keep = "unused"
    ) |>
    gtsummary::tbl_summary(
      percent = "col",
      by = Some_id,
      type = list(c(unique1) ~ "dichotomous")
    ) |>
    gtsummary::modify_table_styling(
      columns = label,
      rows = variable == "unique1",
      footnote = "unique combination of Functional.Class, CAS.number, Evaluation.year, COE.number, FEMA.number"
    ) |>
    gtsummary::add_overall() |>
    gtsummary::modify_caption("**Table 10. Distribution of identifiers when at least one among CAS, COE and FEMA is present**")
}







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

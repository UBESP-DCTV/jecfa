#' Compose URLs
#'
#' Compose URLs to TRS PDFs for JECFA reports. Valid URLs are
#' constructed based on the JECFA data frame information, i.e,
#' they should report "NOT FAS" or "NOT PREPARED" in the
#' `Tox_monograph_abbr` column and have a valid URL in the
#' `Report_sourcelink` column.
#'
#' @param jecfa a data frame with the JECFA data
#'
#' @return a list with the URLs specification for each JECFA report,
#'   i.e., a list with the URL, the filename with the ID and the
#'   filename without the ID
#' @export
#'
#' @examples
#' # first element will be NULL because report 1 has no PDF, while
#' record 2 has a PDF so it will be a list with the URL, the filename
#' with the ID and the filename without the ID.
#' c(1, 10) |>
#'   purrr::map(\(id) compose_jecfa_list(id) |> get_result()) |>
#'   create_df() |>
#'   process_df() |>
#'   add_metadata() |>
#'   compose_urls()
compose_urls <- function(jecfa) {
  jecfa[["ref_id"]] |>
    purrr::map(compose_url, db = jecfa)
}


#' Compose URL to PDF
#'
#' Compose URL to TRS PDF for a JECFA report. Valid URLs are
#' constructed based on the JECFA data frame information, i.e,
#' they should report "NOT FAS" or "NOT PREPARED" in the
#' `Tox_monograph_abbr` column and have a valid URL in the
#' `Report_sourcelink` column.
#'
#' @param id JECFA ref_id
#' @param db JECFA data frame
#'
#' @return a list with the URL, the filename with the ID and the
#'   filename without the ID
#' @export
#'
#' @examples
#' jecfa_sample <- c(1, 10) |>
#'   purrr::map(\(id) compose_jecfa_list(id) |> get_result()) |>
#'   create_df() |>
#'   process_df() |>
#'   add_metadata()
#'
#' jecfa_sample[["ref_id"]][[1]] |> # report 1 has no TRS PDF
#'   compose_url(jecfa_sample)
#'
#' jecfa_sample[["ref_id"]][[2]] |> # report 10 has a TRS PDF
#'   compose_url(jecfa_sample)
compose_url <- function(id, db) {
  pdf_url <- db[["Report_sourcelink"]][[id]]
  tox_abbr <- db[["Tox_monograph_abbr"]][[id]]

  if (!is_valid_id(pdf_url, tox_abbr)) {
    return(NULL)
  }

  report_clean <- db[["Report_clean"]][[id]]

  list(
    url = pdf_url,
    fnm = stringr::str_glue(
      "{id}-{extract_filename(report_clean)}.pdf"
    ),
    fnm_noid = stringr::str_glue(
      "{extract_filename(report_clean)}.pdf"
    )
  )
}

is_valid_id <- function(pdf_url, tox_abbr) {
  check_tox_condition(tox_abbr) &&
    check_missing_url(pdf_url) &&
    check_valid_url(pdf_url)
}

check_tox_condition <- function(tox_abbr) {
  if (!is_tox_condition_satisfied(tox_abbr)) {
    usethis::ui_warn("Condition not satisfied, skipping...")
    return(FALSE)
  }
  TRUE
}

is_tox_condition_satisfied <- function(tox_abbr) {
  is.na(tox_abbr) ||
    (tox_abbr %in% c("NOT A FAS")) ||
    (substr(tox_abbr, 1, 12) %in% c("NOT PREPARED"))
}


check_missing_url <- function(pdf_url) {
  if (is_missing_url(pdf_url)) {
    usethis::ui_warn("URL missing or empty, skipping...")
    return(FALSE)
  }
  TRUE
}

is_missing_url <- function(url) {
  is.na(url) || url == ""
}


check_valid_url <- function(pdf_url) {
  if (!is_valid_url(pdf_url)) {
    usethis::ui_warn("Invalid URL format, skipping: {url}")
    return(FALSE)
  }
  TRUE
}


is_valid_url <- function(url) {
  grepl("^https?://", url, ignore.case = TRUE)
}

extract_filename <- function(report_clean) {
  substr(sanitize_file_name(report_clean), 1, 7)
}

sanitize_file_name <- function(file_name) {
  # Replace characters not allowed in file names with underscores
  file_name <- gsub("[^[:alnum:]_\\.-]", "_", file_name, perl = TRUE)

  # Remove leading and trailing underscores
  file_name <- gsub("^_+|_+$", "", file_name)
}

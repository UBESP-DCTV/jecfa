compose_urls <- function(jecfa) {
  seq_len(nrow(jecfa)) |>
    purrr::map(compose_url, db = jecfa)
}


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
    )
  )
}

compose_filepaths <- function(urls, dir) {
  purrr::map_chr(urls, "fnm") |>
    (\(x) here::here(dir, x))()
}

remove_null_urls <- function(x) {
  to_retain <- x |>
    purrr::map_lgl(~ !is.null(.x[["url"]]))
  x[to_retain]
}


download_trs <- function(url, path) {
  code <- download.file(
    url,
    path,
    quiet = TRUE,
    mode = "w"
  )
  ifelse(code, str_glue("ERROR: {code}"), path)
}

extract_filename <- function(report_clean) {
  substr(sanitize_file_name(report_clean), 1, 7)
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

check_missing_url <- function(pdf_url) {
  if (is_missing_url(pdf_url)) {
    usethis::ui_warn("URL missing or empty, skipping...")
    return(FALSE)
  }
  TRUE
}

check_valid_url <- function(pdf_url) {
  if (!is_valid_url(pdf_url)) {
    usethis::ui_warn("Invalid URL format, skipping: {url}")
    return(FALSE)
  }
  TRUE
}

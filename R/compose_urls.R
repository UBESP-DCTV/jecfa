compose_urls <- function(jecfa) {
  jecfa[["ref_id"]] |>
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
    ),
    fnm_noid = stringr::str_glue(
      "{extract_filename(report_clean)}.pdf"
    )
  )
}

compose_filepaths <- function(urls, dir, noid = FALSE) {
  fname <- ifelse(noid, "fnm_noid", "fnm")

  purrr::map_chr(urls, fname) |>
    (\(x) here::here(dir, x))()
}


compose_maptojecfa <- function(x) {
  x <- basename(x)

  tibble::tibble(
    ref_id = stringr::str_extract(x, "^\\d+") |>
      as.integer(),
    file = stringr::str_remove(x, "^\\d+-")
  )
}

remove_null_urls <- function(x) {
  to_retain <- x |>
    purrr::map_lgl(~ !is.null(.x[["url"]]))
  x[to_retain]
}


download_trs <- function(url, path, path_noid) {

  code <- download.file(
    url,
    path,
    quiet = TRUE,
    mode = "wb",
    cacheOK = FALSE
  )

  if (!code) {
    fs::file_copy(path, path_noid, overwrite = TRUE)
  }

  ifelse(code, stringr::str_glue("ERROR: {code}"), path_noid)
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

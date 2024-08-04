remove_null_urls <- function(x) {
  to_retain <- x |>
    purrr::map_lgl(~ !is.null(.x[["url"]]))
  x[to_retain]
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


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


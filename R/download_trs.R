#' Download TRS files
#'
#' @param url URL of the TRS file
#' @param path Path to save the TRS file
#' @param path_noid Path to save the TRS file without the ID
#'
#' @return Path to the downloaded file
#' @export
#'
#' @examples
#' jecfa_sample <- c(1, 10, 11) |>
#'   purrr::map(\(id) compose_jecfa_list(id) |> get_result()) |>
#'   create_df() |>
#'   process_df() |>
#'   add_metadata()
#'
#' trs_urls_list <- jecfa_sample |>
#'   compose_urls() |>
#'   remove_null_urls()
#'
#' trs_urls <- trs_urls_list |>
#'   purrr::map_chr("url")
#'
#' out_dir <- file.path(tempdir(), "trs")
#' dir.create(out_dir)
#' trs_paths <- trs_urls_list |>
#'   compose_filepaths(out_dir)
#'
#' out_dir_noid <- file.path(tempdir(), "trs_noid")
#' dir.create(out_dir_noid)
#' trs_paths_noid <- trs_urls_list |>
#'   compose_filepaths(out_dir_noid, noid = TRUE)
#'
#' if (FALSE) { # this would actually download the data
#'   download_trs(trs_urls[[1]], trs_paths[[1]], trs_paths_noid[[1]])
#'   fs::dir_ls(out_dir)
#'   fs::dir_ls(out_dir_noid)
#' }
#'
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


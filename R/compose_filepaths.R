#' Compose filepaths to download TRS
#'
#' @param urls (chr) URLs to download
#' @param dir (chr) Directory to save the files
#' @param noid (logical) Whether to use the noid version of the filename
#'
#' @return (chr) Filepaths to download
#' @export
#'
#' @examples
#' c(1, 10) |>
#'   purrr::map(\(id) compose_jecfa_list(id) |> get_result()) |>
#'   create_df() |>
#'   process_df() |>
#'   add_metadata() |>
#'   compose_urls() |>
#'   remove_null_urls() |>
#'   compose_filepaths(tempdir())
compose_filepaths <- function(urls, dir, noid = FALSE) {
  fname <- ifelse(noid, "fnm_noid", "fnm")

  purrr::map_chr(urls, fname) |>
    (\(x) here::here(dir, x))()
}


#' Map TRS path to JECFA
#'
#' @param x (chr) TRS path
#'
#' @return (tibble) JECFA ID and file
#' @export
#'
#' @examples
#' # only record 10 and 11 has TRS
#' jecfa_sample <- c(1, 10, 11) |>
#'   purrr::map(\(id) compose_jecfa_list(id) |> get_result()) |>
#'   create_df() |>
#'   process_df() |>
#'   add_metadata()
#'
#'  # id 2 and 3 of the provided db (record 10, and 11) has TRS and
#'  # are reported in the resulting tibble
#'  jecfa_sample |>
#'   compose_urls() |>
#'   remove_null_urls() |>
#'   compose_filepaths(tempdir()) |>
#'   compose_maptojecfa()
compose_maptojecfa <- function(x) {
  x <- basename(x)

  tibble::tibble(
    ref_id = stringr::str_extract(x, "^\\d+") |>
      as.integer(),
    file = stringr::str_remove(x, "^\\d+-")
  )
}

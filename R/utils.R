get_input_data_path <- function(x) {
  file.path(
    Sys.getenv("INPUT_DATA_FOLDER"),
    x
  ) |>
    normalizePath()
}

get_output_data_path <- function(x) {
  file.path(
    Sys.getenv("OUTPUT_DATA_FOLDER"),
    x
  ) |>
    normalizePath(mustWork = FALSE)
}


share_objects <- function(obj_list, last = TRUE) {
  file_name <- stringr::str_c(names(obj_list), ".rds")

  if (!last) {
    file_name <- stringr::str_c(
      lubridate::now() |>
        stringr::str_remove_all("\\W") |>
        stringr::str_sub(1, 12),
      "_",
      file_name
    )
  }

  obj_paths <- get_output_data_path(file_name) |>
    file.path() |>
    normalizePath(mustWork = FALSE) |>
    purrr::set_names(names(obj_list))

  # Those must be RDS
  purrr::walk2(
    obj_list,
    obj_paths,
    readr::write_rds
  )
  obj_paths
}

get_url <- function(x) {
  x[["url"]]
}

get_filename <- function(x) {
  x[["fnm"]]
}

#' Get error
#'
#' This function extracts the "error" field from a list.
#'
#' @param x (list) A list with a field named 'error'
#'
#' @return The value of the 'error' field
#' @export
#'
#' @examples
#' get_error(list(error = "error message"))
get_error <- function(x) {
  x[["error"]]
}

#' Get result
#'
#' This function extracts the "result" field from a list.
#'
#' @param x (list) A list with a field named 'result'
#'
#' @return The value of the 'result' field
#' @export
#'
#' @examples
#' get_result(list(result = 1))
get_result <- function(x) {
  x[["result"]]
}

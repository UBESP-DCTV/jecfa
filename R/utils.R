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

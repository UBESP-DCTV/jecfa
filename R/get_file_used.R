get_file_used <- function(jecfaDistiller, fasPaths, trsUnique) {
  files <- jecfaDistiller |>
    dplyr::pull(file)

  c(
    fasPaths[basename(fasPaths) %in% files],
    trsUnique[basename(trsUnique) %in% files]
  ) |>
    unique()
}


move_file_used <- function(x, dest_dir) {
  x |>
    fs::file_copy(
      file.path(dest_dir, basename(x)),
      overwrite = TRUE
    )
}

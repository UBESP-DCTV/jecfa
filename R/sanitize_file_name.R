sanitize_file_name <- function(file_name) {
  # Replace characters not allowed in file names with underscores
  file_name <- gsub("[^[:alnum:]_\\.-]", "_", file_name, perl = TRUE)

  # Remove leading and trailing underscores
  file_name <- gsub("^_+|_+$", "", file_name)
}

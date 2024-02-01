extract_initial_part <- function(input_string) {
  split_string <- unlist(strsplit(input_string, "-"))
  initial_part <- split_string[1]
}


extract_initial_partII <- function(input_string) {
  split_string <- unlist(strsplit(input_string, "/"))
  initial_part <- split_string[1]
}


extract_initial_partIII <- function(input_string) {
  split_string <- unlist(strsplit(input_string, "JECFA"))
  initial_part <- split_string[1]
}

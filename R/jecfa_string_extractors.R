extract_initial_part <- function(input_string) {
  unlist(strsplit(input_string, "-"))[1]
}

extract_initial_part_bis <- function(input_string) {
  unlist(strsplit(input_string, "/"))[1]
}

extract_initial_part_ter <- function(input_string) {
  unlist(strsplit(input_string, "JECFA"))[1]
}

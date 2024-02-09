is_valid_url <- function(url) {
  grepl("^https?://", url, ignore.case = TRUE)
}

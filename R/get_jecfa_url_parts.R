get_jecfa_url_parts <- function(tox_link) {
  m <- regexec("^(([^:]+)://)?([^:/]+)(:([0-9]+))?(/.*)", tox_link)
  parts <- do.call(
    rbind,
    lapply(regmatches(tox_link, m), `[`, c(3L, 4L, 6L, 7L))
  )
  colnames(parts) <- c("protocol", "host", "port", "path")
  parts
}

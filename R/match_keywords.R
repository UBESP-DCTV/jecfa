match_keywords <- function(
  trsUnique,
  parsedPdf,
  keywords,
  source = c("FAS", "TRS")
) {
  source = match.arg(source)

  tibble::tibble(
    source = source,
    file = basename(trsUnique),
    keywords = keywords,
    matching_pages = purrr::map(
      keywords,
      \(keyword) stringr::str_which(parsedPdf, keyword)
    ),
    keyword_match = purrr::map_lgl(
      matching_pages,
      \(x) length(x) > 0
    ),
    any_match = any(keyword_match)
  )
}

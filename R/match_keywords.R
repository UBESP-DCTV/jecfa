match_keywords <- function(
  trsUnique,
  parsedPdf,
  keywords,
  type = c("FAS", "TRS")
) {
  type = match.arg(type)

  tibble::tibble(
    type = type,
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

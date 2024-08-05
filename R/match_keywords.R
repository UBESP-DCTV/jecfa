#' Match keywords in a parsed PDF
#'
#' This function takes a parsed PDF and a list of keywords and returns a
#' tibble with the source of the PDF, the file name, the keywords, the
#' pages where the keywords were found, and whether any of the keywords
#' were found.
#'
#' @param file_path (chr) The path to the PDF file
#' @param parsedPdf (chr) The parsed PDF
#' @param keywords (chr) keywords to search for
#' @param source (chr) The source of the PDF, either "FAS" or "TRS"
#'
#' @return (tibble) A tibble with the source of the PDF, the file name,
#'   the keywords, the pages where the keywords were found, and whether
#'   any of the keywords were found.
#' @export
match_keywords <- function(
  file_path,
  parsedPdf,
  keywords,
  source = c("FAS", "TRS")
) {
  source = match.arg(source)

  tibble::tibble(
    source = source,
    file = basename(file_path),
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

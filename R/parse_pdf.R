#' Parse PDF
#'
#' This function parses a PDF file and returns the text.
#'
#' @param path Path to the PDF file
#' @param dpi DPI to use for the OCR
#'
#' @return The text of the PDF file
#' @export
parse_pdf <- function(path, dpi = 150) {
  suppressMessages(
    pdftools::pdf_ocr_text(path, dpi = dpi)
  ) |>
    stringr::str_to_lower()
}

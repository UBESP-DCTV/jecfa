parse_pdf <- function(path, dpi = 150) {
  suppressMessages(
    pdftools::pdf_ocr_text(path, dpi = dpi)
  ) |>
    stringr::str_to_lower()
}

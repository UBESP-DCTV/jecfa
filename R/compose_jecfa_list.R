#' Compose JECFA list
#'
#' This function composes a list of JECFA chemicals.
#'
#' @param jecfa_id (int) The index of the chemical in the JECFA
#'   database.
#'
#' @return A list with two elements: result and error. The result is a
#'   tibble with the chemical information. The error is NULL if the
#'   function runs successfully; otherwise, it contains the error
#'   message, and result is NULL.
#' @export
#'
#' @examples
#' compose_jecfa_list(1) # success
#' compose_jecfa_list("a") # failure
compose_jecfa_list <- function(jecfa_id) {
  get_chemical_safe <- purrr::safely(get_chemical)
  res <- get_chemical_safe(jecfa_id)

  if (is.null(res$result)) {
    print(res$error)
  }

  res
}

#' Get chemical information from JECFA database
#'
#' This function scrapes the JECFA database to get information about a
#' chemical.
#'
#' @param id (chr) The index of the chemical in the JECFA database.
#'
#' @return A tibble with the chemical information.
#' @export
#'
#' @examples
#' get_chemical("1")
get_chemical <- function(id) {

  url <- stringr::str_c(
    "https://",
    "apps.who.int/",
    "food-additives-contaminants-jecfa-database/Home/Chemical/",
    id
  )

  # Read page content
  page <- rvest::read_html(url)

  # Scraping data
  content <- rvest::html_nodes(page, ".sf-content-block.content-block")
  reports <- rvest::html_nodes(content[[2]], ".row")
  data <- rvest::html_nodes(content[[1]], ".detail.who-team")

  # Initialize a list to store data
  chem_dict <- list()

  # Find evaluations and links
  link <- c()
  values <- c()
  keys <- c()

  for (report in reports) {
    keys <- c(
      keys,
      rvest::html_text(rvest::html_nodes(report, "div")[1]) |>
        stringr::str_remove("\\s*\\:.*")
    )


    link <- c(link, rvest::html_attr(rvest::html_node(report, "a"), "href"))

    values <- c(
      values,
      rvest::html_text(rvest::html_nodes(report, "div")[2]) |>
        stringr::str_trim()
    )
  }

  # Check if keys is not NULL
  if (!is.null(keys)) {
    suffix <- ave(keys, keys, FUN = function(x) seq_along(x))

    for (repp in seq_along(keys)) {
      chem_dict[[
        paste0(keys[repp], suffix[repp])
      ]] <- values[repp]
      chem_dict[[
        paste0(
          keys[repp],
          "_sourcelink",
          suffix[repp]
        )
      ]] <- link[repp]
    }
  }

  # Process additional data
  for (datum in data) {
    datum <- rvest::html_nodes(datum, "div")
    chem_dict[[
      rvest::html_text(datum[1])
    ]] <- rvest::html_text(datum[2]) |>
      stringr::str_split("\\|br\\|") |>
      unlist()
  }

  # Extract Evaluation year
  search <- "Evaluation year:"
  h <- 0
  for (cont in rvest::html_nodes(content[[2]], "h4")) {
    if (search %in% stringr::str_sub(rvest::html_text(cont), 1, 16)) {
      h <- h + 1
      eval_year <- paste0("Evaluation year", h)
      chem_dict[[eval_year]] <- rvest::html_text(cont) |>
        stringr::str_sub(-4)
    }
  }

  res <- tibble::tibble(
    JECFA_name = get_jecfa_name(page),
    index = id,
    URL = url
  )

  if (nrow({chem <- tibble::as_tibble(chem_dict)}) > 0) {
    dplyr::bind_cols(chem, res)
  } else {
    res
  }
}

#' Get JECFA name
#'
#' This function extracts the name of the chemical from the JECFA
#' database.
#'
#' @param page (xml_document) The page content.
#'
#' @return The name of the chemical.
#' @export
#'
#' @examples
#' url <- stringr::str_c(
#'   "https://",
#'   "apps.who.int/",
#'   "food-additives-contaminants-jecfa-database/Home/Chemical/",
#'   "1"
#' )
#' page <- rvest::read_html(url)
#' get_jecfa_name(page)
get_jecfa_name <- function(page) {
  rvest::html_node(
    page,
    "div.dynamic-content__heading"
  ) |>
    rvest::html_text() |>
    stringr::str_trim()
}

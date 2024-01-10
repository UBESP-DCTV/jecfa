create_df <- function(n = 7000) {
  ids <- seq_len(n)
  get_chemical_safe <- purrr::safely(get_chemical)
  res <- purrr::map(ids, get_chemical_safe)
  res_ok <- purrr::keep(res, ~ !is.null(.x$result))

  purrr::keep(res, ~ is.null(.x$result)) |>
    print_ko()

  res_ok |>
    purrr::map("result") |>
    purrr::list_rbind() |>
    janitor::remove_empty("cols")
}

print_ko <- function(kos) {
  purrr::map_chr(kos, "error") |>
    print()
}

get_chemical <- function(id) {

  URL <- paste0("https://apps.who.int/food-additives-contaminants-jecfa-database/Home/Chemical/", id)

  # Read page content
  page <- try(rvest::read_html(URL), silent = FALSE)

  if (!inherits(page, "try-error")) {
    # Scraping data
    content <- rvest::html_nodes(page, '.sf-content-block.content-block')
    reports <- rvest::html_nodes(content[[2]], '.row')
    data <- rvest::html_nodes(content[[1]], '.detail.who-team')

    # Initialize a list to store data
    chem_dict <- list()

    # Find evaluations and links
    link1 <- c()
    report_names <- c()
    report_name <- c()

    for (report in reports) {
      report_name <- c(report_name, sub("\\s*\\:.*", "", rvest::html_text(rvest::html_nodes(report, 'div')[1])))

      link <- rvest::html_node(report, 'a')
      link1 <- c(link1, rvest::html_attr(link, 'href'))

      report_names <- c(report_names, stringr::str_trim(rvest::html_text(rvest::html_nodes(report, 'div')[2])))

    }

    # Check if report_name is not NULL
    if (!is.null(report_name)) {
      suffix <- ave(report_name, report_name, FUN = function(x) seq_along(x))

      for (repp in 1:length(report_name)) {
        chem_dict[[paste0(report_name[repp], suffix[repp])]] <- report_names[repp]
        chem_dict[[paste0(report_name[repp],'_sourcelink', suffix[repp])]] <- link1[repp]
      }
    }

    # Process additional data
    for (datum in data) {
      datum <- rvest::html_nodes(datum, 'div')
      chem_dict[[rvest::html_text(datum[1])]] <- stringr::str_split(rvest::html_text(datum[2]), '\\|br\\|') %>% unlist()
    }

    # Extract Evaluation year
    search <- 'Evaluation year:'
    h = 0
    for (cont in rvest::html_nodes(content[[2]], 'h4')) {
      if (search %in% stringr::str_sub(rvest::html_text(cont), 1, 16)) {
        h = h + 1
        chem_dict[[paste0('Evaluation year', h)]] <- stringr::str_sub(rvest::html_text(cont), -4)
      }
    }

    # Extract JECFA_name
    chem_dict[['JECFA_name']] <- stringr::str_trim(rvest::html_text(rvest::html_node(page, 'div.dynamic-content__heading')))
    chem_dict[['URL']] <- URL
  }
  tibble::as_tibble(chem_dict)
}

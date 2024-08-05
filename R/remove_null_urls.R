#' Remove null TRS URLS
#'
#' @param x A list of lists with a url element
#'
#' @return the original lists with a url element filtered to remove nulls
#' @export
#'
#' @examples
#' c(1, 10) |>
#'   purrr::map(\(id) compose_jecfa_list(id) |> get_result()) |>
#'   create_df() |>
#'   process_df() |>
#'   add_metadata() |>
#'   compose_urls() |>
#'   remove_null_urls() # only the second element remain, i.e. report 10
remove_null_urls <- function(x) {
  to_retain <- x |>
    purrr::map_lgl(~ !is.null(.x[["url"]]))
  x[to_retain]
}

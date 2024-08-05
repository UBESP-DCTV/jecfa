#' Create a data frame from a list of data frames
#'
#' This function simply creates a data frame from a list of data frames.
#'
#' @param jecfa_list A list of (JECFA) data frames (as provided by
#'  `compose_jecfa_list() |> get_result()`)
#'
#' @return A data frame
#' @export
#'
#' @examples
#' create_df(list(data.frame(a = 1:3), data.frame(b = 4:6)))
create_df <- function(jecfa_list) {
  jecfa_list |>
    purrr::list_rbind() |>
    janitor::remove_empty("cols")
}

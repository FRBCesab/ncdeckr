#' List details of all boards
#'
#' @description
#' Performs an HTTP request (GET method) at the endpoint `/boards` of the
#' Nextcloud Deck API to retrieve details of all Deck boards (including deleted
#' and archived boards).
#'
#' @param archived a `logical` of length 1. If `TRUE` returns also archived
#'   boards. Default is `FALSE`.
#'
#' @param deleted a `logical` of length 1. If `TRUE` returns also deleted
#'   boards. Default is `FALSE`.
#'
#' @return A `data.frame` with the following columns:
#'   - `id`: the identifier of the board
#'   - `title`: the name of the board
#'   - `owner`: the owner of the board
#'   - `color`: the color of the board
#'   - `archived`: is the board archived?
#'   - `deleted`: is the board deleted?
#'   - `n_stacks`: the number of stacks in the board
#'   - `n_labels`: the number of labels in the board
#'
#' @export
#'
#' @examples
#' \dontrun{
#' ## List details of all Nextcloud boards
#' nc_list_boards()
#' 
#' ## List details of all Nextcloud boards (including archived ones)
#' nc_list_boards(archived = TRUE)
#' 
#' ## List details of all Nextcloud boards (including deleted ones)
#' nc_list_boards(deleted = TRUE)
#' }

nc_list_boards <- function(archived = FALSE, deleted = FALSE) {
  http_request <- .append_endpoint("boards") |>
    httr2::request() |>
    httr2::req_method("GET") |>
    .append_headers() |>
    .append_authentication() |>
    httr2::req_url_query(details = "true")

  http_response <- http_request |>
    httr2::req_perform()

  content <- http_response |>
    httr2::resp_body_json() |>
    .extract_boards_details()

  if (!archived) {
    content <- content[!content$"archived", ]
  }

  if (!deleted) {
    content <- content[!content$"deleted", ]
  }

  rownames(content) <- NULL

  content
}

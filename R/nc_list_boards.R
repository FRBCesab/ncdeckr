#' List details of all boards
#'
#' @description
#' Performs an HTTP request (GET method) at the endpoint `/boards` of the 
#' Nextcloud Deck API to retrieve details of all Deck boards.
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
#' }

nc_list_boards <- function() {
  http_request <- .append_endpoint("boards") |>
    httr2::request() |>
    httr2::req_method("GET") |>
    .append_headers() |>
    .append_authentication() |>
    httr2::req_url_query(details = "true")

  http_response <- http_request |>
    httr2::req_perform()

  http_response |>
    httr2::resp_body_json() |>
    .extract_boards_details()
}

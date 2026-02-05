#' List details of all stacks for a board
#'
#' @description
#' Performs an HTTP request (GET method) at the endpoint
#' `/boards/{boardId}/stacks` of the Nextcloud Deck API to retrieve details of
#' all stacks of an active Deck board.
#'
#' @param board_id a `integer` of length 1. The identifier of the board. Use
#'   `nc_list_boards()` to get this value.
#'
#' @return A `data.frame` with the following columns:
#'   - `board_id`: the identifier of the board
#'   - `id`: the identifier of the stack
#'   - `title`: the name of the stack
#'   - `n_cards`: the number of cards in the stack
#'
#' @export
#'
#' @examples
#' \dontrun{
#' ## List details of all Nextcloud stacks of a board
#' nc_list_stacks()
#' }

nc_list_stacks <- function(board_id) {
  if (missing(board_id)) {
    stop("Argument 'board_id' is required", call. = FALSE)
  }

  if (is.null(board_id)) {
    stop("Argument 'board_id' is required", call. = FALSE)
  }

  if (!is.numeric(board_id)) {
    stop("Argument 'board_id' must be a numeric (integer)", call. = FALSE)
  }

  if (length(board_id) != 1) {
    stop("Argument 'board_id' must be a numeric of length 1", call. = FALSE)
  }

  if (any(is.na(board_id))) {
    stop("Argument 'board_id' cannot be NA", call. = FALSE)
  }

  board_id <- as.integer(board_id)

  http_request <- .append_endpoint("boards", board_id, "stacks") |>
    httr2::request() |>
    httr2::req_method("GET") |>
    .append_headers() |>
    .append_authentication()

  http_response <- http_request |>
    httr2::req_error(is_error = \(resp) FALSE) |>
    httr2::req_perform()

  if (httr2::resp_status(http_response) != 200) {
    stop(
      "Unable to retrieve the board '",
      board_id,
      "'.\n  Please use ",
      "'nc_list_boards()'",
      call. = FALSE
    )
  }

  content <- http_response |>
    httr2::resp_body_json() |>
    .extract_stacks_details()

  content
}

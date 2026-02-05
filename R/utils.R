#' Checks and retrieves Nextcloud credentials stored locally
#'
#' @noRd

.get_credentials <- function() {
  nc_user <- Sys.getenv("NEXTCLOUD_USERNAME")

  if (identical(nc_user, "")) {
    stop(
      "The 'NEXTCLOUD_USERNAME' environment variable has not been stored in ",
      "the '~/.Renviron' file.\n  Please read ",
      "https://github.com/FRBCesab/ncdeckr for further information.",
      call. = FALSE
    )
  }

  nc_pass <- Sys.getenv("NEXTCLOUD_PASSWORD")

  if (identical(nc_pass, "")) {
    stop(
      "The 'NEXTCLOUD_PASSWORD' environment variable has not been stored in ",
      "the '~/.Renviron' file.\n  Please read ",
      "https://github.com/FRBCesab/ncdeckr for further information.",
      call. = FALSE
    )
  }

  nc_server <- Sys.getenv("NEXTCLOUD_SERVER")

  if (identical(nc_server, "")) {
    stop(
      "The 'NEXTCLOUD_SERVER' environment variable has not been stored in ",
      "the '~/.Renviron' file.\n  Please read ",
      "https://github.com/FRBCesab/ncdeckr for further information.",
      call. = FALSE
    )
  }

  list(
    "nc_username" = nc_user,
    "nc_password" = nc_pass,
    "nc_server" = nc_server
  )
}


#' Generates API endpoint
#'
#' @noRd

.append_endpoint <- function(...) {
  base_url <- .get_credentials()$"nc_server"
  base_url <- gsub("/$", "", base_url)

  url_paths <- list(...) |>
    unlist()

  paste(
    base_url,
    "index.php",
    "apps",
    "deck",
    "api",
    "v1.0",
    paste0(url_paths, collapse = "/"),
    sep = "/"
  )
}


#' Appends request headers
#'
#' @noRd

.append_headers <- function(.req) {
  if (missing(.req)) {
    stop("Argument '.req' is required", call. = FALSE)
  }

  if (!inherits(.req, "httr2_request")) {
    stop(
      "Argument '.req' must be a 'httr2_request' object created with ",
      "'httr2::request()'",
      call. = FALSE
    )
  }

  .req |>
    httr2::req_headers(`OCS-APIRequest` = "true") |>
    httr2::req_headers(`Content-Type` = "application/json")
}


#' Appends request authentication
#'
#' @noRd

.append_authentication <- function(.req) {
  if (missing(.req)) {
    stop("Argument '.req' is required", call. = FALSE)
  }

  if (!inherits(.req, "httr2_request")) {
    stop(
      "Argument '.req' must be a 'httr2_request' object created with ",
      "'httr2::request()'",
      call. = FALSE
    )
  }

  .req |>
    httr2::req_auth_basic(
      username = .get_credentials()$"nc_username",
      password = .get_credentials()$"nc_password"
    )
}


#' Creates output (data.frame) for nc_list_boards()
#'
#' @noRd

.extract_boards_details <- function(.resp) {
  if (missing(.resp)) {
    stop("Argument '.resp' is required", call. = FALSE)
  }

  if (!is.list(.resp)) {
    stop("Argument '.resp' must be a list", call. = FALSE)
  }

  if (length(.resp) == 0) {
    return(data.frame())
  }

  output <- lapply(.resp, function(board) {
    data.frame(
      id = .extract_item(board, "id"),
      title = .extract_item(board, "title"),
      owner = .extract_item(board$"owner", "uid"),
      color = .extract_item(board, "color"),
      archived = .extract_item(board, "archived"),
      deleted = ifelse(board$"deletedAt" == 0, FALSE, TRUE),
      n_stacks = length(board$"stacks"),
      n_labels = length(board$"labels")
    )
  })

  output <- do.call(rbind.data.frame, output)
  output <- output[order(output$"title", decreasing = FALSE), ]
  rownames(output) <- NULL

  output
}


#' Extracts element from list (json) but check if exists before
#'
#' @noRd

.extract_item <- function(data, name) {
  if (name %in% names(data)) {
    data <- data[[name]]
    names(data) <- NULL
  } else {
    data <- NA
  }

  data
}


#' Creates output (data.frame) for nc_list_stacks()
#'
#' @noRd

.extract_stacks_details <- function(.resp) {
  if (missing(.resp)) {
    stop("Argument '.resp' is required", call. = FALSE)
  }

  if (!is.list(.resp)) {
    stop("Argument '.resp' must be a list", call. = FALSE)
  }

  if (length(.resp) == 0) {
    return(data.frame())
  }

  output <- lapply(.resp, function(stack) {
    data.frame(
      board_id = .extract_item(stack, "boardId"),
      id = .extract_item(stack, "id"),
      title = .extract_item(stack, "title"),
      deleted = ifelse(stack$"deletedAt" == 0, FALSE, TRUE),
      n_cards = length(stack$"cards")
    )
  })

  output <- do.call(rbind.data.frame, output)
  output <- output[order(output$"title", decreasing = FALSE), ]
  rownames(output) <- NULL

  output
}

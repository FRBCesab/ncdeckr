#' Check and retrieve Nextcloud credentials stored locally
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


#' Generate API endpoint
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


#' Append request headers
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

#' Check and retrieve Nextcloud credentials stored locally
#'
#' @noRd

nc_get_credentials <- function() {
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
  base_url <- nc_get_credentials()$"nc_seqrver"
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

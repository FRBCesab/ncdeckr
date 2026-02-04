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

create_tempdir <- function(path = file.path(tempdir(), "sandbox")) {
  old_wd <- getwd()

  withr::defer(fs::dir_delete(path), envir = parent.frame())

  dir.create(path)

  setwd(path)

  withr::defer(setwd(old_wd), envir = parent.frame())

  invisible(path)
}


invisible(
  vcr::vcr_configure(
    filter_sensitive_data = list(
      "<NEXTCLOUD_USERNAME>" = Sys.getenv("NEXTCLOUD_USERNAME"),
      "<NEXTCLOUD_PASSWORD>" = Sys.getenv("NEXTCLOUD_PASSWORD"),
      "<NEXTCLOUD_SERVER>" = Sys.getenv("NEXTCLOUD_SERVER")
    ),
    dir = "fixtures",
    log = FALSE,
    log_opts = list(file = "console")
  )
)

if (Sys.getenv("NEXTCLOUD_USERNAME") == "") {
  Sys.setenv(NEXTCLOUD_USERNAME = "username")
}

if (Sys.getenv("NEXTCLOUD_PASSWORD") == "") {
  Sys.setenv(NEXTCLOUD_PASSWORD = "password")
}

if (Sys.getenv("NEXTCLOUD_SERVER") == "") {
  Sys.setenv(NEXTCLOUD_SERVER = "https://fakesite.com")
}

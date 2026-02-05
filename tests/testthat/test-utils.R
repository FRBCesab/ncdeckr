## Test nc_get_credentials() ----

test_that("Test nc_get_credentials() for error", {
  create_tempdir()

  Sys.setenv("NEXTCLOUD_USERNAME" = "username")
  Sys.setenv("NEXTCLOUD_PASSWORD" = "paswword")
  Sys.setenv("NEXTCLOUD_SERVER" = "https://fakesite.com")

  nextcloud_username <- Sys.getenv("NEXTCLOUD_USERNAME")
  Sys.setenv("NEXTCLOUD_USERNAME" = "")

  expect_error(
    nc_get_credentials()
  )

  Sys.setenv("NEXTCLOUD_USERNAME" = nextcloud_username)

  nextcloud_password <- Sys.getenv("NEXTCLOUD_PASSWORD")
  Sys.setenv("NEXTCLOUD_PASSWORD" = "")

  expect_error(
    nc_get_credentials()
  )

  Sys.setenv("NEXTCLOUD_PASSWORD" = nextcloud_password)

  nextcloud_server <- Sys.getenv("NEXTCLOUD_SERVER")
  Sys.setenv("NEXTCLOUD_SERVER" = "")

  expect_error(
    nc_get_credentials()
  )

  Sys.setenv("NEXTCLOUD_SERVER" = nextcloud_server)

  nextcloud_username <- Sys.getenv("NEXTCLOUD_USERNAME")
  nextcloud_password <- Sys.getenv("NEXTCLOUD_PASSWORD")
  Sys.setenv("NEXTCLOUD_USERNAME" = "")
  Sys.setenv("NEXTCLOUD_PASSWORD" = "")

  expect_error(
    nc_get_credentials()
  )

  Sys.setenv("NEXTCLOUD_USERNAME" = nextcloud_username)
  Sys.setenv("NEXTCLOUD_PASSWORD" = nextcloud_password)

  nextcloud_username <- Sys.getenv("NEXTCLOUD_USERNAME")
  nextcloud_server <- Sys.getenv("NEXTCLOUD_SERVER")
  Sys.setenv("NEXTCLOUD_USERNAME" = "")
  Sys.setenv("NEXTCLOUD_SERVER" = "")

  expect_error(
    nc_get_credentials()
  )

  Sys.setenv("NEXTCLOUD_USERNAME" = nextcloud_username)
  Sys.setenv("NEXTCLOUD_SERVER" = nextcloud_server)

  nextcloud_password <- Sys.getenv("NEXTCLOUD_PASSWORD")
  nextcloud_server <- Sys.getenv("NEXTCLOUD_SERVER")
  Sys.setenv("NEXTCLOUD_PASSWORD" = "")
  Sys.setenv("NEXTCLOUD_SERVER" = "")

  expect_error(
    nc_get_credentials()
  )

  Sys.setenv("NEXTCLOUD_PASSWORD" = nextcloud_password)
  Sys.setenv("NEXTCLOUD_SERVER" = nextcloud_server)

  nextcloud_username <- Sys.getenv("NEXTCLOUD_USERNAME")
  nextcloud_password <- Sys.getenv("NEXTCLOUD_PASSWORD")
  nextcloud_server <- Sys.getenv("NEXTCLOUD_SERVER")
  Sys.setenv("NEXTCLOUD_USERNAME" = "")
  Sys.setenv("NEXTCLOUD_PASSWORD" = "")
  Sys.setenv("NEXTCLOUD_SERVER" = "")

  expect_error(
    nc_get_credentials()
  )

  Sys.setenv("NEXTCLOUD_USERNAME" = nextcloud_username)
  Sys.setenv("NEXTCLOUD_PASSWORD" = nextcloud_password)
  Sys.setenv("NEXTCLOUD_SERVER" = nextcloud_server)
})


test_that("Test nc_get_credentials() for success", {
  create_tempdir()

  expect_silent(x <- nc_get_credentials())

  expect_true(inherits(x, "list"))
  expect_equal(length(x), 3L)

  expect_true("nc_username" %in% names(x))
  expect_true("nc_password" %in% names(x))
  expect_true("nc_server" %in% names(x))

  expect_true(inherits(x[[1]], "character"))
  expect_true(inherits(x[[2]], "character"))
  expect_true(inherits(x[[3]], "character"))
})


## Test .append_endpoint() ----

test_that("Test .append_endpoint() for success", {
  create_tempdir()

  Sys.setenv("NEXTCLOUD_SERVER" = "https://fakesite.com")

  expect_silent(x <- .append_endpoint())

  expect_true(inherits(x, "character"))
  expect_equal(length(x), 1L)

  expect_equal(x, "https://fakesite.com/index.php/apps/deck/api/v1.0/")

  expect_silent(x <- .append_endpoint("boards"))

  expect_true(inherits(x, "character"))
  expect_equal(length(x), 1L)

  expect_equal(x, "https://fakesite.com/index.php/apps/deck/api/v1.0/boards")

  expect_silent(x <- .append_endpoint("boards", 1))

  expect_true(inherits(x, "character"))
  expect_equal(length(x), 1L)

  expect_equal(x, "https://fakesite.com/index.php/apps/deck/api/v1.0/boards/1")
})

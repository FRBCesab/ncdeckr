## Test .get_credentials() ----

test_that("Test .get_credentials() for error", {
  create_tempdir()

  Sys.setenv("NEXTCLOUD_USERNAME" = "username")
  Sys.setenv("NEXTCLOUD_PASSWORD" = "paswword")
  Sys.setenv("NEXTCLOUD_SERVER" = "https://fakesite.com")

  nextcloud_username <- Sys.getenv("NEXTCLOUD_USERNAME")
  Sys.setenv("NEXTCLOUD_USERNAME" = "")

  expect_error(
    .get_credentials()
  )

  Sys.setenv("NEXTCLOUD_USERNAME" = nextcloud_username)

  nextcloud_password <- Sys.getenv("NEXTCLOUD_PASSWORD")
  Sys.setenv("NEXTCLOUD_PASSWORD" = "")

  expect_error(
    .get_credentials()
  )

  Sys.setenv("NEXTCLOUD_PASSWORD" = nextcloud_password)

  nextcloud_server <- Sys.getenv("NEXTCLOUD_SERVER")
  Sys.setenv("NEXTCLOUD_SERVER" = "")

  expect_error(
    .get_credentials()
  )

  Sys.setenv("NEXTCLOUD_SERVER" = nextcloud_server)

  nextcloud_username <- Sys.getenv("NEXTCLOUD_USERNAME")
  nextcloud_password <- Sys.getenv("NEXTCLOUD_PASSWORD")
  Sys.setenv("NEXTCLOUD_USERNAME" = "")
  Sys.setenv("NEXTCLOUD_PASSWORD" = "")

  expect_error(
    .get_credentials()
  )

  Sys.setenv("NEXTCLOUD_USERNAME" = nextcloud_username)
  Sys.setenv("NEXTCLOUD_PASSWORD" = nextcloud_password)

  nextcloud_username <- Sys.getenv("NEXTCLOUD_USERNAME")
  nextcloud_server <- Sys.getenv("NEXTCLOUD_SERVER")
  Sys.setenv("NEXTCLOUD_USERNAME" = "")
  Sys.setenv("NEXTCLOUD_SERVER" = "")

  expect_error(
    .get_credentials()
  )

  Sys.setenv("NEXTCLOUD_USERNAME" = nextcloud_username)
  Sys.setenv("NEXTCLOUD_SERVER" = nextcloud_server)

  nextcloud_password <- Sys.getenv("NEXTCLOUD_PASSWORD")
  nextcloud_server <- Sys.getenv("NEXTCLOUD_SERVER")
  Sys.setenv("NEXTCLOUD_PASSWORD" = "")
  Sys.setenv("NEXTCLOUD_SERVER" = "")

  expect_error(
    .get_credentials()
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
    .get_credentials()
  )

  Sys.setenv("NEXTCLOUD_USERNAME" = nextcloud_username)
  Sys.setenv("NEXTCLOUD_PASSWORD" = nextcloud_password)
  Sys.setenv("NEXTCLOUD_SERVER" = nextcloud_server)
})


test_that("Test .get_credentials() for success", {
  create_tempdir()

  expect_silent(x <- .get_credentials())

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


## Test .append_headers() ----

test_that("Test .append_headers() for error", {
  create_tempdir()

  Sys.setenv("NEXTCLOUD_SERVER" = "https://fakesite.com")

  expect_error(
    .append_headers(),
    "Argument '.req' is required",
    fixed = TRUE
  )

  expect_error(
    .append_headers(.append_endpoint()),
    paste0(
      "Argument '.req' must be a 'httr2_request' object created with ",
      "'httr2::request()'"
    ),
    fixed = TRUE
  )
})

test_that("Test .append_headers() for success", {
  create_tempdir()

  Sys.setenv("NEXTCLOUD_SERVER" = "https://fakesite.com")

  http_request <- .append_endpoint() |>
    httr2::request()

  expect_equal(length(http_request$"headers"), 0L)

  expect_silent(x <- .append_headers(http_request))

  expect_true(inherits(x, "httr2_request"))
  expect_equal(length(x$"headers"), 2L)

  expect_equal(names(x$headers)[1], "OCS-APIRequest")
  expect_equal(names(x$headers)[2], "Content-Type")

  expect_equal(x$headers[[1]], "true")
  expect_equal(x$headers[[2]], "application/json")
})


## Test .append_authentication() ----

test_that("Test .append_authentication() for error", {
  create_tempdir()

  Sys.setenv("NEXTCLOUD_SERVER" = "https://fakesite.com")

  expect_error(
    .append_authentication(),
    "Argument '.req' is required",
    fixed = TRUE
  )

  expect_error(
    .append_authentication(.append_endpoint()),
    paste0(
      "Argument '.req' must be a 'httr2_request' object created with ",
      "'httr2::request()'"
    ),
    fixed = TRUE
  )
})

test_that("Test .append_authentication() for success", {
  create_tempdir()

  Sys.setenv("NEXTCLOUD_SERVER" = "https://fakesite.com")

  http_request <- .append_endpoint() |>
    httr2::request()

  expect_equal(length(http_request$"headers"), 0L)

  expect_silent(x <- .append_authentication(http_request))

  expect_true(inherits(x, "httr2_request"))
  expect_equal(length(x$"headers"), 1L)

  expect_equal(names(x$headers)[1], "Authorization")
})

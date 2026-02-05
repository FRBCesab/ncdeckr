## Test .get_credentials() ----

test_that("Test .get_credentials() for error", {
  create_tempdir()

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

  expect_silent(x <- .append_endpoint())

  expect_true(inherits(x, "character"))
  expect_equal(length(x), 1L)

  expect_equal(
    x,
    paste0(Sys.getenv("NEXTCLOUD_SERVER"), "/index.php/apps/deck/api/v1.0/")
  )

  expect_silent(x <- .append_endpoint("boards"))

  expect_true(inherits(x, "character"))
  expect_equal(length(x), 1L)

  expect_equal(
    x,
    paste0(
      Sys.getenv("NEXTCLOUD_SERVER"),
      "/index.php/apps/deck/api/v1.0/boards"
    )
  )

  expect_silent(x <- .append_endpoint("boards", 1))

  expect_true(inherits(x, "character"))
  expect_equal(length(x), 1L)

  expect_equal(
    x,
    paste0(
      Sys.getenv("NEXTCLOUD_SERVER"),
      "/index.php/apps/deck/api/v1.0/boards/1"
    )
  )
})


## Test .append_headers() ----

test_that("Test .append_headers() for error", {
  create_tempdir()

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

  http_request <- .append_endpoint() |>
    httr2::request()

  expect_equal(length(http_request$"headers"), 0L)

  expect_silent(x <- .append_authentication(http_request))

  expect_true(inherits(x, "httr2_request"))
  expect_equal(length(x$"headers"), 1L)

  expect_equal(names(x$headers)[1], "Authorization")
})


## Test .extract_item() ----

test_that("Test .extract_item() for success", {
  fake_data <- list(a = 1, b = 2, c = list(d = 3, e = 4:6))

  expect_silent(x <- .extract_item(data = fake_data, name = "a"))
  expect_true(inherits(x, "numeric"))
  expect_equal(length(x), 1L)
  expect_equal(x, 1L)

  expect_silent(x <- .extract_item(data = fake_data$"c", name = "d"))
  expect_true(inherits(x, "numeric"))
  expect_equal(length(x), 1L)
  expect_equal(x, 3L)

  expect_silent(x <- .extract_item(data = fake_data, name = "f"))
  expect_true(inherits(x, "logical"))
  expect_equal(length(x), 1L)
  expect_equal(x, NA)
})


## Test .extract_boards_details() ----

test_that("Test .extract_boards_details() for error", {
  expect_error(
    .extract_boards_details(),
    "Argument '.resp' is required",
    fixed = TRUE
  )

  expect_error(
    .extract_boards_details(matrix()),
    "Argument '.resp' must be a list",
    fixed = TRUE
  )

  expect_error(
    .extract_boards_details(1L),
    "Argument '.resp' must be a list",
    fixed = TRUE
  )

  expect_error(
    .extract_boards_details(letters),
    "Argument '.resp' must be a list",
    fixed = TRUE
  )
})

test_that("Test .extract_boards_details() for success", {
  ### No board returned
  expect_silent(x <- .extract_boards_details(list()))

  expect_true(inherits(x, "data.frame"))
  expect_equal(ncol(x), 0L)
  expect_equal(nrow(x), 0L)

  ### One board returned w/ full information

  fake_board <- list(
    list(
      id = 1,
      title = "Fake board",
      owner = list(uid = "jdoe", name = "Jane Doe"),
      color = "000000",
      archived = TRUE,
      deletedAt = 0,
      stacks = list(list(name = "Stack 1"), list(name = "Stack 2")),
      labels = list(
        list(name = "Label 1"),
        list(name = "Label 2"),
        list(name = "Label 3")
      )
    )
  )

  expect_silent(x <- .extract_boards_details(fake_board))

  expect_true(inherits(x, "data.frame"))
  expect_equal(ncol(x), 8L)
  expect_equal(nrow(x), 1L)

  expect_equal(x[1, "id"], 1L)
  expect_equal(x[1, "title"], "Fake board")
  expect_equal(x[1, "owner"], "jdoe")
  expect_equal(x[1, "color"], "000000")
  expect_equal(x[1, "archived"], TRUE)
  expect_equal(x[1, "deleted"], FALSE)
  expect_equal(x[1, "n_stacks"], 2L)
  expect_equal(x[1, "n_labels"], 3L)

  ### Two boards returned w/ full information

  fake_board <- list(
    list(
      id = 1,
      title = "Fake board",
      owner = list(uid = "jdoe", name = "Jane Doe"),
      color = "000000",
      archived = TRUE,
      deletedAt = 0,
      stacks = list(list(name = "Stack 1"), list(name = "Stack 2")),
      labels = list(
        list(name = "Label 1"),
        list(name = "Label 2"),
        list(name = "Label 3")
      )
    ),
    list(
      id = 1,
      title = "Fake board",
      owner = list(uid = "jdoe", name = "Jane Doe"),
      color = "000000",
      archived = TRUE,
      deletedAt = 0,
      stacks = list(list(name = "Stack 1"), list(name = "Stack 2")),
      labels = list(
        list(name = "Label 1"),
        list(name = "Label 2"),
        list(name = "Label 3")
      )
    )
  )

  expect_silent(x <- .extract_boards_details(fake_board))

  expect_true(inherits(x, "data.frame"))
  expect_equal(ncol(x), 8L)
  expect_equal(nrow(x), 2L)

  expect_equal(x[1, "id"], 1L)
  expect_equal(x[1, "title"], "Fake board")
  expect_equal(x[1, "owner"], "jdoe")
  expect_equal(x[1, "color"], "000000")
  expect_equal(x[1, "archived"], TRUE)
  expect_equal(x[1, "deleted"], FALSE)
  expect_equal(x[1, "n_stacks"], 2L)
  expect_equal(x[1, "n_labels"], 3L)

  expect_equal(x[2, "id"], 1L)
  expect_equal(x[2, "title"], "Fake board")
  expect_equal(x[2, "owner"], "jdoe")
  expect_equal(x[2, "color"], "000000")
  expect_equal(x[2, "archived"], TRUE)
  expect_equal(x[2, "deleted"], FALSE)
  expect_equal(x[2, "n_stacks"], 2L)
  expect_equal(x[2, "n_labels"], 3L)

  ### One board returned w/ missing information

  fake_board <- list(
    list(
      id = 1,
      title = "Fake board",
      # owner = list(uid = "jdoe", name = "Jane Doe"),
      # color = "000000",
      archived = TRUE,
      deletedAt = 0,
      # stacks = list(list(name = "Stack 1"), list(name = "Stack 2")),
      labels = list(
        list(name = "Label 1"),
        list(name = "Label 2"),
        list(name = "Label 3")
      )
    )
  )

  expect_silent(x <- .extract_boards_details(fake_board))

  expect_true(inherits(x, "data.frame"))
  expect_equal(ncol(x), 8L)
  expect_equal(nrow(x), 1L)

  expect_equal(x[1, "id"], 1L)
  expect_equal(x[1, "title"], "Fake board")
  expect_equal(x[1, "owner"], NA)
  expect_equal(x[1, "color"], NA)
  expect_equal(x[1, "archived"], TRUE)
  expect_equal(x[1, "deleted"], FALSE)
  expect_equal(x[1, "n_stacks"], 0L)
  expect_equal(x[1, "n_labels"], 3L)

  ### Two boards returned w/ missing information

  fake_board <- list(
    list(
      id = 1,
      title = "Fake board",
      # owner = list(uid = "jdoe", name = "Jane Doe"),
      # color = "000000",
      archived = TRUE,
      deletedAt = 0,
      # stacks = list(list(name = "Stack 1"), list(name = "Stack 2")),
      labels = list(
        list(name = "Label 1"),
        list(name = "Label 2"),
        list(name = "Label 3")
      )
    ),
    list(
      id = 1,
      # title = "Fake board",
      owner = list(uid = "jdoe", name = "Jane Doe"),
      color = "000000",
      # archived = TRUE,
      deletedAt = 0,
      stacks = list(list(name = "Stack 1"), list(name = "Stack 2"))
    )
  )

  expect_silent(x <- .extract_boards_details(fake_board))

  expect_true(inherits(x, "data.frame"))
  expect_equal(ncol(x), 8L)
  expect_equal(nrow(x), 2L)

  expect_equal(x[1, "id"], 1L)
  expect_equal(x[1, "title"], "Fake board")
  expect_equal(x[1, "owner"], NA_character_)
  expect_equal(x[1, "color"], NA_character_)
  expect_equal(x[1, "archived"], TRUE)
  expect_equal(x[1, "deleted"], FALSE)
  expect_equal(x[1, "n_stacks"], 0L)
  expect_equal(x[1, "n_labels"], 3L)

  expect_equal(x[2, "id"], 1L)
  expect_equal(x[2, "title"], NA_character_)
  expect_equal(x[2, "owner"], "jdoe")
  expect_equal(x[2, "color"], "000000")
  expect_equal(x[2, "archived"], NA)
  expect_equal(x[2, "deleted"], FALSE)
  expect_equal(x[2, "n_stacks"], 2L)
  expect_equal(x[2, "n_labels"], 0L)
})

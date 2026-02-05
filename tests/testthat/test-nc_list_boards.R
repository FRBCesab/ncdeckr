## Test nc_list_boards() ----

test_that("Test nc_list_boards() for success", {
  skip_on_cran()
  vcr::local_vcr_configure_log()
  vcr::local_cassette("nc_list_boards")

  expect_silent(x <- nc_list_boards())

  expect_true(inherits(x, "data.frame"))
  expect_true(ncol(x) == 8L)
  expect_true(nrow(x) > 0L)

  expect_silent(x <- nc_list_boards(archived = TRUE))

  expect_true(inherits(x, "data.frame"))
  expect_true(ncol(x) == 8L)
  expect_true(nrow(x) > 0L)

  expect_silent(x <- nc_list_boards(deleted = TRUE))

  expect_true(inherits(x, "data.frame"))
  expect_true(ncol(x) == 8L)
  expect_true(nrow(x) > 0L)
})

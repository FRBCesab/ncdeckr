## Test nc_list_boards() ----

test_that("Test nc_list_boards() for success", {
  skip_on_cran()

  vcr::local_cassette("nc_list_boards")

  expect_silent(x <- nc_list_boards())

  expect_true(inherits(x, "data.frame"))
  expect_true(ncol(x) == 8L)
  expect_true(nrow(x) > 0L)

  expect_true("Personal" %in% x$"title")
})

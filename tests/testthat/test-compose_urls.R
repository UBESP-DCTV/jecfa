test_that("remuve_null_urls works", {
  x <- list(
    list(
      url = "https://www.who.int",
      fnm = "foo"
    ),
    list(
      url = NULL,
      fnm = "bar"
    ),
    list(
      url = "https://www.who.int",
      fnm = NULL
    ),
    list(
      url = NULL,
      fnm = NULL
    )
  )

  res <- remove_null_urls(x)
  expected <- list(
    list(
      url = "https://www.who.int",
      fnm = "foo"
    ),
    list(
      url = "https://www.who.int",
      fnm = NULL
    )
  )

  expect_equal(res, expected)
})

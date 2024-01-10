test_that("create_df works", {
  res <- create_df(7)
  expect_snapshot_value(res, style = "serialize")
})

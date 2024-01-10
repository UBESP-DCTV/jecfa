test_that("process_df works", {
  res <- create_df(7) |>
    process_df()

  expect_snapshot_value(res, style = "deparse")
})

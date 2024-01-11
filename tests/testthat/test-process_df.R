test_that("process_df works", {
  res <- create_df(7) |>
    process_df()

  res |>
    expect_snapshot_value("deparse")
})

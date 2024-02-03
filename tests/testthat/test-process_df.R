test_that("process_df works", {
  # setup
  db_test <- test_path("data-test/jecfa_oks_30.rds") |>
    readRDS() |>
    (\(x) x[1:7])()


  # execution
  res <- create_df(db_test) |>
    process_df()

  res |>
    expect_snapshot_value("deparse")
})

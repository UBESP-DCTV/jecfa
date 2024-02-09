test_that("create_df works", {
  # setup
  db_test <- test_path("data-test/jecfa_oks_30.rds") |>
    readRDS() |>
    (\(x) x[1:7])()


  # execution
  res <- create_df(db_test)

  # test
  res |>
    expect_snapshot_value("serialize")
})



test_that("get_chemical works", {
  # execution
  ok <- get_chemical(7)

  # test
  ok |>
    expect_snapshot_value("serialize")
})

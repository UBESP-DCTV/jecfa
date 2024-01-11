test_that("create_df works", {
  res <- create_df(7)
  res |>
    expect_snapshot_value("serialize")
})



test_that("get_chemical works", {

  ok <- get_chemical(7)
  ok |>
    expect_snapshot_value("serialize")
})

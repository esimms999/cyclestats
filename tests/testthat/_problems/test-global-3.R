# Extracted from test-global.R:3

# setup ------------------------------------------------------------------------
library(testthat)
test_env <- simulate_test_env(package = "cyclestats", path = "..")
attach(test_env, warn.conflicts = FALSE)

# test -------------------------------------------------------------------------
invalid_data_distance <- activities |>
    dplyr::filter(is.na(activity_distance) | activity_distance <= 0)

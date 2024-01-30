#' Prepare data for use within the app
#'
#' @return
#' @export
#' @importFrom dplyr filter mutate rename select
#' @import magrittr
#' @importFrom readr read_csv

cyclestats_init <- function() {
  # The activities.csv file has been downloaded from Strava and placed in /inst/extdata
  # Keep only ride info, convert from km to miles, keep only variables which will be used in the app.
  activities <<- readr::read_csv("inst/extdata/activities.csv",
                                 show_col_types = FALSE,
                                 col_select = c(1:7, 17),
                                 name_repair = "minimal") |>

    dplyr::rename("activity_id" = "Activity ID",
                  "activity_datetime" = "Activity Date",
                  "activity_name" = "Activity Name",
                  "activity_type" = "Activity Type",
                  "activity_distance" = "Distance",
                  "activity_moving_time" = "Moving Time") |>

    dplyr::filter(activity_type == "Ride") |>
    dplyr::select(activity_id, activity_datetime, activity_name, activity_distance, activity_moving_time) |>

    # Fix an error in the data
    dplyr::mutate(activity_moving_time = ifelse(activity_id == "2949643229", 3271, activity_moving_time)) |>

    dplyr::mutate(activity_id = as.character(activity_id),
                  activity_date = format(as.Date(lubridate::mdy(stringr::str_sub(activity_datetime, 1L, 12L)), "%Y-%m-%d")),
                  activity_year = format(as.Date(activity_date), "%Y"),
                  activity_month = format(as.Date(activity_date), "%m"),
                  activity_year_month = format(as.Date(activity_date), "%Y-%m"),
                  activity_distance = round(activity_distance * 0.6214, digits = 2),
                  activity_avg_speed = round(activity_distance / (activity_moving_time / 3600), digits = 2)) |>

    dplyr::select(activity_id, activity_name, activity_datetime, activity_date, activity_year, activity_month, activity_year_month, activity_distance, activity_avg_speed)

  # Find years available; used to create selection widget for years
  available_years <<- as.list(unique(activities$activity_year))

  # In the graph, we want to show distance as zero for year_month without records.
  # This dataframe will be subset and merged with the activities in order to add
  # these zero records.

  activity_year <- c()
  activity_year_month <- c()
  for (year in available_years) {
    for (month in 1:12) {
      year_month <- paste(year, formatC(month, width = 2, flag = 0), sep = "-")
      activity_year_month <- append(activity_year_month, year_month)
      activity_year <- append(activity_year, year)
    }
  }
  activity_year_month_zero <<- data.frame(activity_year, activity_year_month) |>
    dplyr::arrange(activity_year_month)
}

cyclestats_init()



#' Prepare data for use within the app
#'
#' @return
#' @export
#' @import magrittr
#' @importFrom dplyr filter mutate select
#' @importFrom lubridate mdy
#' @importFrom stringr str_sub
#' @examples

cyclestats_init <- function() {
  # The activities.csv file has been downloaded from Strava and placed in /inst/extdata
  # Keep only ride info, convert from km to miles, keep only variables which will be used n the app.
  activities <<- readr::read_csv("inst/extdata/activities.csv",
                                 show_col_types = FALSE,
                                 col_select = c(1:7),
                                 name_repair = "minimal") |>

    dplyr::rename("activity_id" = "Activity ID",
                  "activity_datetime" = "Activity Date",
                  "activity_name" = "Activity Name",
                  "activity_type" = "Activity Type",
                  "activity_distance" = "Distance") |>

    dplyr::filter(activity_type == "Ride") |>
    dplyr::select(activity_id, activity_datetime, activity_name, activity_distance) |>

    dplyr::mutate(activity_id = as.character(activity_id),
                  activity_date = format(as.Date(lubridate::mdy(stringr::str_sub(activity_datetime, 1L, 12L)), "%Y-%m-%d")),
                  activity_year = format(as.Date(activity_date), "%Y"),
                  activity_month = format(as.Date(activity_date), "%m"),
                  activity_year_month = format(as.Date(activity_date), "%Y-%m"),
                  activity_distance = round(activity_distance * 0.6214, digits = 2))

  # Find years available; used to create selection widget for years
  available_years <<- as.list(unique(activities$activity_year))
}

cyclestats_init()



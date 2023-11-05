#' Prepare data for use within the app
#'
#' @return
#' @export
#' @importFrom dplyr filter mutate select
#' @importFrom lubridate mdy year month
#' @importFrom magrittr %>%
#' @importFrom stringr str_sub
#' @examples

cyclestats_init <- function() {
  # The activities.csv file has been downloaded from Strava and placed in /inst/extdata
  activities <<- readr::read_csv("inst/extdata/activities.csv",
                                 show_col_types = FALSE) %>%
    dplyr::rename("activity_id" = "Activity ID",
                  "activity_datetime" = "Activity Date",
                  "activity_name" = "Activity Name",
                  "activity_type" = "Activity Type",
                  "activity_distance" = "Distance...7") %>%
    dplyr::filter(activity_type == "Ride") %>%
    dplyr::select(activity_id, activity_datetime, activity_name, activity_distance) %>%
    dplyr::mutate(activity_id = as.character(activity_id),
                  activity_date = format(as.Date(mdy(stringr::str_sub(activity_datetime, 1L, 12L)), "%Y-%m-%d")),
                  activity_year = format(as.Date(activity_date), "%Y"),
                  activity_month = format(as.Date(activity_date), "%m"),
                  activity_year_month = format(as.Date(activity_date), "%Y-%m"),
                  activity_distance = round(activity_distance * 0.6214, digits = 2))

  data(penguins, package = "palmerpenguins")

  cards <<- list(
    card(
      full_screen = TRUE,
      card_header("Bill Length"),
      plotOutput("bill_length")
    ),
    card(
      full_screen = TRUE,
      card_header("Bill depth"),
      plotOutput("bill_depth")
    ),
    card(
      full_screen = TRUE,
      card_header("Body Mass"),
      plotOutput("body_mass")
    )
  )

  # Create selection widget for years based on the years available
  available_years <- as.list(unique(activities$activity_year))

  selected_years <<- checkboxGroupInput(
    inputId = "selected_years",
    label = "Selected Year(s):",
    choices = available_years
  )

  # means <<- colMeans(
  #   penguins[c("bill_length_mm", "bill_length_mm", "body_mass_g")],
  #   na.rm = TRUE
  #)
}

cyclestats_init()

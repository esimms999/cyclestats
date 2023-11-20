#' Title
#'
#' @return
#' @export
#' @import bslib
#' @import bsicons
#' @examples

cyclestats_ui <- function() {
  page_sidebar(
    title = "Cycling Analysis",
    bg = "lightblue",

    sidebar = checkboxGroupInput(
      inputId = "selected_years",
      label = "Selected Year(s):",
      choices = available_years
    ),

    layout_columns(
      fill = FALSE,
      value_box(
        title = "Rides",
        #value = scales::unit_format(unit = "mm")(means[[2]]),
        value = textOutput("number_of_rides"),
        showcase = bsicons::bs_icon("bicycle")
      ),
      value_box(
        title = "Miles",
        value = textOutput("number_of_miles"),
        showcase = bsicons::bs_icon("speedometer2")
      )
    ),

    navset_card_pill(
      title = "",
      nav_panel("Graph", plotOutput("miles_graph", width = "auto", height = "auto")),
      nav_panel("Table", div(dataTableOutput("miles_table"), style = "font-size:80%")),
      nav_panel("About", uiOutput("about_text"))
    ),
  )
}

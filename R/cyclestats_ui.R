#' Title
#'
#' @return
#' @export
#' @import bslib
#' @examples

cyclestats_ui <- function() {
  page_sidebar(
    title = "Cycling Analysis",
    sidebar = selected_years,

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
      nav_panel("Graph", plotOutput("bill_length", width = "500", height = "auto")),
      nav_panel("Table", tableOutput("bill_depth")),
      nav_panel("About", uiOutput("about_text"))
    ),
  )
}

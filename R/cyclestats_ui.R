#' Title
#'
#' @return
#' @export
#' @import bslib
#' @examples

cyclestats_ui <- function() {
  page_sidebar(
    title = "Cycling Analysis",
    sidebar = color_by,

    layout_columns(
      fill = FALSE,
      value_box(
        title = "Rides",
        value = scales::unit_format(unit = "mm")(means[[2]]),
        showcase = bsicons::bs_icon("bicycle")
      ),
      value_box(
        title = "Miles",
        value = scales::unit_format(unit = "g", big.mark = ",")(means[[3]]),
        showcase = bsicons::bs_icon("speedometer2")
      )
    ),

    navset_card_pill(
      title = "Miles by Month",
      nav_panel("Graph", plotOutput("bill_length")),
      nav_panel("Table", plotOutput("bill_depth")),
      nav_panel("About", plotOutput("body_mass"))
    ),
  )
}

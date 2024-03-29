#' Title
#'
#' UI for cyclestats app
#' @import bslib
#' @import bsicons
#' @import shiny
#' @importFrom DT DTOutput
#' @rawNamespace import(shinyjs, except=c(runExample))
#' @rawNamespace import(plotly, except = last_plot)
#' @return `ui` argument in `cyclestatsApp()`

cyclestats_ui <- function() {
  useShinyjs()
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
      id = "tab_being_displayed",
      nav_panel("Graph", plotly::plotlyOutput("miles_graph", width = "auto", height = "auto")),
      nav_panel("Table", div(DT::DTOutput("miles_table"), style = "font-size:80%")),
      nav_panel("About", uiOutput("about_text"))
    ),
  )
}

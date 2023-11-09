# Define server logic

#' Title
#'
#' @param input
#' @param output
#'
#' @return
#' @export
#' @import ggplot2
#' @importFrom dplyr count filter group_by summarise
#' @importFrom markdown markdownToHTML
#' @examples

cyclestats_server <- function(input, output) {

  # value_box for number of rides
  number_of_rides <- reactive({
    as.character(dplyr::count(activities_selected()))
  })

  # value_box for number of miles
  number_of_miles <- reactive({
    as.character(sum(activities_selected()$activity_distance))
  })

  # Filter by selected years
  activities_selected <- reactive({
    activities |>
      dplyr::filter(activity_year %in% input$selected_years)
  })

  # Get total for each year-month for use in graph. This is needed in order to
  # get solid lines on the chart, otherwise there are dividing lines in the bars
  # for each individual record.
  #
  # Also, we want the graph to show all months, including those without any rides.
  # Create records for those with zero miles.

  activities_selected_sum <- reactive({
    activities |>
      dplyr::filter(activity_year %in% input$selected_years) |>
      dplyr::group_by(activity_year_month) |>
      dplyr::summarise(total_distance = sum(activity_distance))
  })

  gg_plot <- reactive({
    ggplot(data = activities_selected_sum(), aes(x = activity_year_month, y = total_distance)) +
      geom_col(fill = "blue") +
      ggtitle("Total Miles by Month") +
      xlab("\nMonth") +
      ylab("Miles") +
      theme(axis.text.x = element_text(angle = 90)) +
      theme(panel.border = element_rect(color = "blue",
                                        fill = NA,
                                        linewidth = 1))
  })

  output$miles_graph <- renderPlot(gg_plot(), width = "auto", height = "auto", res = 128)
  output$miles_table <- renderDataTable(activities_selected())
  output$about_text <- renderUI({
    HTML(markdown::markdownToHTML('inst/www/about.txt', fragment.only = TRUE))
    })
  output$number_of_rides <- renderText(number_of_rides())
  output$number_of_miles <- renderText(number_of_miles())
}

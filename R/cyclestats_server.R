# Define server logic

#' Server for cyclestats app
#'
#' @import ggplot2
#' @importFrom DT renderDT
#' @rawNamespace import(plotly, except = last_plot)
#' @return `server` argument in `cyclestatsApp()`

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
      dplyr::mutate(ride_count = 1) |>
      dplyr::summarise(total_distance = sum(activity_distance),
                       total_rides = sum(ride_count))
  })

  activities_selected_graph <- reactive({
    activity_year_month_zero |>
      dplyr::filter(activity_year %in% input$selected_years) |>
      dplyr::left_join(activities_selected_sum(), by = "activity_year_month") |>
      dplyr::mutate(total_distance = (dplyr::if_else(is.na(total_distance), 0, total_distance)),
                    total_rides = (dplyr::if_else(is.na(total_rides), 0, total_rides)))
  })

  gg_plot <- reactive({
    plotly::ggplotly(
      ggplot2::ggplot(data = activities_selected_graph(),
                      aes(x = activity_year_month,
                          y = total_distance,
                          text = paste("Year-Month: ", activity_year_month,
                                       "\nDistance: ", total_distance,
                                       "\nRides: ", total_rides)
                          )
                      ) +
        geom_col(fill = "blue") +
        ggtitle("Total Miles by Month") +
        xlab("\nMonth") +
        ylab("Miles") +
        theme(axis.text.x = element_text(angle = 90)) +
        theme(panel.border = element_rect(color = "blue",
                                          fill = NA,
                                          linewidth = 1)),
     tooltip = c("text")
     )
    })

  #output$miles_graph <- plotly::renderPlotly(gg_plot(), width = "auto", height = "auto", res = 128)
  output$miles_graph <- plotly::renderPlotly(gg_plot())
  output$miles_table <- DT::renderDT(activities_selected())
  output$about_text <- renderUI({
    HTML(markdown::markdownToHTML('inst/www/about.md', fragment.only = TRUE))
    })
  output$number_of_rides <- renderText(number_of_rides())
  output$number_of_miles <- renderText(number_of_miles())
}

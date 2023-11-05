# Define server logic

#' Title
#'
#' @param input
#' @param output
#'
#' @return
#' @export
#' @import ggplot2
#' @importFrom dplyr count
#' @importFrom markdown markdownToHTML
#' @examples

cyclestats_server <- function(input, output) {
  #output$number_of_rides <- renderText(as.character(dplyr::count(activities)))

  number_of_rides <- reactive({
    activities_selected <- activities %>%
      filter(activity_year == "2019")
    as.character(dplyr::count(activities_selected))
  })

  number_of_miles <- reactive({
    activities_selected <- activities %>%
      filter(activity_year == "2019")
    as.character(sum(activities_selected$activity_distance))
  })

  gg_plot <- reactive({
    ggplot(penguins) +
      geom_density(aes(fill = !!input$color_by), alpha = 0.2) +
      theme_bw(base_size = 16) +
      theme(axis.title = element_blank())
  })

  output$bill_length <- renderPlot(gg_plot() + aes(bill_length_mm))
  output$bill_depth <- renderTable(activities)
  output$about_text <- renderUI({
    HTML(markdown::markdownToHTML('inst/www/hello.txt', fragment.only = TRUE))
    })
  output$number_of_rides <- renderText(number_of_rides())
  output$number_of_miles <- renderText(number_of_miles())
}

# Define server logic

#' Title
#'
#' @param input
#' @param output
#'
#' @return
#' @export
#' @import ggplot2
#' @examples

cyclestats_server <- function(input, output) {
  activities_selected <- activities

  #output$number_of_rides <- renderText(as.character(dplyr::count(activities)))

  gg_plot <- reactive({
    ggplot(penguins) +
      geom_density(aes(fill = !!input$color_by), alpha = 0.2) +
      theme_bw(base_size = 16) +
      theme(axis.title = element_blank())
  })

  output$bill_length <- renderPlot(gg_plot() + aes(bill_length_mm))
  output$bill_depth <- renderTable(activities)
  output$body_mass <- renderText("hELLO. sOME TEXT.")
}

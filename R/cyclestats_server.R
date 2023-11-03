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
  gg_plot <- reactive({
    ggplot(penguins) +
      geom_density(aes(fill = !!input$color_by), alpha = 0.2) +
      theme_bw(base_size = 16) +
      theme(axis.title = element_blank())
  })

  output$bill_length <- renderPlot(gg_plot() + aes(bill_length_mm))
  output$bill_depth <- renderPlot(gg_plot() + aes(bill_depth_mm))
  output$body_mass <- renderText("hELLO. sOME TEXT.")
}

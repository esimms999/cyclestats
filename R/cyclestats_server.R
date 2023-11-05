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

  activities_selected <- reactive({
    activities %>%
      filter(activity_year == "2019")
  })

  number_of_rides <- reactive({
    as.character(dplyr::count(activities_selected()))
  })

  number_of_miles <- reactive({
    as.character(sum(activities_selected()$activity_distance))
  })

  gg_plot <- reactive({
    ggplot(data = activities_selected(), aes(x = activity_year_month, y = activity_distance)) +
      geom_col(fill = "blue") +
      ggtitle("Total Miles by Month") +
      xlab("Month") +
      ylab("Miles") +
      theme(axis.text.x = element_text(angle = 90)) +
      theme(panel.border = element_rect(color = "blue",
                                        fill = NA,
                                        size = 1))
  })

  output$bill_length <- renderPlot(gg_plot(), width = 500, height = 500, res = 128)
  output$bill_depth <- renderTable(activities)
  output$about_text <- renderUI({
    HTML(markdown::markdownToHTML('inst/www/hello.txt', fragment.only = TRUE))
    })
  output$number_of_rides <- renderText(number_of_rides())
  output$number_of_miles <- renderText(number_of_miles())
}

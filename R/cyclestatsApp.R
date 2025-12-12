#' Launch the CycleStats Shiny application
#'
#' @export
cyclestatsApp <- function() {
  shiny::shinyApp(ui = cyclestats_ui, server = cyclestats_server)
}

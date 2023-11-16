#' Cycle Stats app standalone function
#'
#' Wrapper function for `shinyApp()`
#'
#' @return shiny app
#'
#' @import shiny
#'
#' @export cyclestatsApp
#'
cyclestatsApp <- function() {
  shiny::shinyApp(ui = cyclestats_ui, server = cyclestats_server)
}

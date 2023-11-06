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
  shinyApp(ui = cyclestats_ui, server = cyclestats_server)
}

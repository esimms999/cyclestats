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
  options(shiny.autoload.r=FALSE) # Attempt to avoid warning about source-ing files - not helping.
  shiny::shinyApp(ui = cyclestats_ui, server = cyclestats_server)
}

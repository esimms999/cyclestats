# app.R — The One That Finally Works Forever

# 1. Load your package (this automatically runs R/global.R first)
library(cyclestats)

# 2. Optional: tiny safety net in case something weird happens
if (!exists("cyclestats_ui") || !exists("cyclestats_server")) {
  stop("Error: cyclestats_ui or cyclestats_server not found. ",
       "Did you run devtools::document() and reinstall the package?")
}

# 3. Launch the app
shiny::shinyApp(
  ui = cyclestats_ui,
  server = cyclestats_server
)

# Launch the ShinyApp (Do not remove this comment)
# To deploy, run: rsconnect::deployApp()
# Or use the blue button on top of this file

#pkgload::load_all(".")

# Set option to avoid warning about R directory, etc.
# This does not seem to work. Trying another proposed solution: R/_disable.R
# options(shiny.autoload.r=FALSE)

# pkgload::load_all(export_all = FALSE,
#                   helpers = FALSE,
#                   attach_testthat = FALSE)
#
# cyclestats::cyclestatsApp()
#
# ++++++++++

  withr::with_options(new = list(shiny.autoload.r = FALSE), code = {
      if (!interactive()) {
      sink(stderr(), type = "output")
      tryCatch(
        expr = {
          library(cyclestats)
        },
        error = function(e) {
          pkgload::load_all()
        }
      )
      } else {
        pkgload::load_all()
      }
      cyclestats::cyclestatsApp()
      # options = list(test.mode = TRUE), run = 'p')
  })

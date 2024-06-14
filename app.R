# Launch the ShinyApp (Do not remove this comment)
# To deploy, run: rsconnect::deployApp()
# Or use the blue button on top of this file

  withr::with_options(new = list(shiny.autoload.r = FALSE), code = {
      if (!interactive()) {
      sink(stderr(), type = "output")
      tryCatch(
        expr = {
          # load package
          library(cyclestats)
        },
        error = function(e) {
          # load R/ folder
          pkgload::load_all()
        }
      )
      } else {
        #load R/ folder
        pkgload::load_all()
      }

    # create shiny object
    cyclestats::cyclestatsApp()
  })

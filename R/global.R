#' Title
#'
#' @return
#' @export
#'
#' @examples

cyclestats_init <- function() {
  data(penguins, package = "palmerpenguins")

  cards <<- list(
    card(
      full_screen = TRUE,
      card_header("Bill Length"),
      plotOutput("bill_length")
    ),
    card(
      full_screen = TRUE,
      card_header("Bill depth"),
      plotOutput("bill_depth")
    ),
    card(
      full_screen = TRUE,
      card_header("Body Mass"),
      plotOutput("body_mass")
    )
  )

  color_by <<- checkboxGroupInput(
    inputId = "color_by",
    label = "Year(s)",
    choices = penguins[c("species", "island", "sex")],
    selected = "species"
  )

  means <<- colMeans(
    penguins[c("bill_length_mm", "bill_length_mm", "body_mass_g")],
    na.rm = TRUE
  )
}

cyclestats_init()

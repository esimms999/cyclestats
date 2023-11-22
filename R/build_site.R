#' Build pkgdown site with yaml.expr.eval = TRUE
#' @inheritDotParams pkgdown::build_site
#' @return Creates pkgdown site with the yam.expr.eval option set to TRUE
#' @export
#'
#' @examples build_site()
build_site <- function(...) {
  # Temporarily modify the yaml.eval.expr option while building the pkgdown site.
  # This allows R expressions in the _pkgdown.yaml to be evaluated, e.g. Sys.time() in
  # order to capture the build datetime.
  withr::with_options(list(yaml.eval.expr = TRUE), pkgdown::build_site(...))
}

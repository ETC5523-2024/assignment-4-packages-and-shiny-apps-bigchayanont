#' @title The App
#' @description
#' A short description...
#' @returns Nothing
#' @examples
#' \dontrun{
#' run_app()
#' }
#' @export
run_app <- function() {
  app_dir <- system.file("shiny-app", package = "billboardAnalysis")
  shiny::runApp(app_dir, display.mode = "normal")
}

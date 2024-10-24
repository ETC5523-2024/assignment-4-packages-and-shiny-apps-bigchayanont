#' @title Launch Billboard Analysis Shiny App
#' @description
#' This function launches a Shiny application designed to provide interactive visualizations and analysis of Billboard and Spotify data. Users can explore audio features, chart trends, and other insights related to popular music.
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

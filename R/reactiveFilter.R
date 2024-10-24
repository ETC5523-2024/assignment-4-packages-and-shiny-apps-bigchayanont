#' Filter Data Frame Reactively Based on User Input
#'
#' This function filters a data frame reactively based on a specified year range and performer input provided by the user. The year range is used to filter rows based on the `year` column, and the performer input is used to filter rows where the `performer` matches any of the values in the input.
#'
#' @param df A data frame containing at least a `year` column to filter on, and a `performer` column for optional filtering.
#' @param input A list containing reactive inputs from the Shiny app, including:
#'   \itemize{
#'     \item \code{yearRange}: A numeric vector of length 2 representing the start and end years for filtering.
#'     \item \code{performer}: A character vector of performer names to filter by (if specified).
#'   }
#' @return A reactive expression that returns a filtered data frame containing only the rows where:
#'   \itemize{
#'     \item The `year` falls within the specified `yearRange`, and
#'     \item If the `performer` input is not empty, rows where the `performer` matches any of the values in the input.
#'   }
#'
#' @importFrom shiny reactive
#' @importFrom dplyr filter
#' @importFrom stringr str_detect
#'
#' @examples
#' # Assuming 'data' is a data frame with 'year' and 'performer' columns
#'
#' \dontrun{
#'   input$yearRange <- c(2000, 2020)
#'   input$performer <- c("Taylor Swift", "Ed Sheeran")
#'
#'   # Filter 'data' based on year range and performers
#'   filtered_data <- reactiveFilter(data, input)
#'
#'   # To use within a Shiny app:
#'   # output$table <- renderTable({
#'   #   reactiveFilter(data, input)()
#'   # })
#' }
reactiveFilter <- function(df, input) {
  reactive({
    df |>
      filter(
        year >= input$yearRange[1],
        year <= input$yearRange[2],

        # Check if performer input is not empty
        if (length(input$performer) != 0) {
          # Use str_detect with any performer in the input vector
          str_detect(df$performer, paste(input$performer, collapse = "|"))
        } else {
          TRUE
        }
      )
  })
}

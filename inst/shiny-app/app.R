
library(shiny)
library(shinydashboard) # If using shinydashboard
library(tidyverse)
library(plotly)
library(visdat)
library(tidyverse)
library(knitr)
library(reshape2)
library(patchwork)
library(kableExtra)
library(DT)
library(shinyWidgets)

billboard <- billboardAnalysis::billboard

ui <- dashboardPage(
  dashboardHeader(title = "Song Billboard Analysis in the 2010s",
                  # Place the switch inside the header
                  tags$li(
                    class = "dropdown",
                    tags$div(
                      style = "display: flex; align-items: center;width: 140px;height: 47px;right: 10px; margin-right: 20px; margin-top: 3px",
                      "Help mode switch: ",
                      # Switch input
                      switchInput("toggle", label = NULL, inline = TRUE),
                    )
                  )
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Audio Features", tabName = "audio_features", icon = icon("music")),
      menuItem("Long-lasting Tracks", tabName = "long_tracks", icon = icon("clock"))
    )
  ),
  dashboardBody(
    # Custom CSS for valueBox text size
    tags$style(HTML("
      .small-box h3 {
        font-size: 20px;
      }
      .small-box p {
        font-size: 12px;
      }

      /* Responsive adjustments for smaller screens */
      @media (max-width: 768px) {
        .small-box h3 {
          font-size: 16px; /* Smaller size for smaller screens */
        }
        .small-box p {
          font-size: 10px;
        }
      }
    ")),
    fluidRow(
      column(8,
             tabItems(
               tabItem(
                 tabName = "audio_features",
                 column(12,
                        box(
                          #  widget
                          width = NULL,
                          valueBoxOutput("topPerformer"),
                          valueBoxOutput("longestStreakSong"),
                          valueBoxOutput("highestFeat")
                        ),
                 ),
                 column(
                   width = 6,  # Full width for the first plot
                   box(
                     title = "Mean Values of Audio Features Over Years",
                     status = "primary",
                     solidHeader = TRUE,
                     width = NULL,
                     plotlyOutput("audioFeaturePlot"),  # First plot
                     conditionalPanel(
                       condition = "input.toggle == true",
                       helpText("This interactive plot shows the average values of selected audio features across different years. Each line represents an audio feature, such as energy or danceability, and helps to track how these features have evolved over time.")
                     )
                   )
                 ),
                 column(
                   width = 6,  # Half width for the second plot
                   box(
                     title = "Distribution of Audio Features",
                     status = "primary",
                     solidHeader = TRUE,
                     width = NULL,
                     plotOutput("featureDistPlot"),  # Second plot
                      conditionalPanel(
                       condition = "input.toggle == true",
                       helpText("This plot displays the distribution of audio features, showing how frequently different levels of these features occur. It helps to understand the range and concentration of values for each feature.")
                     )
                   )
                 ),
                 column(12,
                        box(
                          title = "Comparison of Audio Features and Popularity by Genre",
                          status = "primary",
                          solidHeader = TRUE,
                          width = NULL,
                          fluidRow(
                            column(6,  # Width for the X-axis input
                                   selectInput("x_var", "Select X-Axis:",
                                               choices = c("energy", "acousticness", "danceability", "speechiness"),
                                               selected = "energy"),

                                   # Help for X-axis Input
                                   conditionalPanel(
                                     condition = "input.toggle == true",
                                     helpText("Use this dropdown to select the audio feature that will be displayed on the X-axis. The options include energy, acousticness, danceability, and speechiness.")
                                   )
                            ),
                            column(6,  # Width for the Y-axis input
                                   selectInput("y_var", "Select Y-Axis:",
                                               choices = c("energy", "acousticness", "danceability", "speechiness"),
                                               selected = "danceability"),

                                   # Help for Y-axis Input
                                   conditionalPanel(
                                     condition = "input.toggle == true",
                                     helpText("Use this dropdown to select the audio feature that will be displayed on the Y-axis. Choose a feature to compare with the one selected for the X-axis.")
                                   )
                            ),
                            column(12,  # Width for the plot
                                   plotlyOutput("scatterPlot"),  # Third plot

                                   # Help for Scatter Plot
                                   conditionalPanel(
                                     condition = "input.toggle == true",
                                     helpText("This scatter plot shows the relationship between the selected audio features on the X and Y axes. Each point represents top 50 genres, and the position on the plot reflects its values for the two features. Use this to compare trends between features across genres.")
                                   )
                            )
                          )
                        )
                 )
               ),
               tabItem(
                 tabName = "long_tracks",
                 title = "Top 5 Longest-Running Tracks",
                 status = "primary",
                 solidHeader = TRUE,
                 DTOutput("longTracksTable"),
                 conditionalPanel(
                   condition = "input.toggle == true",
                   helpText("This data table shows tracks that stayed on the Billboard charts for a long time. It helps identify which features contributed to the longevity of these tracks.")
                 )
               )
             )
      ),
      column(4,
             box(
               width = 12,
               sliderInput("yearRange",
                           "Select Year Range:",
                           min = 2010, max = 2019, value = c(2010, 2019),
                           step = 1, sep = ""
               ),
               conditionalPanel(
                 condition = "input.toggle == true",
                 helpText("Use this slider to select the range of years for filtering the data. Drag the handles to adjust the minimum and maximum years for the analysis.")
               ),
               selectizeInput("performer", "Select Performer:",
                              choices = unique(sort(billboard$performer[year(billboard$week_id) %in% c(2010, 2019)])),
                              multiple = TRUE
               ),
               conditionalPanel(
                 condition = "input.toggle == true",
                 helpText("Use this dropdown to select one or more performers. The available options are dynamically populated based on the dataset. You can search for a performer by typing their name.")
               ),
               selectizeInput("features", "Select Features:",
                              choices = c("energy", "acousticness", "danceability", "speechiness"),
                              multiple = TRUE
               ),
               conditionalPanel(
                 condition = "input.toggle == true",
                 helpText("Use this dropdown to select one or more tracks features. The available options are dynamically populated based on the dataset. You can search for a features by typing their name.")
               )
             ),
             conditionalPanel(
               condition = "input.toggle == true",
               helpText(
                 "Track Features:",
                 br(), br(),  # Add line breaks for spacing
                 strong("Energy:"),
                 " Describe a measure of intensity and activity of the tracks based on perceptual features.",
                 br(),
                 strong("Speechiness:"),
                 " Describe the occurrence of spoken words.",
                 br(),
                 strong("Acousticness:"),
                 " Describe the acousticness of the track.",
                 br(),
                 strong("Instrumentalness:"),
                 " Describe the instrumentalness of the track. The higher the value, the higher the portion of the instrument."
               )
             ),
      ),
    )
  )
)

server <- function(input, output, session) {
  billboard_reactive <- reactiveFilter(billboard, input)
  feature_long_reactive <- reactiveFilter(feature_long, input)

  observe({
    performers_filtered <- billboard$performer[
      year(billboard$week_id) >= input$yearRange[1] &
        year(billboard$week_id) <= input$yearRange[2]
    ]

    # Exclude performers with "Featuring"
    performers_filtered <- performers_filtered[!grepl("Featuring|Duet|&|,|\\+|x|with|\\/", performers_filtered, ignore.case = TRUE)]

    # Update the selectize input with filtered performer names
    updateSelectizeInput(session, "performer",
                         choices = unique(sort(performers_filtered)),
                         server = TRUE
    )
  })

  # Define a color palette for features with light purple
  feature_colors <- c(
    "energy" = "lightblue",           # Choose your preferred color
    "acousticness" = "lightgreen",    # Choose your preferred color
    "danceability" = "orange",    # Choose your preferred color
    "speechiness" = "#EAB8E4"  # Change this to a light purple color
  )

  # Create a modal dialog with a custom message
  showModal(modalDialog(
    title = "Welcome!",
    "For the first timer, if you need any help and finding for definition, please click the button at the top right. Click anywhere outside this box to close this message",
    easyClose = TRUE,  # Allows closing by clicking outside the dialog
    footer = NULL      # No footer buttons
  ))


  output$audioFeaturePlot <- renderPlotly({
    # Reactive data filtering
    data_filtered <- feature_long_reactive() |>
      filter(
        features %in% c("energy", "acousticness", "danceability", "speechiness") &
          (is.null(input$features) | length(input$features) == 0 | features %in% input$features)
      ) |>
      group_by(year, features) |>
      summarize(Mean_value = round(mean(value, na.rm = TRUE),2), .groups = "drop")

    # Create the plot
    p <- ggplot(data_filtered, aes(x = year, y = Mean_value, color = features)) +
      geom_line() +
      labs(x = "Year", y = "Mean Value") +
      scale_color_manual(values = feature_colors) +  # Apply color scale
      scale_x_continuous(breaks = seq(min(data_filtered$year),
                                      max(data_filtered$year),
                                      by = 3)) +  # Ensure year-by-year breaks
      theme_minimal() +
      theme(legend.position = "none")

    # Convert ggplot to plotly
    ggplotly(p)
  })

  output$featureDistPlot <- renderPlot({
    morethan52 <- feature_long_reactive() |>
      filter(is.null(input$features) | length(input$features) == 0 | features %in% input$features) |>
      group_by(song_id, features, value) |>
      summarize(
        weeks_on_chart_max = max(weeks_on_chart, na.rm = TRUE),
        is_more_than_52 = if_else(weeks_on_chart_max >= 52, ">= 52 weeks", "< 52 weeks")
      ) |>
      na.omit() |>
      filter(features %in% c("energy", "acousticness", "danceability", "speechiness"))

    ggplot(morethan52,
           aes(x = is_more_than_52,
               y = value,
               fill = fct_reorder(features, value))) +
      geom_boxplot() +
      facet_wrap(~features, nrow = 1) +
      labs(x = "Is more than 52 weeks", y = "Value") +
      scale_fill_manual(values = feature_colors) +  # Apply fill color scale
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            legend.position = "none",
            axis.title = element_text(size = 14),  # Change axis labels font
            plot.title = element_text(size = 16, hjust = 0.5),  # Change plot title font
            axis.text = element_text(size = 12),  # Change axis text font
            legend.text = element_text(size = 12),  # Change legend text font
            strip.text = element_text(size = 12)  # Change facet label font
      )
  })

output$scatterPlot <- renderPlotly({
    genre_data <- feature_long_reactive() %>%
      #filter(is.null(input$features) | length(input$features) == 0 | features %in% input$features) |>
      filter(features %in% c("energy", "acousticness", "danceability", "speechiness")) %>%
      mutate(extracted_genre = str_extract_all(spotify_genre, "'([^']*)'")) %>%
      unnest(extracted_genre) %>%
      mutate(extracted_genre = gsub("'", "", extracted_genre)) %>%
      group_by(extracted_genre, features) %>%
      summarize(n = n(),
                mean_value = round(mean(value, na.rm = TRUE),2),
                Avg_Popularity = round(mean(spotify_track_popularity, na.rm = TRUE),2),
                .groups = "drop") %>%
      pivot_wider(names_from = features,
                  values_from = mean_value) %>%
      arrange(-n) %>%
      head(50) %>% #getting top 50
      na.omit()

    # Calculate correlation between selected x and y variables
    correlation <- cor(genre_data[[input$x_var]], genre_data[[input$y_var]])

    # Create ggplot with dynamic x and y variables
    p <- ggplot(genre_data, aes_string(x = input$x_var,
                                       y = input$y_var,
                                       group = "extracted_genre",
                                       color = "Avg_Popularity")) +
      geom_point(size = 3, alpha = 0.7) +
      labs(x = input$x_var, y = input$y_var) +
      theme_minimal()

    # Convert ggplot to plotly
    ggplotly(p) %>%
      layout(
        hovermode = "closest",
        annotations = list(
          x = 1.05,  # Position on x-axis (outside the plot area)
          y = 1,     # Position on y-axis (top of the plot)
          xref = "paper", yref = "paper",
          text = paste("Correlation: ", round(correlation, 2)),
          showarrow = FALSE,
          xanchor = "left",
          font = list(size = 12, color = "black")
        )
      )
  })

  output$longTracksTable <- renderDT({
    billboard_reactive() |>
      left_join(audio_features, by = "song_id") |>
      rename("song" = song.x, "performer" = performer.x) |>
      group_by(song, performer, acousticness, danceability, speechiness, energy) |>
      summarize(weeks_on_chart = max(weeks_on_chart), .groups = "drop") |>
      arrange(-weeks_on_chart) |>
      datatable(
        options = list(
          scrollX = TRUE,   # Enable horizontal scrolling
          autoWidth = TRUE # Automatically adjust the column widths
        ))
  })

  # top widget

  output$topPerformer <- renderValueBox({
    topPerformer <- billboard_reactive() |>
      distinct(song_id, performer) |>
      count(performer) |>
      arrange(-n) |>
      head(1)

    valueBox(
      value = HTML(paste(topPerformer$performer, "<br />(", topPerformer$n, "Songs)")),
      "Top Performer",
      icon = icon("music"),
      color = "purple"
    )
  })

  output$longestStreakSong <- renderValueBox({
    longestStreakSong <- billboard_reactive() |>
      count(song) |>
      arrange(-n) |>
      head(1)

    valueBox(
      value = HTML(paste(longestStreakSong$song, "<br />(", longestStreakSong$n, "Weeks)")),
      subtitle = "Longest Streak Song",
      icon = icon("star"),
      color = "yellow"
    )
  })

  output$highestFeat <- renderValueBox({
    highestFeat <- feature_long_reactive() |>
      filter(!features %in% c("key", "loudness", "mode"),
             (is.null(input$features) | length(input$features) == 0 | features %in% input$features)) |>
      group_by(year, features) |>
      summarize(mean_val = mean(value, na.rm = TRUE)) |>
      group_by(features) |>
      summarize(value = mean(mean_val, na.rm = T)) |>
      arrange(-value) |>
      head(1)

    valueBox(
      value = HTML(paste(highestFeat$features, "<br><br/ > ")),
      "Average Highest Feature Values",
      icon = icon("play"),
      color = "blue"
    )
  })
}

shinyApp(ui, server)

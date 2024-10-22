#' Feature Long Dataset
#'
#' This dataset combines Billboard chart data and audio features for songs that were on the chart from 2010 to 2019. The data was sourced from the Billboard charts and audio features dataset, with entries merged based on the `song_id`.
#'
#' The dataset includes only distinct entries for each song, with audio features transformed into a long format for analysis.
#'
#' @docType data
#' @usage data(feature_long)
#' @format A data frame with 522,000 rows and 20 variables:
#' \describe{
#'   \item{url}{The URL for the Billboard chart for the given week.}
#'   \item{week_id}{The date of the Billboard chart for the given week.}
#'   \item{week_position}{The position of the song on the Billboard chart for the given week.}
#'   \item{song_id}{A unique identifier for the song, composed of the song name and performer.}
#'   \item{instance}{The number of times this song has appeared on the chart.}
#'   \item{weeks_on_chart}{The total number of weeks the song has spent on the chart.}
#'   \item{year}{The year the song was on the Billboard chart.}
#'   \item{spotify_genre}{A list of genres associated with the song on Spotify.}
#'   \item{spotify_track_id}{The Spotify ID for the track.}
#'   \item{spotify_track_preview_url}{The URL for the preview of the track on Spotify.}
#'   \item{spotify_track_duration_ms}{The duration of the track in milliseconds.}
#'   \item{spotify_track_explicit}{Indicates if the track contains explicit content (\code{TRUE} or \code{FALSE}).}
#'   \item{spotify_track_album}{The name of the album the track appears on.}
#'   \item{tempo}{The tempo of the track in beats per minute (BPM).}
#'   \item{time_signature}{The time signature of the track (typically 4 for most popular music).}
#'   \item{spotify_track_popularity}{The popularity score of the track on Spotify (0-100).}
#'   \item{song}{The title of the song.}
#'   \item{performer}{The performer of the song.}
#'   \item{features}{Audio features extracted from the song (e.g., danceability, energy, loudness).}
#'   \item{value}{The corresponding values of the audio features.}
#' }
#'
#' @importFrom dplyr group_by filter left_join select distinct
#' @importFrom readr read_csv
#' @importFrom tidyr pivot_longer
#'
#' @source Billboard charts and audio features dataset
#' @examples
#' data(feature_long)
#' head(feature_long)

"feature_long"

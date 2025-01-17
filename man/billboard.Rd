% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/billboard.R
\docType{data}
\name{billboard}
\alias{billboard}
\title{Billboard Dataset}
\format{
A data frame with 327,895 rows and 11 variables:
\describe{
\item{url}{URL to the Billboard chart entry for the song}
\item{week_id}{The date of the chart week}
\item{week_position}{The song's position on the chart for that week}
\item{song}{Title of the song}
\item{performer}{Name of the artist or group performing the song}
\item{song_id}{Unique identifier for the song}
\item{instance}{The instance number of the song's entry on the chart}
\item{previous_week_position}{The song's position on the chart in the previous week}
\item{peak_position}{The highest position reached by the song on the chart}
\item{weeks_on_chart}{The total number of weeks the song has been on the chart}
\item{year}{The year the song was on the chart}
}
}
\source{
\href{https://github.com/rfordatascience/tidytuesday/tree/master/data/2021/2021-09-14}{TidyTuesday Billboard Dataset}
}
\usage{
data(billboard)
}
\description{
This dataset contains information about Billboard Hot 100 chart rankings over time. The data was sourced from the \href{https://github.com/rfordatascience/tidytuesday/tree/master/data/2021/2021-09-14}{TidyTuesday project}.
}
\details{
The dataset was processed to convert \code{week_id} into a date format and extract the year from \code{week_id}.
}
\examples{
data(billboard)
head(billboard)
}
\keyword{datasets}

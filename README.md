
<!-- README.md is generated from README.Rmd. Please edit that file -->

# billboardAnalysis

<!-- badges: start -->
<!-- badges: end -->

The goal of this R package is to create an interactive Shiny dashboard
that lets users explore Billboard and Spotify data from the 2010s,
focusing on trends in audio features like energy, acousticness, and
danceability.

## Installation

You can install the development version of billboardAnalysis with:

``` r
# install.packages("devtools")
devtools::install_github("ETC5523-2024/assignment-4-packages-and-shiny-apps-bigchayanont")
```

## Example

``` r
library(billboardAnalysis)
## basic example code
```

To access to the dataset.

**Billboard Dataset:**

``` r
head(audio_features)
#> # A tibble: 6 × 22
#>   song_id  performer song  spotify_genre spotify_track_id spotify_track_previe…¹
#>   <chr>    <chr>     <chr> <chr>         <chr>            <chr>                 
#> 1 -twisti… Bill Bla… -twi… []            <NA>             <NA>                  
#> 2 ¿Dònde … Augie Ri… ¿Dòn… ['novelty']   <NA>             <NA>                  
#> 3 ......A… Andy Wil… ....… ['adult stan… 3tvqPPpXyIgKrm4… https://p.scdn.co/mp3…
#> 4 ...And … Sandy Ne… ...A… ['rock-and-r… 1fHHq3qHU8wpRKH… <NA>                  
#> 5 ...Baby… Britney … ...B… ['dance pop'… 3MjUtNVVq3C8Fn0… https://p.scdn.co/mp3…
#> 6 ...Read… Taylor S… ...R… ['pop', 'pos… 2yLa0QULdQr0qAI… <NA>                  
#> # ℹ abbreviated name: ¹​spotify_track_preview_url
#> # ℹ 16 more variables: spotify_track_duration_ms <dbl>,
#> #   spotify_track_explicit <lgl>, spotify_track_album <chr>,
#> #   danceability <dbl>, energy <dbl>, key <dbl>, loudness <dbl>, mode <dbl>,
#> #   speechiness <dbl>, acousticness <dbl>, instrumentalness <dbl>,
#> #   liveness <dbl>, valence <dbl>, tempo <dbl>, time_signature <dbl>,
#> #   spotify_track_popularity <dbl>
```

**Song features from Spotify Dataset:**

``` r
head(billboard)
#> # A tibble: 6 × 11
#>   url                  week_id    week_position song  performer song_id instance
#>   <chr>                <date>             <dbl> <chr> <chr>     <chr>      <dbl>
#> 1 http://www.billboar… 1965-07-17            34 Don'… Patty Du… Don't …        1
#> 2 http://www.billboar… 1965-07-24            22 Don'… Patty Du… Don't …        1
#> 3 http://www.billboar… 1965-07-31            14 Don'… Patty Du… Don't …        1
#> 4 http://www.billboar… 1965-08-07            10 Don'… Patty Du… Don't …        1
#> 5 http://www.billboar… 1965-08-14             8 Don'… Patty Du… Don't …        1
#> 6 http://www.billboar… 1965-08-21             8 Don'… Patty Du… Don't …        1
#> # ℹ 4 more variables: previous_week_position <dbl>, peak_position <dbl>,
#> #   weeks_on_chart <dbl>, year <dbl>
```

**A combination of billboard and spotify dataset in long format:**

``` r
head(feature_long)
#> # A tibble: 6 × 20
#>   url             week_id    week_position song_id instance weeks_on_chart  year
#>   <chr>           <date>             <dbl> <chr>      <dbl>          <dbl> <dbl>
#> 1 http://www.bil… 2010-06-26            67 Beauti…        1              1  2010
#> 2 http://www.bil… 2010-06-26            67 Beauti…        1              1  2010
#> 3 http://www.bil… 2010-06-26            67 Beauti…        1              1  2010
#> 4 http://www.bil… 2010-06-26            67 Beauti…        1              1  2010
#> 5 http://www.bil… 2010-06-26            67 Beauti…        1              1  2010
#> 6 http://www.bil… 2010-06-26            67 Beauti…        1              1  2010
#> # ℹ 13 more variables: spotify_genre <chr>, spotify_track_id <chr>,
#> #   spotify_track_preview_url <chr>, spotify_track_duration_ms <dbl>,
#> #   spotify_track_explicit <lgl>, spotify_track_album <chr>, tempo <dbl>,
#> #   time_signature <dbl>, spotify_track_popularity <dbl>, song <chr>,
#> #   performer <chr>, features <chr>, value <dbl>
```

To access to the shiny dashboard

``` r
run_app()
```

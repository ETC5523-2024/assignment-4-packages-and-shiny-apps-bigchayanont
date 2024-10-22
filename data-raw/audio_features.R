audio_features <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-14/audio_features.csv')


audio_features <- audio_features |>
                    group_by(song_id) |>
                    filter(row_number() == 1)  |>
                    ungroup()


usethis::use_data(audio_features, overwrite = TRUE)

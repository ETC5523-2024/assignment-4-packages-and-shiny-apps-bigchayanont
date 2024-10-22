feature_long <- billboardAnalysis::billboard |>
  filter(year(week_id) %in% c(2010:2019)) |>
  left_join(audio_features, by = "song_id") |>
  mutate(song = coalesce(song.x, song.y),
         performer = coalesce(performer.x, performer.y)) |>
  select(-ends_with(".x"),
         -ends_with(".y")) |>
  pivot_longer(cols = c(danceability:valence),
               names_to = "features",
               values_to = "value") |>
  select(-previous_week_position, -peak_position) |>
  distinct()

usethis::use_data(feature_long, overwrite = TRUE)



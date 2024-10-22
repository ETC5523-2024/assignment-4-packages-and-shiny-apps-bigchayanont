## code to prepare `billboard` dataset goes here

billboard <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-14/billboard.csv')

billboard <- billboard |>
  mutate(year = year(mdy(week_id)),
         week_id = mdy(week_id))

usethis::use_data(billboard, overwrite = TRUE)

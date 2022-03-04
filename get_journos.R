library(tidyverse)
library(rvest)
library(rpublons)

# debugonce(get_reviewed_journals)
# get_reviewed_journals(2141272)

pcom <- readRDS("data/revs.rds") %>% 
  mutate(rank = 1:n())

reviews_dat <- pcom %>% 
  split(1:nrow(.)) %>% 
  map_dfr(~{
    print(glue::glue("{.x$rank}.) {.x$reviewer}"))
    reviewed <- get_reviewed_journals(.x$reviewer_id)
    saveRDS(reviewed, glue::glue("data/reviews/{.x$reviewer_id}.rds"))
  })


saveRDS(reviews_dat, file = "data/reviews_dat.rds")

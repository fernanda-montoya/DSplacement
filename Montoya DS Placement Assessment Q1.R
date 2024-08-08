## Fernanda Montoya
## JHU Biostatistics PhD Placement Assessment - Data Science
## 8/6/2024

## Question 1

## call libraries
library(rvest)
library(tidyverse)
library(scales)

## read wiki page
disasters <- read_html("https://en.wikipedia.org/wiki/List_of_natural_disasters_by_death_toll")

## save all wiki tables on page
century_tables <- disasters %>% 
  html_elements(".wikitable") %>% html_table()

## save century specific tables to tibbles
twentieth_century <- century_tables[[2]] %>% as.data.frame()
twentyfirst_century <- century_tables[[3]]

## convert death toll in each table to one number
## following the rules: midpoint if a range is given, bound when upper or lower bound is given

## 20th Century
## remove special characters from string vectors to convert death toll
twentieth_century$deathToll <- gsub(",", "", twentieth_century$`Death toll`)
twentieth_century$deathToll <- gsub("\\+", "", twentieth_century$deathToll)
twentieth_century$deathToll <- gsub("\\[.*", "", twentieth_century$deathToll)
twentieth_century$deathToll <- gsub("-", ",", twentieth_century$deathToll)
twentieth_century$deathToll <- gsub("–", ",", twentieth_century$deathToll)

## calculate midpoints for ranges given
twentieth_century$deathToll <- ifelse(grepl(",", twentieth_century$deathToll),
                                      sapply(strsplit(twentieth_century$deathToll, ","), function(x) round(median(as.numeric(x)))), 
                                      twentieth_century$deathToll) %>% as.numeric()

## convert back to tibble
twentieth_century <- twentieth_century %>% as_tibble()

## 21st Century
## remove special characters from string vectors to convert death toll
twentyfirst_century$deathToll <- gsub(",", "", twentyfirst_century$`Death toll`)
twentyfirst_century$deathToll <- gsub("\\+", "", twentyfirst_century$deathToll)
twentyfirst_century$deathToll <- gsub("\\[.*", "", twentyfirst_century$deathToll)
twentyfirst_century$deathToll <- gsub("\\(.*", "", twentyfirst_century$deathToll)
twentyfirst_century$deathToll <- gsub("-", ",", twentyfirst_century$deathToll)
twentyfirst_century$deathToll <- gsub("–", ",", twentyfirst_century$deathToll)

## calculate midpoints for ranges given
twentyfirst_century$deathToll <- ifelse(grepl(",", twentyfirst_century$deathToll),
                                      sapply(strsplit(twentyfirst_century$deathToll, ","), function(x) round(median(as.numeric(x)))), 
                                      twentyfirst_century$deathToll) %>% as.numeric()

## convert back to tibble
twentyfirst_century <- twentyfirst_century %>% as_tibble()

## bind together both tables
complete_disasters <- rbind(twentieth_century, twentyfirst_century)

## create plot: death toll on y axis, year on x axis, type of disaster by color
complete_disasters %>% ggplot(aes(x = Year, y = deathToll, color = Type)) +
  geom_point() +
  ggtitle("Death Toll of Natural Disasters Throughout the 20th & 21st Centuries") +
  ylab("Death Toll") +
  scale_y_continuous(labels = comma) +
  theme_bw()

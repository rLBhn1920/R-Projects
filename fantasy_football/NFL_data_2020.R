#cleanup and remove existing variables
rm(list=ls())

library(dplyr)
library(tidyverse)

NFL_ASA_2019_2020 <- read.csv("ASA NFL Offense Raw Data.csv")
glimpse(NFL_ASA_2019_2020)
#question: which team had the most rushing attempts
View(NFL_ASA_2019_2020 %>%  
  group_by(team) %>%
  summarise("total" = sum(rush_att)) %>%
  arrange(desc(total)))

#question: which team had the most rushing attempts for running backs
#create a DF with just the RBS
RB_stats  <- NFL_ASA_2019_2020 %>% filter(pos == "RB")
#group the RB's by team and summarize the rushing attempts
View(RB_stats %>% 
  group_by(team) %>% 
  summarise("total" = sum(rush_att)) %>% 
    arrange(desc(total)))

NFL_ASA_2019_2020 %>%  
  group_by(team) %>%
  mutate("total_QB_rush_att" = filter(pos == "QB") , sum(rush_att)) %>%
  arrange(desc(total))

library(dplyr)
library(tidyverse)
library(ggplot2)

all_2020_ff_nums <- read.csv("2020-yahoo-fantasy-player-stats - Sheet1.csv")
NFL_ASA_2019_2020 <- read.csv("ASA NFL Offense Raw Data.csv")
yahoo_fantasy_draft_2020 <- read.csv("2021_yahoo_fantasy_draft.csv.csv")

yahoonums <- all_2020_ff_nums %>% filter(league == "yahoo")
cbs_nums <- all_2020_ff_nums %>% filter(league == "cbs")

#cam newton was on gronkgirl team
yahoonums[151,4] <- c("Gronkgirl")
yahoonums[129,5] <- c("TE")


#summary table
yahoonums %>% 
  group_by(fantasy.team.owner) %>% 
  summarise(total = sum(Fan.Pts))


#create a summary table to review the teams fantasy points totals 
#before dataset was mutated to include a total team points summary
y_teams_summary <- yahoonums %>% 
  group_by(fantasy.team.owner) %>%
  mutate(total = sum(Fan.Pts)) %>%
  summarise(total = sum(Fan.Pts)) %>%
  mutate()

y_qbs <- yahoonums %>% 
  filter(position == "QB") %>% 
  select(Player,team, fantasy.team.owner, Fan.Pts, pass.Yds, pass.TD, fumble.Lost, rush.Att, rush.Yds, rush.TD) %>% 
  arrange(desc(Fan.Pts))

y_teams_QB_summary <- y_qbs %>%
  group_by(fantasy.team.owner) %>%
  mutate(total_QB_pts = sum(Fan.Pts)) %>%
  summarise(total_QB_pts = sum(Fan.Pts)) %>%
  mutate()
  
qbs <- y_qbs %>% 
  group_by(fantasy.team.owner) %>% 
  mutate("sum_QB_FP_byteam_QB_total" = sum(Fan.Pts)) %>% 
  select(fantasy.team.owner, sum_QB_FP_byteam_QB_total, Player, Fan.Pts, pass.Yds, pass.TD) 

y_rbs <- yahoonums %>% 
  filter(position == "RB") %>% 
  select(Player,team, fantasy.team.owner, Fan.Pts, pass.Yds, pass.TD, fumble.Lost, rush.Att, rush.Yds, rush.TD) %>% 
  arrange(desc(Fan.Pts))

  
RBS <- y_rbs %>%
  group_by(fantasy.team.owner) %>% 
  mutate("sum_RB_FP_byteam_RB_total" = sum(Fan.Pts)) %>% 
  select(fantasy.team.owner, sum_RB_FP_byteam_RB_total, Player, Fan.Pts, pass.Yds, pass.TD)

y_teams_RB_summary <- yahoonums %>%
  group_by(fantasy.team.owner) %>%
  filter(position == "RB") %>% 
  mutate(total_RB_pts = sum(Fan.Pts)) %>%
  summarise(total_RB_pts = sum(Fan.Pts)) %>%
  mutate()

y_teams_WR_summary <- yahoonums %>%
  group_by(fantasy.team.owner) %>%
  filter(position == "WR") %>% 
  mutate(total_WR_pts = sum(Fan.Pts)) %>%
  summarise(total_WR_pts = sum(Fan.Pts)) %>%
  mutate()

y_teams_TE_summary <- yahoonums %>%
  group_by(fantasy.team.owner) %>%
  filter(position == "TE") %>% 
  mutate(total_TE_pts = sum(Fan.Pts)) %>%
  summarise(total_TE_pts = sum(Fan.Pts))
  
y_teams_summary <- cbind(y_teams_summary, 
                         y_teams_QB_summary$total_QB_pts, 
                         y_teams_RB_summary$total_RB_pts, 
                         y_teams_WR_summary$total_WR_pts,
                         y_teams_TE_summary$total_TE_pts)


view(summarise(qbs, mean_run = mean(qbs$Fan.Pts))) 

summarise(qbs, mean_run = mean(qbs$Fan.Pts), mean_TD =mean(qbs$pass.TD))

 <- qbs %>% 
  group_by(fantasy.team.owner) %>% 
  summarise(mean(Fan.Pts), mean_TD = mean(pass.TD)) %>%
  arrange(desc(mean_TD))


y_rbs <- yahoonums %>% 
  filter(position == "RB") %>% 
  select(Player,team, fantasy.team.owner, Fan.Pts, rush.Att, rush.Yds, rush.TD, rec.Yds, TAR, rec.TD, fumble.Lost) %>% 
  group_by(fantasy.team.owner) %>% 
  arrange(desc(Fan.Pts)) %>% 
  ungroup()

table(y_rbs$fantasy.team.owner)
temp <- rbs[c(1,4)]

#i holds the max fantasy points
i <- which.min(y_rbs$Fan.Pts)
rbs <- y_rbs$Player

rbs[i]

#using base r rank the values
ranks <- rank(y_rbs$Fan.Pts)

#re_order the values
#ind <- order(ranks, decreasing = TRUE)
ind <- sort(ranks, decreasing = TRUE)

#create a df of the values
my_df <- data.frame(name =rbs[ind], y_rbs$Fan.Pts[ind])

my_df <- y_rbs %>% select(Player, Fan.Pts) %>% arrange(desc(Fan.Pts))


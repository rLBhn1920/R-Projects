#cleanup and remove existing variables
rm(list=ls())

library(dplyr)
library(tidyverse)

draft_2021 <- read.csv("2021_yahoo_fantasy_draft.csv.csv")
wk1_fantasy_stats <- read.csv("fantasy_football/week1-nfl-pla_by_play-pbp-2021.csv")


#team_points_2021 <- 
  
r <- c(110.06, 119.48, 115.04, 90.40, 143.86, 83.6, 95.38, 131.88)
s <- c(121.5, 187.58, 112.56, 101.16, 83.56 , 106.98, 74.50, 153.08)
p <- c(141.10, 105.9, 73.58,115.96 , 144.78, 81.62, 150.42, 102.28)
a <- c(95.58, 98.1, 102.84, 100.7, 168.84, 121.22, 103.00, 188.15)

FF <- rbind(r,s,p,a)

class(FF)
colnames(FF)<- c("WK1", "Wk2", "WK3", "WK4", "WK5", "WK6", "WK7" )
FF
FF <- as.data.frame(FF)

#apply - When you want to apply a function to the rows or columns of a matrix (and higher-dimensional analogues);
#not generally advisable for data frames as it will coerce to a matrix first.


# Two dimensional matrix
M <- matrix(seq(1,16), 4, 4)
M
# apply min to rows
apply(FF, 1, sum)

# apply max to columns
apply(FF, 2, max)

# 3 dimensional array
M <- array( seq(32), dim = c(4,4,2))
M
# Apply sum across each M[*, , ] - i.e Sum across 2nd and 3rd dimension
apply(M, 1, sum)
# Result is one-dimensional

# Apply sum across each M[*, *, ] - i.e Sum across 3rd dimension
apply(FF, c(1,2), sum)
# Result is two-dimensional
FF

lapply(r, FUN = sum)



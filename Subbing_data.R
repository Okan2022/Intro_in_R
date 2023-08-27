library(haven)
library(magrittr)
library(dplyr)

ess <- read.csv("data/ESS10.csv")

input <- names(ess[1:20])


ESS10 <- ess %>% 
  select(input, cntry, agea, trstsci, getnvc19,
         eisced, gndr, lrscale, eisced, dscrgrp, cttresa)

write.csv(ESS10, "data/ESS10_sub.csv", row.names = T)


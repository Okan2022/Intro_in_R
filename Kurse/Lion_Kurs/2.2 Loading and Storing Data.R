#' ---------------------------------------------
#  Introduction to R ---------------------------
#  2.2 Loading and Storing Data ----------------
#' ---------------------------------------------


#' ---------------------------------------------
#  Importing native .RData or .rds files -------
#' ---------------------------------------------
load("your_data.RData")
your_dataNEW <- readRDS("your_data.rds")


#' ---------------------------------------------
#  Absolute vs. Relative File Paths ------------
#' ---------------------------------------------
load("C:/User/user/Desktop/your_data.RData") #or
setwd("C:/User/user/Desktop") 
load("your_data.RData")


#' ---------------------------------------------
#  Importing External File Formats: tidyverse ---
#' ---------------------------------------------
library(haven)
ess10 <- haven::read_dta("./dat/ESS10.dta")
print(ess10[1:15, 1:10])


#' ---------------------------------------------
#  Example of Data Export and Import -----------
#' ---------------------------------------------
library(readr)
# write to csv file
write_csv(ess10, "./dat/ess10.csv")

# re-import data from csv file
ess10 <- read_csv("./dat/ess10.csv")

# inspect
print(ess10[1:10, 1:4])


#' ---------------------------------------------
#  Exporting Data: R's Native Formats ----------
#' ---------------------------------------------
#.RData files
save(your_data, file = "your_data.RData")
load("your_data.RData")

#.rds files
saveRDS(your_data, file = "your_data.rds")
your_dataNEW <- readRDS("your_data.rds")


#' ---------------------------------------------
#  Labelled Data -------------------------------
#' ---------------------------------------------
library(haven)
ess10 <- haven::read_dta("./dat/ESS10.dta")


#' ---------------------------------------------
#  Column labels -------------------------------
#' ---------------------------------------------
library(sjlabelled)
sjlabelled::get_label(ess10$idno)


#' ---------------------------------------------
#  Value labels --------------------------------
#' ---------------------------------------------
table(ess10$happy)

sjlabelled::get_label(ess10$happy)
sjlabelled::get_labels(ess10$happy)


#' ---------------------------------------------
#  Attention: Haven package --------------------
#' ---------------------------------------------
class(ess10$cntry)

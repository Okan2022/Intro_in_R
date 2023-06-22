#' ---------------------------------------------
#  Introduction to R ---------------------------
#  2.4 Subsetting Rows and Variables -----------
#' ---------------------------------------------


#' ---------------------------------------------
#  Data Import --------------------------------
#' ---------------------------------------------
library(haven)
ess10 <- haven::read_dta("./dat/ESS10.dta")
dim(ess10) # check dimensionality of data frame
colnames(ess10)[1:50]

print(ess10[1:15, 1:10])


#' ---------------------------------------------
#  Selecting Variables -------------------------
#' ---------------------------------------------
# base R Option 1
  # subset country and trust variables
  ess10 <- ess10[, c("cntry", "trstprl", "trstlgl", "trstplc", "trstplt", "trstprt", 
                   "trstep", "trstun", "trstsci")]
  ess10 <- ess10[, c(6, 20:27)] # equivalent 
  ess10 <- ess10[, c(6, which(substr(colnames(ess10), 1, 4) == "trst"))] # equivalent

# base R Option 2
  # subset country and trust variables
  ess10 <- subset(x = ess10, 
                subset = TRUE,)

# subset country and trust variables
ess10 <- ess10 %>% 
select(cntry, trstprl, trstlgl, trstplc, trstplt, trstprt, trstep, trstun, trstsci)
#or 
ess10 <- ess10 %>% 
  select(6, 20:27) 

# inspect first rows
head(ess10)                
                


#' ---------------------------------------------
#  Selecting and Renaming in One Step ----------
#' ---------------------------------------------
# subset country and trust variables
ess10 <- ess10 %>% 
  select(country = cntry, 
         trust_parliament = trstprl,
         trust_legalSys = trstlgl, 
         trust_police = trstplc, 
         trust_politicians = trstplt, 
         trust_parties = trstprt,
         trust_EP = trstep, 
         trust_UN = trstun, 
         trust_scientists = trstsci)


#' ---------------------------------------------
#  Excluding Variables -------------------------
#' ---------------------------------------------
# base R
ess10 <- subset(x = ess10, 
                subset = TRUE, 
                select = - c(dweight, pweight))

# tidyverse
ess10 <- ess10 %>% 
  select(-c(dweight, pweight))

# tidyverse, helper functions
ess10 <- ess10 %>% 
  select(-c(ends_with("weight")))


#' ---------------------------------------------
#  Filtering Rows in base R --------------------
#' ---------------------------------------------
#Option 1: Selection with conditions
ess10 <- ess10[which(ess10$cntry == "HU" & ess10$vote == 2),]
dim(ess10)

#Option 2: subset() function
ess10 <- subset(ess10, 
                cntry == "HU" & vote == 2)
dim(ess10)

library(sjlabelled)
get_labels(ess10$vote)


#' ---------------------------------------------
#  The Data Wrangling Pipeline -----------------
#' ---------------------------------------------
library(tidyverse)
ess10 <- haven::read_dta("./dat/ESS10.dta")
ess10 <- ess10 %>% # subset variables
  select(country = cntry, # sociodemographics
         gender = gndr, 
         education_years = eduyrs,
         trust_social = ppltrst, # multidimensional trust
         trust_parliament = trstprl,
         trust_legalSys = trstlgl, 
         trust_police = trstplc, 
         trust_politicians = trstplt, 
         trust_parties = trstprt,
         trust_EP = trstep, 
         trust_UN = trstun, 
         left_right = lrscale, # attitudes
         life_satisfaction = stflife, 
         pol_interest = polintr,
         voted = vote, # turnout 
         party_choice = prtvtefr # party choice
  ) %>% 
  filter(country == "FR") # subset cases (only include France)

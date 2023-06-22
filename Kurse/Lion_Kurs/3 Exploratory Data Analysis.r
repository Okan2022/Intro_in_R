#' ---------------------------------------------
#  Introduction to R ---------------------------
#  3 Exploratory Data Analysis ------------------
#' ---------------------------------------------


#' ---------------------------------------------
#  Prerequisite: Data Wrangling Pipeline -------
#' ---------------------------------------------
#(I/III)
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
  mutate_at(c("country", "gender", "voted", "party_choice"), as.character) %>% # change types
  mutate_at("pol_interest", as.numeric) %>% # change types
  filter(country == "FR") # subset cases (only include France)


#(II/III)
ess10 <- ess10 %>%
  mutate(gender = recode_factor(gender,
                                `1` = "Male",
                                `2` = "Female"),
         voted = recode_factor(voted,
                               `1` = "Yes",
                               `2` = "No",
                               `3` = "Not eligible"),
         party_choice = recode_factor(party_choice,
                                      `1` = "Lutte Ouvriére",
                                      `2` = "Nouv. Parti Anti-Capitaliste",
                                      `3` = "Parti Communiste Français",
                                      `4` = "La France Insoumise",
                                      `5` = "Parti Socialiste",
                                      `6` = "Europe Ecologie Les Verts",
                                      `7` = "La République en Marche",
                                      `8` = "Mouvement Démocrate",
                                      `9` = "Les Républicains",
                                      `10` = "Debout la France",
                                      `11` = "Front National",
                                      `12` = "Other",
                                      `13` = "Blank",
                                      `14` = "Null"))
         

#(III/III)  
ess10 <- ess10 %>% 
  mutate(education_years = na_if(education_years, 114), # set 114 to missing
         pol_interest = (pol_interest * -1) + 5, # invert scale
         life_satisfaction = life_satisfaction + 1 # change scale to [1, 11]
  ) %>% 
  drop_na(trust_politicians, gender, education_years, 
          life_satisfaction, pol_interest) # list-wise deletion of missings


#' ---------------------------------------------
#  Inspecting Labels ---------------------------
#' ---------------------------------------------
table(ess10$left_right)

library(sjlabelled)
get_labels(ess10$left_right)


#' ------------------------------------------------------------
#  Frequency Tables, Table of Proportions, Crosstabulations ---
#' ------------------------------------------------------------
# frequency table
table(ess10$voted)
table(ess10$party_choice)

# table of relative frequencies (proportions)
prop.table(table(ess10$voted))
prop.table(table(ess10$party_choice))

# cross-tab between turnout and life satisfaction
crosstab <- prop.table(table(ess10$voted, ess10$life_satisfaction), 
                       margin = 2 # for column percentages
                       )
# round to two digits
round(crosstab, digits = 2)


#' ---------------------------------------------
#  Get a global look at your data: base R ------
#' ---------------------------------------------
summary(ess10)


#' ---------------------------------------------
#  Get a global look at your data: psych -------
#' ---------------------------------------------
library(psych)
psych::describe(ess10)


#' ---------------------------------------------
#  Get a global look at your data: skimr -------
#' ---------------------------------------------
library(skimr)
skimr::skim_without_charts(ess10)


#' ----------------------------------------------
#  (Quick) Visual Inspection of Distributions ---
#' ----------------------------------------------
library(Hmisc)
Hmisc::hist.data.frame(ess10[,sapply(ess10, is.numeric)], # only apply to numeric variables
                       nclass = 10)


#' ---------------------------------------------
#  Summary Statistics by Group -----------------
#' ---------------------------------------------
library(dplyr)
ss_byparty <- ess10 %>% 
  group_by(party_choice) %>%
  filter(!is.na(trust_politicians)) %>% # exclude missing values
  dplyr::summarize(n = length(trust_politicians), # number of observations
                   min = min(trust_politicians), # minimum value
                   q1 = quantile(trust_politicians, 0.25), # 25% quantile
                   median = median(trust_politicians), # median
                   mean = mean(trust_politicians), # arithmetic mean
                   q3 = quantile(trust_politicians, 0.75), # 75% quantile
                   max = max(trust_politicians), # maximum value
                   sd = sd(trust_politicians) # standard deviation
  )


#' ---------------------------------------------
#  Summary Statistics by Group -----------------
#' ---------------------------------------------
print(ss_byparty[order(ss_byparty$mean),])


#' ---------------------------------------------
#  Relations Between Variables: Correlations ---
#' ---------------------------------------------
round(cor(ess10[, c("education_years", "life_satisfaction", "left_right", "trust_politicians")], 
          method = "pearson",  # calculate Pearson's correlation coefficient
          use = "complete.obs" # list-wise deletion
          ), digits=2)

library(Hmisc)
cormatrix <- Hmisc::rcorr(as.matrix(ess10[, c("education_years", "life_satisfaction", "left_right", "trust_politicians")]))
cormatrix$r

cormatrix$P


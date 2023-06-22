#' ---------------------------------------------
#  Introduction to R ---------------------------
#  2.8 Missing Values --------------------------
#' ---------------------------------------------


#' ---------------------------------------------
#  What Are the Issues With Missing Values? ----
#' ---------------------------------------------
library(haven)
ess10 <- haven::read_dta("./dat/ESS10.dta")
table(ess10$stfgov, useNA = "always")


#' --------------------------------------------------------
#  Getting an Overview of the Extent of Missings: skimr ---
#' --------------------------------------------------------
library(skimr)
skim_tee(ess10$stfgov)


#' ---------------------------------------------
#  Recoding Values to Missings -----------------
#' ---------------------------------------------
library(sjlabelled)
print(ess10$stfgov[1:10])

ess10 <- ess10 %>% 
  mutate(lr_binary = as.numeric(lrscale)) %>% 
  mutate(lr_binary = recode(lr_binary, 
                            `0` = 0,
                            `1` = 0,
                            `2` = 0,
                            `3` = 0,
                            `4` = 0,
                            `5` = 1,
                            `6` = 2,
                            `7` = 2,
                            `8` = 2,
                            `9` = 2,
                            `10` = 2
  ))
  

#' ---------------------------------------------
#  Recoding Values to Missings: dplyr ----------
#' ---------------------------------------------
ess10 <- ess10 %>% 
  mutate(stfgov_adap = na_if(stfgov, 10))

table(ess10$stfgov, useNA = "always")

table(ess10$stfgov_adap, useNA = "always")


#' ---------------------------------------------
#  Recoding Values to Missings: base R ---------
#' ---------------------------------------------
ess10$voted <- NA
ess10$voted[ess10$vote == 1] <- "Yes"
ess10$voted[ess10$vote == 2] <- "No"
ess10$voted[ess10$vote == 3] <- "Not eligible"
ess10$voted <- as.factor(ess10$voted)

ess10$stfgov_adap2 <- ess10$stfgov
ess10$stfgov_adap2[ess10$stfgov == 10] <- NA

table(ess10$stfgov_adap, useNA = "always")

table(ess10$stfgov_adap2, useNA = "always")


#' -----------------------------------------------------
#  Computations Based on Vectors With Missing Values ---
#' -----------------------------------------------------
mean(ess10$stfgov)

sd(ess10$stfgov)

mean(ess10$stfgov, na.rm = T)

sd(ess10$stfgov, na.rm = T)


#' ---------------------------------------------
#  Listwise Deletion: dplyr --------------------
#' ---------------------------------------------
dim(ess10)

ess10 <- ess10 %>% 
  drop_na(gndr, stfgov, ppltrst)

dim(ess10)


#' ---------------------------------------------
#  Listwise Deletion: base R -------------------
#' ---------------------------------------------
ess10 <- ess10[complete.cases(ess10[,c("gndr", "stfgov", "ppltrst")]),]
# or 
ess10 <- na.omit(ess10)
dim(ess10)


#' ---------------------------------------------
#  Data Wrangling Pipeline ---------------------
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
                                      `1`  = "Lutte Ouvriére",
                                      `2`  = "Nouv. Parti Anti-Capitaliste",
                                      `3`  = "Parti Communiste Français",
                                      `4`  = "La France Insoumise",
                                      `5`  = "Parti Socialiste",
                                      `6`  = "Europe Ecologie Les Verts",
                                      `7`  = "La République en Marche",
                                      `8`  = "Mouvement Démocrate",
                                      `9`  = "Les Républicains",
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


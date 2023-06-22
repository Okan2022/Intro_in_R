#----------------------------
# 2.5 Transforming Variables
# ---------------------------

# Data Import 
library(haven)
ess10 <- haven::read_dta("./dat/ESS10.dta")
dim(ess10) # check dimensionality of data frame

print(ess10[1:10, 1:10])

# Class Conversions: Example base R
var_char <- as.character(runif(5, min = 0, max = 10))
print(var_char)

var_numeric <- as.numeric(var_char)
print(var_numeric)

class(ess10$gndr)
table(ess10$gndr)

ess10$gndr_char <- as.character(ess10$gndr) # transform to character
class(ess10$gndr_char)
table(ess10$gndr_char)

ess10$gndr_fac <- as.factor(ess10$gndr)
class(ess10$gndr_fac)
table(ess10$gndr_fac)

# Class Conversions: Example dplyr
table(ess10$gndr)
class(ess10$gndr)

table(ess10$lrscale)
class(ess10$lrscale)

ess10 <- ess10 %>%
  mutate(gndr_char = as.character(gndr),
         lrscale_num = as.numeric(lrscale))
table(ess10$gndr_char)
class(ess10$gndr_char)

ess10 <- ess10 %>%
  mutate(gndr_char = as.character(gndr),
         lrscale_num = as.numeric(lrscale))
table(ess10$lrscale_num)
class(ess10$lrscale_num)

#Simple Recodings
ess10$female <- ess10$gndr - 1
table(ess10$female)

ess10$female <- as.factor(ess10$female)
ess10$female <- ifelse(ess10$female == "1",
                       "Female", "Male")
table(ess10$female)

#mutate() for Numeric Variables - Transformation of Scale
table(ess10$polintr)
ess10 <- ess10 %>%
  mutate(pol_interest = polintr - 1)
table(ess10$pol_interest)

#dplyr::mutate() - Reverse Scale of Numeric Variable
ess10 <- ess10 %>%
  mutate(pol_interest_res = (pol_interest * -1) + 3)
table(ess10$pol_interest)

table(ess10$pol_interest_res)

#dplyr::mutate() - Recoding
table(ess10$lrscale)

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
  )
  )

table(ess10$lr_binary, ess10$lrscale)


ess10 <- ess10 %>% 
  mutate(gender = as.factor(gndr), 
         voted = as.factor(vote), 
         party_choice = as.factor(prtvtefr)) %>% 
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
                                      `14` = "Null"
         )
  )

#Recoding in base R
ess10$gender <- NA
ess10$gender[ess10$gndr == 1] <- "Male"
ess10$gender[ess10$gndr == 2] <- "Female"
ess10$gender <- as.factor(ess10$gender)

ess10$voted <- NA
ess10$voted[ess10$vote == 1] <- "Yes"
ess10$voted[ess10$vote == 2] <- "No"
ess10$voted[ess10$vote == 3] <- "Not eligible"
ess10$voted <- as.factor(ess10$voted)

ess10$party_choice <- NA
ess10$party_choice[ess10$prtvtefr == 1] <- "Lutte Ouvriére"
ess10$party_choice[ess10$prtvtefr == 2] <- "Nouv. Parti Anti-Capitaliste"
ess10$party_choice[ess10$prtvtefr == 3] <- "Parti Communiste Français"
ess10$party_choice[ess10$prtvtefr == 4] <- "La France Insoumise"
ess10$party_choice[ess10$prtvtefr == 5] <- "Parti Socialiste"
ess10$party_choice[ess10$prtvtefr == 6] <- "Europe Ecologie Les Verts"
ess10$party_choice[ess10$prtvtefr == 7] <- "La République en Marche"
ess10$party_choice[ess10$prtvtefr == 8] <- "Mouvement Démocrate"
ess10$party_choice[ess10$prtvtefr == 9] <- "Les Républicains"
ess10$party_choice[ess10$prtvtefr == 10] <- "Debout la France"
ess10$party_choice[ess10$prtvtefr == 11] <- "Front National"
ess10$party_choice[ess10$prtvtefr == 12] <- "Other"
ess10$party_choice[ess10$prtvtefr == 13] <- "Blank"
ess10$party_choice[ess10$prtvtefr == 14] <- "Null"
ess10$party_choice <- as.factor(ess10$party_choice) 


#The Data Wrangling Pipeline 
#part 2 
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
  mutate_at(c("country", "gender", "voted", "party_choice"), as.character) %>%
  mutate_at("pol_interest", as.numeric) %>%
  filter(country == "FR") # subset cases (only include France)

#part 2 
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

# part 3 
ess10 <- ess10 %>%
  mutate(pol_interest = (pol_interest * -1) + 5, # invert scale
         life_satisfaction = life_satisfaction + 1 # change scale to [1, 11]
  )

         
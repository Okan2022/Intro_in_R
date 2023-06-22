#' ---------------------------------------------
#  Introduction to R ---------------------------
#  6.1 For-loops -------------------------------
#' ---------------------------------------------

#' ---------------------------------------------
#  For-loop: Explanation -----------------------
#' ---------------------------------------------
for (house in c(1, 3, 28, 105)) { 
  print(stringr::str_c("This is the ", house, "th Iteration")) 
}


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
                                      `12` = "Other",))
                                      
#(III/III)
ess10 <- ess10 %>% 
  mutate(education_years = na_if(education_years, 114), # set 114 to missing
         pol_interest = (pol_interest * -1) + 5, # invert scale
         life_satisfaction = life_satisfaction + 1 # change scale to [1, 11]
  ) %>% 
  drop_na(trust_politicians, gender, education_years, 
          life_satisfaction, pol_interest) # list-wise deletion of missings  


#' -----------------------------------------------
#  For-loop: Example From Statistical Modeling ---
#' -----------------------------------------------
m1 <- lm(trust_politicians ~ gender + education_years + life_satisfaction + pol_interest, 
         data = ess10)

col_ids <- stringr::str_detect(colnames(ess10), "trust")
colnames(ess10)[col_ids]

m1 <- lm(trust_social ~ gender + education_years + life_satisfaction + pol_interest, 
         data = ess10)
m2 <- lm(trust_parliament ~ gender + education_years + life_satisfaction + pol_interest, 
         data = ess10)
m3 <- lm(trust_legalSys ~ gender + education_years + life_satisfaction + pol_interest, 
         data = ess10)
m4 <- lm(trust_police ~ gender + education_years + life_satisfaction + pol_interest, 
         data = ess10)
m5 <- lm(trust_politicians ~ gender + education_years + life_satisfaction + pol_interest, 
         data = ess10)
m6 <- lm(trust_parties ~ gender + education_years + life_satisfaction + pol_interest, 
         data = ess10)
m7 <- lm(trust_EP ~ gender + education_years + life_satisfaction + pol_interest, 
         data = ess10)
m8 <- lm(trust_UN ~ gender + education_years + life_satisfaction + pol_interest, 
         data = ess10)

col_ids <- stringr::str_detect(colnames(ess10), "trust")
y_vars <- colnames(ess10)[col_ids]
print(y_vars)

model_list <- list()
for (y_variable in y_vars) {
  model_list[[y_variable]] <- 
    lm(as.formula(stringr::str_c(y_variable, 
                                 "~ gender + education_years + life_satisfaction + pol_interest")), 
       data = ess10)
}


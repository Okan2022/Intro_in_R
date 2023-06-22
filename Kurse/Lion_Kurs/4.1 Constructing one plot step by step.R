#' -----------------------------------------
# Prerequisite: Data Wrangling Pipeline ----
#' -----------------------------------------
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
                                      `14` = "Null")
  )


ess10 <- ess10 %>% 
  mutate(education_years = na_if(education_years, 114), # set 114 to missing
         pol_interest = (pol_interest * -1) + 5, # invert scale
         life_satisfaction = life_satisfaction + 1 # change scale to [1, 11]
  ) %>% 
  drop_na(trust_politicians, gender, education_years, 
          life_satisfaction, pol_interest) # list-wise deletion of missings


#' ------------------------------------
# Our first plot: A Histogram ---------
#' ------------------------------------

table(ess10$left_right)


#' ---------------------------------------
# Constructing one plot step-by-step -----
#' ---------------------------------------

ggplot(data = ess10, 
       aes(x = left_right)) +
  geom_histogram(
    bins = 11, color = "white", 
    fill = "lightblue") + 
  scale_x_continuous(
    breaks = seq(0,10,1), 
    labels = c("Left", seq(1,9,1), "Right")) +
  labs(x = "Position on Left-Right Scale",
       y = "Frequency", 
       title = "Left-Right Political Placement in France, n=1,713") +
  theme_bw(base_size=15) +
  theme(panel.border = element_blank())


#' ------------------------------------
# A note on facets --------------------
#' ------------------------------------

ess10 <- haven::read_dta("./dat/ESS10.dta")
ess10 <- ess10 %>% # subset variables
  select(country = cntry, # sociodemographics
         left_right = lrscale, # attitudes
  ) %>% 
  mutate_at(c("country"), as.character)

p <- ggplot(data = ess10, 
            aes(x = left_right)) +
  geom_histogram(bins = 11, color = "white", 
                 fill = "lightblue") +
  scale_x_continuous(
    breaks = seq(0,10,1), 
    labels = c("Left", seq(1,9,1), "Right")) +
  labs(x = "Position on Left-Right Scale",
       y = "Frequency", 
       title = "Left-Right Political Placement Across Europe") +
  theme_bw(base_size=15) +
  theme(panel.border = element_blank())

p + facet_wrap(~ country, ncol = 5)



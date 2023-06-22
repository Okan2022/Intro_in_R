#' ---------------------------------------------
#  Introduction to R ---------------------------
#  4.2 Plotting Anything -----------------------
#' ---------------------------------------------


#' ---------------------------------------------
#  Our first plot: A Histogram -----------------
#' ---------------------------------------------
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


#' ---------------------------------------------
#  Steps for Plotting: Summary -----------------
#' ---------------------------------------------
ggplot(data = ess10, 
       aes(x = left_right)) +
  geom_histogram()


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
# (III/III)
ess10 <- ess10 %>% 
  mutate(education_years = na_if(education_years, 114), # set 114 to missing
         pol_interest = (pol_interest * -1) + 5, # invert scale
         life_satisfaction = life_satisfaction + 1 # change scale to [1, 11]
  ) %>% 
  drop_na(trust_politicians, gender, education_years, 
          life_satisfaction, pol_interest) # list-wise deletion of missings


#' ---------------------------------------------
#  Constructing a Scatterplot ------------------
#' ---------------------------------------------
table(ess10$life_satisfaction)

table(ess10$trust_politicians)

cor(ess10$life_satisfaction, ess10$trust_politicians)

ggplot(data = ess10, 
       aes(x = life_satisfaction, 
           y = trust_politicians)) +
  geom_point(col = "lightblue") +
  geom_smooth(method = "lm", col = "black") +
  scale_x_continuous(breaks = seq(1,11,1)) +
  scale_y_continuous(breaks = seq(0,10,1)) +
  labs(x = "Life Satisfaction", 
       y = "Trust in Politicians") + 
  theme_classic(base_size = 15)


ess10$life_satisfaction2 <- 
  jitter(ess10$life_satisfaction, 3)
ess10$trust_politicians2 <- 
  jitter(ess10$trust_politicians, 3)

ggplot(data = ess10, 
       aes(x = life_satisfaction2, 
           y = trust_politicians2)) +
  geom_point(col = "lightblue") +
  geom_smooth(method = "lm", col = "black") +
  scale_x_continuous(breaks = seq(1,11,1)) +
  scale_y_continuous(breaks = seq(0,10,1)) +
  labs(x = "Life Satisfaction", 
       y = "Trust in Politicians") + 
  theme_classic(base_size = 15)

#' ---------------------------------------------
#  Constructing a Scatterplot ------------------
#' ---------------------------------------------
ess10 <- ess10 %>%  
  mutate(pol_interestBIN = recode_factor(
    pol_interest, 
    `1` = 0, 
    `2` = 0, 
    `3` = 1, 
    `4` = 1)
  )
table(ess10$pol_interest, ess10$pol_interestBIN)

ggplot(data = ess10, 
       aes(x = life_satisfaction2, 
           y = trust_politicians2,
           color = pol_interestBIN)) + 
  geom_point() + 
  geom_smooth(method = "lm") +
  scale_x_continuous(breaks = seq(1,11,1)) +
  scale_y_continuous(breaks = seq(0,10,1)) +
  labs(x = "Life Satisfaction", 
       y = "Trust in Politicians") + 
  theme_classic(base_size = 15) +
  labs(color="Political Interest") + 
  scale_color_discrete(
    labels = c("Low", "High")) +
  theme(legend.position = "top")



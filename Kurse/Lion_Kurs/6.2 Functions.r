#  Introduction to R ---------------------------
#  6.2 Functions -------------------------------
#' ---------------------------------------------


#' ---------------------------------------------
#  Functions: Motivation -----------------------
#' ---------------------------------------------
x <- seq(1, 20, 2)
print(x)

mean(x)


#' ---------------------------------------------
#  Functions: Explanation ----------------------
#' ---------------------------------------------
#structure: function_name <- function(input) { output <- perform action with input  return(output)}

arith_mean <- function(vec) {
  result <- sum(vec) / length(vec)
  return(result)
}

print(x)

arith_mean(x)

mean(x) 


#' ---------------------------------------------
#  Prerequisite: Data Wrangling Pipeline -------
#' ---------------------------------------------
#(I/III)
library(tidyverse)
ess10 <- haven::read_dta("./dat/ESS10.dta")
ess10 <- ess10 %>% # subset variables
  select(country = cntry, # sociodemographics
         age = agea,
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
          life_satisfaction, pol_interest, age) # list-wise deletion of missings


#' ---------------------------------------------
#  Functions: Real Life Example ----------------
#' ---------------------------------------------
m4 <- 
  lm(trust_politicians ~ poly(age,4) + gender + education_years + life_satisfaction + pol_interest, 
     data = ess10)

#structure: poly_spec <- function(data, y, x, covariate, n) {}
data <- ess10
y <- "trust_politicians"
x <- "gender + education_years + life_satisfaction + pol_interest"
covariate <- "age"
n <- 4
poly_spec <- function(data, y, x, covariate, n) {
  # prepare empty output table
  output <- matrix(data = NA, 
                   nrow = n, 
                   ncol = 2)
  colnames(output) <- c("Polynomial degree", "AIC")
  output[,"Polynomial degree"] <- 1:n
  # evaluate models
  library(stringr)
  for (degree in 1:n) {
    model <- 
      lm(as.formula(str_c(y, "~", x, "+ poly(", covariate, ",", degree, ")")), 
         data = data)
    output[degree, "AIC"] <- AIC(model)
  }}
  return(output)
  
poly_spec(data = ess10, 
            y = "trust_politicians", 
            x = "gender + education_years + life_satisfaction + pol_interest", 
            covariate = "age", 
            n = 4)

m2 <- 
  lm(trust_politicians ~ poly(age,2) + gender + education_years + life_satisfaction + pol_interest, 
     data = ess10)

summary(m2) 
  

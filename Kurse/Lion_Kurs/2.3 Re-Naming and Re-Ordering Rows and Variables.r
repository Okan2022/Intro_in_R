#' ----------------------------------------------------
#  Introduction to R ----------------------------------
#  2.3 Re-Naming and Re-Ordering Rows and Variables ---
#' ----------------------------------------------------


#' ---------------------------------------------
#  Data Import ---------------------------------
#' ---------------------------------------------
library(haven)
ess10 <- haven::read_dta("./dat/ESS10.dta")

dim(ess10) # check dimensionality of data frame
colnames(ess10)[1:50]

print(ess10[1:15, 1:10])


#' ---------------------------------------------
#  Renaming Variables --------------------------
#' ---------------------------------------------
names(ess10)[20:27]
colnames(ess10)[20:27] # equivalent

#base R: 
  names(ess10)[20:27] <- c("trst_parliament", "trst_legalsys", "trst_police", "trst_politicians", 
                         "trst_parties", "trst_EP", "trst_UN", "trst_scientists")
  colnames(ess10)[20:27] <- c("trst_parliament", "trst_legalsys", "trst_police", "trst_politicians", 
                            "trst_parties", "trst_EP", "trst_UN", "trst_scientists") # equivalent
  
#dplyr: 
  ess10 <- ess10 %>% 
  rename(trst_parliament = trstprl, 
         trst_legalsys = trstlgl, 
         trst_police = trstplc, 
         trst_politicians = trstplt)

  
#' ---------------------------------------------
#  Relocating variables ------------------------
#' ---------------------------------------------
which(names(ess10) == "ppltrst") # position of variable ppltrust
 
which(substr(names(ess10), 1, 4) == "trst") # position of other trust variables


#' ---------------------------------------------
#  Relocating variables ------------------------
#' ---------------------------------------------
ess10 <- ess10 %>% 
  relocate(ppltrst, .after = trstsci)
  relocate(ppltrst, .before = trstprl)

names(ess10)[19:27]


#' ---------------------------------------------
#  Re-Arranging Order of Rows - base R ---------
#' ---------------------------------------------
# only sort by trust in police
ess10 <- ess10[order(ess10$trstplc),] 
print(ess10[1:10, c("trstplc", "agea", "trstprt", "trstep", "trstun", "trstsci", "vote")])

# sort by trust in police and age
ess10 <- ess10[order(ess10$trstplc, ess10$agea),] 
print(ess10[1:10, c("trstplc", "agea", "trstprt", "trstep", "trstun", "trstsci", "vote")])


# alternatively: 
# only sort by trust in police
ess10 <- ess10 %>% 
  arrange(trstplc) 
print(ess10[1:10, c("trstplc", "agea", "trstprt", "trstep", "trstun", "trstsci", "vote")])

# only sort by trust in police and age
ess10 <- ess10 %>% 
  arrange(trstplc, agea) 
print(ess10[1:10, c("trstplc", "agea", "trstprt", "trstep", "trstun", "trstsci", "vote")])


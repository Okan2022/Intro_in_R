#' ---------------------------------------------
#  Introduction to R ---------------------------
#  2.6 Transforming Variables ------------------
#' ---------------------------------------------


#' ---------------------------------------------
#  Data Import ---------------------------------
#' ---------------------------------------------
library(haven)
ess10 <- haven::read_dta("./dat/ESS10.dta")
dim(ess10) # check dimensionality of data frame

print(ess10[1:10, 1:10])


#' ---------------------------------------------
#  dplyr::mutate() -----------------------------
#' ---------------------------------------------
dim(ess10)

ess10 <- ess10 %>% 
  mutate(trust_index = trstprl + trstlgl + trstplc + trstplt + trstprt + trstep + trstun)
table(ess10$trust_index)


#' ---------------------------------------------
#  dplyr::summarize() --------------------------
#' ---------------------------------------------
new_df <- ess10 %>% 
  summarize(tindex_mean = mean(trust_index, na.rm = T),
            tindex_median = median(trust_index, na.rm = T),
            tindex_min = min(trust_index, na.rm = T), 
            tindex_max = max(trust_index, na.rm = T), 
            tindex_sd = sd(trust_index, na.rm = T)
  )

print(new_df)

dim(new_df)


#' -----------------------------------------------------
#  Combine dplyr::summarize() with dplyr::group_by() ---
#' -----------------------------------------------------
new_df <- ess10 %>% 
  group_by(vote) %>%
  summarize(tindex_mean = mean(trust_index, na.rm = T),
            tindex_median = median(trust_index, na.rm = T),
            tindex_min = min(trust_index, na.rm = T), 
            tindex_max = max(trust_index, na.rm = T), 
            tindex_sd = sd(trust_index, na.rm = T)
  )
print(new_df)


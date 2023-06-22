#' ---------------------------------------------
#  Introduction to R ---------------------------
#  2.1 Data Wrangling - Tidyverse Philosophy ---
#' ---------------------------------------------


#' ---------------------------------------------
#  Tidyverse -----------------------------------
#' ---------------------------------------------
install.packages("tidyverse") #Installs the complete tidyverse  


#' ---------------------------------------------
#  dplyr - Structur of a Function Call (I/II) --
#' ---------------------------------------------
library(readstata13)
ess10 <- read.dta13("dat/ess10.dta")

glimpse(ess10)

filter(
  ess10, 
  cntry == "HU"
)

#' ---------------------------------------------
#  Tidyverse - Pipe Operator %>%  --------------
#' ---------------------------------------------
ess10 %>% 
  filter(cntry == "HU") %>% 
  select(dweight, pweight)

# generic examples:

#f(x) 
#sqrt(x)
#log(x)

#x %>% f() 
#x %>% select(x_1)
#x %>% 
#  f1() %>% 
#  f2() %>% 
#  f3()

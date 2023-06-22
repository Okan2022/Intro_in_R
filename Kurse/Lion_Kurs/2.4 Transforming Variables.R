#' ---------------------------------------------
#  Introduction to R ---------------------------
#  2.4 Transforming Variables ------------------
#' ---------------------------------------------


#' ---------------------------------------------
#  Data Import --------------------------------
#' ---------------------------------------------
library(haven)
ess10 <- haven::read_dta("./dat/ESS10.dta")
dim(ess10) # check dimensionality of data frame

print(ess10[1:15, 1:10])


#' ---------------------------------------------
#  Creating New Variables ----------------------
#' ---------------------------------------------
ess10$wave <- 10
unique(ess10$wave)

table(ess10$wave)

table(ess10$gndr)

ess10$gndr <- ess10$gndr - 1 #recode variable 

ess10$gender <- ess10$gndr - 1 #generate variable 
table(ess10$gender)


#' ---------------------------------------------
#  Standardization (Z-Scores) ------------------
#' ---------------------------------------------
# summarize raw variable
summary(ess10$eduyrs)

# generate standardized version
ess10$eduyrs_stand <- (ess10$eduyrs - mean(ess10$eduyrs, na.rm=T)) / sd(ess10$eduyrs, na.rm=T)
sd(ess10$eduyrs_stand, na.rm=T)


#' ---------------------------------------------
#  Changing the Data Type ----------------------
#' ---------------------------------------------
library(sjlabelled)
table(ess10$gndr)

sjlabelled::get_labels(ess10$gndr)

# transform to character
ess10$gndr_char <- as.character(ess10$gndr) 
ess10$gndr_char <- ifelse(ess10$gndr_char == "2", # recode
                          "Female", "Male")
table(ess10$gndr_char)

# transform to factor variable 
ess10$gndr_fac <- as.factor(ess10$gndr)
ess10$gndr_fac <- ifelse(ess10$gndr_fac == "2", 
                         "Female", "Male")
table(ess10$gndr_fac)

# generate character variable storing numeric information
var_char <- as.character(runif(5, min = 0, max = 10))
print(var_char)

# convert into numeric 
var_numeric <- as.numeric(var_char)
print(var_numeric)
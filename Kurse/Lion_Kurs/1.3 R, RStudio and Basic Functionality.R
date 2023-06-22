#' ---------------------------------------------
#  Introduction to R ---------------------------
#  1.3 R, RStudio and Basic Functionality ------
#' ---------------------------------------------


#' ---------------------------------------------
#  Basic R Functionality: Calculations --------- 
#' ---------------------------------------------
2+2
7^2
1/4


#' ---------------------------------------------
#  Basic R Functionality: Comments ------------- 
#' ---------------------------------------------
# This is a comment 
5*30
print("Hello World") # This is an in-line comment


#' ---------------------------------------------
#  Basic R Functionality: Functions ------------ 
#' ---------------------------------------------
# calculate the square root of a number
sqrt(16)
help(sqrt)
?sqrt


#' ---------------------------------------------
#  Basic R Functionality: Arithmetic Functions - 
#' ---------------------------------------------
log()
exp()
sqrt()
sin()
cos()
tan()
names()
colnames()
rownames()
length()
nrow()
ncol()
dim()
nchar()
which()
which.min()
which.max()
min()
max()
sum()
round()
ceiling()
floor()
c() # all of these functions will show an error, because nothing is specified 


#' ---------------------------------------------
#  Basic R Functionality: Objects -------------- 
#' ---------------------------------------------
x <- 5 # a numerical object
chr <- "Exemplary character string."

y <- sqrt(16)
y = sqrt(16) # identical

y
print(y) # identical


#' ---------------------------------------------
#  R Packages ---------------------------------- 
#' ---------------------------------------------
install.packages("stringr") # installing package, only needs to be done once
library(stringr) # loading package, required in every R session



#' ---------------------------------------------
#  An Exemplary Package: stringr --------------- 
#' ---------------------------------------------
help(stringr)
model_string <- str_c("Model ", 1:4)
print(model_string)


#' ---------------------------------------------
#  Tidyverse - A Universe of R packages -------- 
#' ---------------------------------------------
install.packages("tidyverse")

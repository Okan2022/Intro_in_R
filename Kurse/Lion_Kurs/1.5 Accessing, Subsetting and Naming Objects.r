#' ------------------------------------------------
#  Introduction to R ------------------------------
#  1.5 Accessing, Subsetting and Naming Objects ---
#' ------------------------------------------------


#' ---------------------------------------------
#  Accessing and Subsetting Objects ------------ 
#' ---------------------------------------------
character_vector <- c("Austria", "England", "Brazil", "Germany")
character_vector[1] # accessing the first element
character_vector[length(character_vector)] # accessing the last element


#' ---------------------------------------------
#  Accessing and Subsetting Matrices ----------- 
#' ---------------------------------------------
#general logic: matrix_object[specific_row, specific_column]   

matrix_example <- matrix(1:20, nrow = 4, ncol = 5)
print(matrix_example)

matrix_example[1,1] # 1st row, 1st column
matrix_example[2,] # 2nd row
matrix_example[,4] # 4th column
matrix_example[1:2, 3:4] # rows 1 and 2, columns 3 and 4


#' ---------------------------------------------
#  Accessing and Subsetting Data Frames -------- 
#' ---------------------------------------------
df_example <-
  data.frame(
    country = c("Austria", "England", "Brazil", "Germany"), 
    capital = c("Vienna", "London", "Brasília", "Berlin"), 
    elo = c(1761, 1938, 2166, 1988)
  )

df_example$country

df_example["country"]

df_example[1]


#' ---------------------------------------------
#  Accessing and Subsetting Lists  ------------- 
#' ---------------------------------------------
list_example

list_example[2] # returns a sublist of list_example, which is a list itself

x <- list_example[2] 
class(x) # check whether it's a list

list_example[[2]] # returns the object that is stored in the second sublist
class(x) # check whether it's a vector
is.vector(x)


#' ---------------------------------------------
#  Combining [[ ]] and [ ] --------------------- 
#' ---------------------------------------------
list_example[[2]][1]


#' ---------------------------------------------
#  Naming Objects ------------------------------ 
#' ---------------------------------------------
numeric_vector <- c(1, 2, 3, 4, 5)
names(numeric_vector)

names(numeric_vector) <- c("Name A", "Name B", "Name C", "Name D", "Name E")
numeric_vector

names(list_example) <- c("numeric_vector", "character_vector", "logical_vector", "matrix", "df")
names(list_example)

names(df_example) <- c("Var 1", "Var 2", "Var 3")
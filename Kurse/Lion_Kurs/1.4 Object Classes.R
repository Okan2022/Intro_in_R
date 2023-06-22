#' ---------------------------------------------
#  Introduction to R ---------------------------
#  1.4 Object Classes --------------------------
#' ---------------------------------------------


#' ---------------------------------------------
#  Numeric Values ------------------------------ 
#' ---------------------------------------------
x1 <- 5L
typeof(x1)

x2 <- 5.25
typeof(x2)

is.numeric(x1)


#' ---------------------------------------------
#  Character Strings --------------------------- 
#' ---------------------------------------------
string1 <- "University of Mannheim" # example of a string
class(string1)

string2 <- "5" # still a string, not an integer as we use quotation marks
class(string2)

string3 <- "TRUE" # still a string
class(string3)


#' ---------------------------------------------
#  Factors ------------------------------------- 
#' ---------------------------------------------
parties <- factor(levels=c("SPD", "CDU", "Greens", "FDP", "AfD", "Left")) # create an empty factor 
parties[1:3] <- c("SPD", "Greens", "FDP") # fill with three values
print(parties)

parties[4] <- "CSU" # add invalid value


#' ---------------------------------------------
#  Boolean Values ------------------------------ 
#' ---------------------------------------------
(7 - 3) > 1

bool <- 2 > 1 
print(bool)

#' ---------------------------------------------
#  Data Format: Vector ------------------------- 
#' ---------------------------------------------
numeric_vector <- c(1, 2, 3, 4, 5)
print(numeric_vector)

character_vector <- c("Austria", "England", "Brazil", "Germany")
print(character_vector)

logical_vector <- c(TRUE, FALSE, FALSE, TRUE)
print(logical_vector)


#' ---------------------------------------------
#  Data Format: Matrix ------------------------- 
#' ---------------------------------------------
matrix_example <- matrix(1:20, nrow = 4, ncol = 5) # create numeric matrix
print(matrix_example)

dim(matrix_example)


#' ---------------------------------------------
#  Data Format: Data Frame --------------------- 
#' ---------------------------------------------
df_example <-
  data.frame(
    country = c("Austria", "England", "Brazil", "Germany"), 
    capital = c("Vienna", "London", "Brasília", "Berlin"), 
    elo = c(1761, 1938, 2166, 1988)
  )

print(df_example)
dim(df_example) # dimensions of the data frame
nrow(df_example) # number of observations
ncol(df_example) # number of variables


#' ---------------------------------------------
#  Data Format: List --------------------------- 
#' ---------------------------------------------
list_example <- 
  list(numeric_vector, 
       character_vector, 
       logical_vector, 
       matrix_example, 
       df_example)

print(list_example)
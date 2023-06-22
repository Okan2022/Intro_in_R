#' ---------------------------------------------
#  Introduction to R ---------------------------
#  2.7 Merging Data Frames ---------------------
#' ---------------------------------------------


#' ---------------------------------------------
#  Defining the Issue --------------------------
#' ---------------------------------------------
gdp_data <- read.csv2("dat/gdp_data.csv")
print(gdp_data)

fh_data <- read.csv2("dat/fh_data.csv")
print(fh_data)


#' ---------------------------------------------
#  Merging Data Frames -------------------------
#' ---------------------------------------------
print(gdp_data)

print(fh_data)

data <- as.data.frame(
  cbind(gdp_data, fh_data[,-1])
)
print(data)

colnames(data)[3] <- "fh"
print(data)

#Different Orders 

gdp_data <- read.csv2("dat/gdp_data_alt.csv")

print(gdp_data)

print(fh_data)

data <- as.data.frame(
  merge(gdp_data, fh_data, by = "country")
)

print(data)

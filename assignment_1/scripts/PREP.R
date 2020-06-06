# Assignment 1
# from: Stefan Zimmermann

# install and load packages
loadpackage <- function(x){
  for( i in x ){
    #  require returns TRUE invisibly if it was able to load package
    if( ! require( i , character.only = TRUE ) ){
      #  If package was not able to be loaded then re-install
      install.packages( i , dependencies = TRUE )
    }
    #  Load package (after installing)
    library( i , character.only = TRUE )
  }
}

# load packages
loadpackage( c("readr", "knitr", "dplyr"))

# set output directory
rawdir <- "C:/clone/Modern Workflows/assignment_1/input/raw/"
outdir <- "C:/clone/Modern Workflows/assignment_1/output/data/"

# use url to current dataset
url_data1 <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/UID_ISO_FIPS_LookUp_Table.csv"
url_data2 <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv"

# load datasets
data1 <- read_csv(url_data1)
data2 <- read_csv(url_data2)

# save raw-data with time stamp
write.csv(data1, paste0(rawdir, paste0(format(Sys.time(), "%Y_%m_%d_%H%M_")), "covid19_table.csv"), row.names=FALSE)
write.csv(data2, paste0(rawdir, paste0(format(Sys.time(), "%Y_%m_%d_%H%M_")), "covid19_global.csv"), row.names=FALSE)

# harmonise ID-Variables in both datasets
names(data1)[names(data1) == "Long_"] <- "Long"
names(data2)[names(data2) == "Country/Region"] <- "Country_Region"
names(data2)[names(data2) == "Province/State"] <- "Province_State"

# Since we are only interested in countries and not in regions
# we keep only a subset of the dataset without regions. 
data1 <-subset(data1, is.na(data1$Province_State))
data2 <-subset(data2, is.na(data2$Province_State))

# merge with country name. long and lat differ in both datasets
data_wide <- left_join(data1, data2, c("Country_Region"))

# Check Countries without infos
data_wide$Country_Region[is.na(data_wide$`1/22/20`)]

# keep only necessary variables
data_wide <-subset(data_wide, select = c("Country_Region", "Population",
                                         names(data_wide)[16:length(data_wide)]))

# Reshape wide to long
data_long <- 
  reshape(
    data = as.data.frame(data_wide),
    varying = list(names(data_wide)[3:length(data_wide)]),
    timevar = "day",
    v.names = "count",
    idvar = c("Country_Region"),
    direction = "long",
    times = names(data_wide)[3:length(data_wide)]
  )    

# save data as csv
write.csv(data_wide, paste0(outdir, paste0(format(Sys.time(), "%Y_%m_%d_%H%M_")), "data_wide.csv"), row.names=FALSE)
write.csv(data_wide, "data_wide.csv", row.names=FALSE)
write.csv(data_long, paste0(outdir, paste0(format(Sys.time(), "%Y_%m_%d_%H%M_")), "data_long.csv"), row.names=FALSE)
write.csv(data_long, "data_long.csv", row.names=FALSE)
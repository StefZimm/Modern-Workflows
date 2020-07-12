install.packages("sparklyr")
library(sparklyr)
spark_install()

rmarkdown::render('assignment_3/scripts/Analytical_Notebook_Stefan_Zimmermann.Rmd', 
                  output_file = '../output/Analytical_Notebook_Stefan_Zimmermann.pdf')

url_data1 <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/UID_ISO_FIPS_LookUp_Table.csv"
url_data2 <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv"

# load datasets
data1 <- read_csv(url_data1)
data2 <- read_csv(url_data2)

names(data1)[names(data1) == "Long_"] <- "Long"
names(data2)[names(data2) == "Country/Region"] <- "Country_Region"
names(data2)[names(data2) == "Province/State"] <- "Province_State"

sc <- spark_connect(master = "local",
                    version = "2.4.3")
spark_data1 <- copy_to(sc, data1, overwrite = T)
spark_data2 <- copy_to(sc, data2, overwrite = T)
src_tbls(sc)

summarise(spark_data1, mpg_percentile = percentile(Population, 0.25))

names(data1)[names(data1) == "Long_"] <- "Long"

test <- data1.join(data2,['Country_Region'],how='inner')
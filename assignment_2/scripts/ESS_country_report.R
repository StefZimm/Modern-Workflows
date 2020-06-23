
# Main Script to create country specific Reports

library(tidyverse)
library(foreign)
library(summarytools)
library(webshot)
library(htmltools)
library(caTools)
library(texreg)
library(purrr)

# set data path
datapath <- "C:\\clone\\Modern Workflows\\assignment_2\\input\\raw"
outDir   <- "C:\\clone\\Modern Workflows\\assignment_2\\input\\unzip"
output <- "C:\\clone\\Modern Workflows\\assignment_2\\output\\"
outputpath <- "C:\\clone\\Modern Workflows\\assignment_2\\output\\country_reports\\"
scripts <- "C:\\clone\\Modern Workflows\\assignment_2\\scripts\\"

# Data Prep
files <- list.files(datapath)
for (i in files) {
  print(i)
  unzip(zipfile = paste(datapath, i , sep = "\\"), exdir = outDir)
}

get_EVS_data <- function(datapath, variables, factor) {
  
  # Function get_EVS_data 
  # Args: 
  # datapath = datapath to dataframe in .sav format as string 
  # variables = research variables as vector 
  # factor = TRUE/FALSE to define class of selected variables 
  
  # Returns: 
  # dataset = dataframe
  
  data <- read.spss(datapath, use.value.label=factor, to.data.frame=TRUE) 
  subset(data,select=variables) 
}

data <- suppressWarnings(get_EVS_data(datapath = paste0(outDir, "\\", "ZA7500_v3-0-0.sav"),
                                      variables = c("id_cocas", "year", "age", "age_r", "age_r2",
                                                    "age_r3", "country", "v72", "v80", "v225", "v243_ISCED_1",
                                                    "v243_EISCED", "v243_r"), factor = TRUE))

data2 <- suppressWarnings(get_EVS_data(datapath = paste0(outDir, "\\", "ZA7500_v3-0-0.sav"),
                                       variables = c("id_cocas", "year", "age", "age_r", "age_r2",
                                                     "age_r3", "country", "v72", "v80", "v225", "v243_ISCED_1",
                                                     "v243_EISCED", "v243_r"), factor = FALSE))

data$age <- data2$age 
data$age_square <- (data$age)^2 
levels(data$v243_EISCED)[levels(data$v243_EISCED)=="other"] <- NA 
levels(data$v243_r)[levels(data$v243_r)=="other"] <- NA


# Render report for different countries 
render_report <- function(path, country) {
  rmarkdown::render(
    path,
    params = list(country = country),
    output_file = paste0(outputpath, "Report-", country, ".html")
  )
}

# Update one report
#render_report(path = paste0(scripts, "EVS_report_Stefan_Zimmermann.Rmd"),
#              country = "Italy")

# Update all country reports
map(unique(data$country),
    render_report,
    path = paste0(scripts, "EVS_report_Stefan_Zimmermann.Rmd"))

# render policy maker report
rmarkdown::render(paste0(scripts, "EVS_report_Stefan_Zimmermann_policy_maker.Rmd"),
                  output_file = paste0(output, "EVS_report_Stefan_Zimmermann_policy_maker.html"))

# render statisticians report
rmarkdown::render(paste0(scripts, "EVS_report_Stefan_Zimmermann_statisticians.Rmd"),
                  output_file = paste0(output, "EVS_report_Stefan_Zimmermann_statisticians.html"))
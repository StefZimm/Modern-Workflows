# load packages
library(tidyverse)
library(foreign)
library(summarytools)
library(webshot)
# set data path
datapath <- "C:\\clone\\Modern Workflows\\assignment_2\\input\\raw"
outDir   <- "C:\\clone\\Modern Workflows\\assignment_2\\input\\unzip"
outputpath <- "C:\\clone\\Modern Workflows\\assignment_2\\output\\"

##########################################################################
# Data Prep *
##########################################################################
# unzip datasets
files <- list.files(datapath)
for (i in files) {
  print(i)
  unzip(zipfile = paste(datapath, i , sep = "\\"), exdir = outDir)
}

get_EVS_data <- function(datapath, variables, factor) {
  
  # Function get_EVS_data
  # 
  # Args:
  # datapath = datapath to dataframe in .sav format as string
  # variables = research variables as vector
  # factor = TRUE/FALSE to define class of selected variables
  #
  # Returns:
  # dataset = dataframe
  
  data <- read.spss(datapath, use.value.label=factor, to.data.frame=TRUE)
  subset(data,select=variables) 
}  

data <- suppressWarnings(get_EVS_data(datapath = paste0(outDir, "\\", "ZA7500_v3-0-0.sav"),
                                      variables = c("id_cocas", "year", "age", "age_r", "age_r2",
                                                    "age_r3", "country", "v72", "v80", "v225", "v243_ISCED_1",
                                                    "v243_EISCED"), factor = FALSE))

data2 <- suppressWarnings(get_EVS_data(datapath = paste0(outDir, "\\", "ZA7500_v3-0-0.sav"),
                                       variables = c("id_cocas", "year", "age", "age_r", "age_r2",
                                                     "age_r3", "country", "v72", "v80", "v225", "v243_ISCED_1",
                                                     "v243_EISCED"), factor = TRUE))

#########################################################################
# Descriptives #
#########################################################################
get_summary <- function(dataset, output.path, source){
  
  # Function get_summary
  # 
  # Args:
  # dataset = dataset
  # output.path = savepath for html output
  #
  # Returns:
  # sum1_* = html with summary statistics
  # sum2_* = html with summary statistics
  
  print(dfSummary(dataset, graph.magnif = 0.5, headings = FALSE),
        file = paste0(output.path , "summary_", deparse(substitute(dataset)), ".html"), 
        footnote = paste0("<b>Descriptive statistics</b> of ", source))
}


get_summary(dataset = data, 
            output.path = outputpath,
            source = "EVS Data: doi:10.4232/1.13511")

```{r, echo=FALSE}
htmltools::includeHTML("C:\clone\Modern Workflows\assignment_2\output\summary_data.html")
```
lm(unlist(data["v72"]) ~ unlist(data["country"]),    data=data)
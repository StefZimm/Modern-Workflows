# Final Project
# from: Stefan Zimmermann

# Repo-Script path
datapath <- "C:\\clone\\Modern Workflows\\final_project\\input\\raw"
outDir   <- "C:\\clone\\Modern Workflows\\final_project\\input\\unzip"
output <- "C:\\clone\\Modern Workflows\\final_project\\output\\"
scripts <- "C:\\clone\\Modern Workflows\\final_project\\scripts\\"


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
loadpackage( c("tidyverse", "dplyr", "tidyr", "foreign", "shiny", "shinythemes",
               "summarytools", "janitor", "formattable", "data.table", 
               "shinydashboard", "plotly", "ngram", "SentimentAnalysis", 
               "SnowballC", "broom"))

# define Variables
variables <- c("id_cocas", "year", "age", "age_r", "age_r2",
               "age_r3", "country", "v72", "v80", "v225", "v243_ISCED_1",
               "v243_EISCED", "v243_r")

# define User Inputs
label_v72 <- "Child suffers when the mother works"
label_v80 <- "Job should be given to a national"
label_v225 <- "Sex"
label_v243_r <- "Education"

choices <- c(label_v72, label_v80)
controls <- c(label_v225, label_v243_r, "Sex and Education")

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
                                      variables = variables, factor = TRUE))

data2 <- suppressWarnings(get_EVS_data(datapath = paste0(outDir, "\\", "ZA7500_v3-0-0.sav"),
                                       variables = variables, factor = FALSE))

# clean Data
data$age <- data2$age 
levels(data$v243_EISCED)[levels(data$v243_EISCED)=="other"] <- NA 
levels(data$v243_r)[levels(data$v243_r)=="other"] <- NA

country_names <- (attributes(data$country)[1])$levels
country_names <- sort(country_names)

setnames(data, variables[8:9], c(label_v72, label_v80))
setnames(data, variables[c(10,13)], c(label_v225, label_v243_r))

setnames(data2, variables[8:9], c(label_v72, label_v80))
setnames(data2, variables[c(10,13)], c(label_v225, label_v243_r))
data2$country <- data$country

# filter data set
get_filter_data <- function(data, nadrop, filter) { 
  filter_data <-  data %>% 
    filter(country == filter) %>%
    drop_na({{ nadrop }}) %>%
    drop_na(Sex) %>%
    drop_na(Education) %>%
    drop_na(age) 
  return(filter_data)
}

# get regression formula
get_formula <- function(outcome, control, poly) {

  
  if (control=="Sex and Education"){
    control <- paste0(gsub(' and ', " + ", control), " + ")
    paste0("`", outcome, "`", " ~ ", control, "poly(age,", poly, ")")
    
  } else {
    if ((grepl("([A-Z])", control))==TRUE){
      paste0("`", outcome, "`", " ~ ", paste0(control, " + "), "poly(age,", poly, ")")
    } 
    else{
    paste0("`", outcome, "`", " ~ ", gsub(' + ', "", control), "poly(age,", poly, ")")
  }
  }
}

get_plot <- function(var, data, title) { 
  
  data %>%
    filter(!is.na({{ var }}) & 
             !is.na(age_r)  & !is.na(Sex) & !is.na(Education)) %>%
    ggplot(aes(x = {{ var }}, fill = age_r))+
    geom_bar(position = 'fill')+
    labs(title = title,
         y = "Proportion")+
    scale_y_continuous(labels = scales::percent)+
    theme(legend.title=element_blank(),
          axis.line = element_line(colour = "black"),
          axis.title.x=element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank(),
          panel.background = element_blank(),
          axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5))+
    facet_grid(Sex~Education)
}

get_filter_data <- function(filter, var) { 
  filter_data <-  data %>% 
    filter(country == filter & !is.na(age) & !is.na(Sex) &
           !is.na({{ var }}) &
           !is.na(Education))  
  
  return(filter_data)
}

set.seed(100)
regdata <- data2 %>%
  filter(!is.na(age) & !is.na(Sex) & 
           !is.na(`Job should be given to a national`) &
           !is.na(Education) & (country == "Germany"))

#regdata <- sample_n(regdata, 1000)

#regdata$`Job should be given to a national` <- 
#  as.numeric(regdata$`Job should be given to a national`)

#regdata$Sex <- as.numeric(regdata$Sex)
#regdata$Education <- as.numeric(regdata$Education)
 
result <- lm(paste0("`Job should be given to a national` ~ Education + poly(age,3)"), 
    data = regdata)

regression <- broom::tidy(result)

model.diag.metrics <- augment(result)
head(model.diag.metrics)


regdata$predicted <- predict(result)   # Save the predicted values
regdata$residuals <- residuals(result)

regdata %>% 
  select(`Job should be given to a national`, predicted, residuals) %>% 
  head()

plot(result, which=1, col=c("blue")) # Residuals vs Fitted Plot


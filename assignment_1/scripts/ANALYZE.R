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
loadpackage( c("readr", "knitr", "dplyr", "ggplot2", "varhandle"))

# set output directory
datadir <- "C:/clone/Modern Workflows/assignment_1/output/data/"
graphdir <- "C:/clone/Modern Workflows/assignment_1/output/png/"

# load datasets
data_long <- read_csv(paste0(datadir, "data_long.csv"))
data_wide <- read_csv(paste0(datadir, "data_wide.csv"))

#####################################################################
# Prepare dataset
# sum total count per day
day_data <- data_long %>%
  group_by(day) %>%
  summarise(freq = sum(count))

# order dataset
day_data <- day_data[order(day_data[,"freq"],decreasing=FALSE),]

# calculate log number of cases
day_data$logcount=log(day_data$freq)

days <- names(data_wide)[3:length(data_wide)]
weeks <- days[seq(1, length(days), 7)]

country_data <- data_long
# calculate log number of cases
country_data$logcount=log(country_data$count)
country_data[country_data == -Inf] <- 0
# calculate rate of infection per 100,000 cases
country_data$rate=(country_data$count/country_data$Population)*100000

#####################################################################
# Overall change in time of log number of cases
ggplot(data=day_data, aes(x=reorder(day, logcount), y=logcount, group=1)) +
  geom_line()+
  geom_point()+
  scale_x_discrete(limit = weeks)+
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        axis.title=element_blank(),
        axis.ticks = element_blank(),
        strip.text = element_blank())+
  labs(title =  "Overall change in time of log number of Corona cases",
       caption = "CSSEGISandData/COVID-19")

ggsave(paste0(graphdir, "total_global.png"))

#####################################################################

# change in time of log number of cases by country

country_filtered <- country_data %>%
  group_by(Country_Region) %>% 
  filter(Country_Region == "Russia") %>%
  ungroup()
country_filtered2 <- country_data %>%
  group_by(Country_Region) %>% 
  filter(Country_Region == "US") %>%
  ungroup()
country_filtered3 <- country_data %>%
  group_by(Country_Region) %>% 
  filter(Country_Region == "South Africa") %>%
  ungroup()
country_filtered4 <- country_data %>%
  group_by(Country_Region) %>% 
  filter(Country_Region == "Germany") %>%
  ungroup()
country_filtered5 <- country_data %>%
  group_by(Country_Region) %>% 
  filter(Country_Region == "Italy") %>%
  ungroup()

ggplot(data=country_data, aes(x=reorder(day, logcount), y=logcount, group=Country_Region)) +
  geom_line()+
  geom_point()+
  scale_x_discrete(limit = weeks)+
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        axis.title=element_blank(),
        axis.ticks = element_blank(),
        strip.text = element_blank())+
  labs(title =  "Change in time of log number of Corona cases by country",
       caption = "CSSEGISandData/COVID-19")+
  # colourise only the filtered data
  geom_line(aes(days, as.numeric(logcount), colour = Country_Region), data = country_filtered, size=2)+
  theme(
    # Change legend 
    legend.position = c(0.25, 0.925),
    legend.direction = "horizontal",
    legend.background = element_rect(fill = "black", color = NA),
    legend.key = element_rect(color = "gray", fill = "black"),
    legend.title = element_text(color = "white"),
    legend.text = element_text(color = "white")
  )+
  geom_line(aes(days, as.numeric(logcount), colour = Country_Region), data = country_filtered2, size=2)+
  theme(
    # Change legend 
    legend.position = c(0.25, 0.925),
    legend.direction = "horizontal",
    legend.background = element_rect(fill = "black", color = NA),
    legend.key = element_rect(color = "gray", fill = "black"),
    legend.title = element_text(color = "white"),
    legend.text = element_text(color = "white")
  )+
  geom_line(aes(days, as.numeric(logcount), colour = Country_Region), data = country_filtered3, size=2)+
  theme(
    # Change legend 
    legend.position = c(0.25, 0.925),
    legend.direction = "horizontal",
    legend.background = element_rect(fill = "black", color = NA),
    legend.key = element_rect(color = "gray", fill = "black"),
    legend.title = element_text(color = "white"),
    legend.text = element_text(color = "white")
  )+
  geom_line(aes(days, as.numeric(logcount), colour = Country_Region), data = country_filtered4, size=2)+
  theme(
    # Change legend 
    legend.position = c(0.25, 0.925),
    legend.direction = "horizontal",
    legend.background = element_rect(fill = "black", color = NA),
    legend.key = element_rect(color = "gray", fill = "black"),
    legend.title = element_text(color = "white"),
    legend.text = element_text(color = "white")
  )+
  geom_line(aes(days, as.numeric(logcount), colour = Country_Region), data = country_filtered5, size=2)+
  theme(
    # Change legend 
    legend.position = c(0.25, 0.925),
    legend.direction = "horizontal",
    legend.background = element_rect(fill = "black", color = NA),
    legend.key = element_rect(color = "gray", fill = "black"),
    legend.title = element_text(color = "white"),
    legend.text = element_text(color = "white")
  )

ggsave(paste0(graphdir, "total_country.png"), width = 11, height = 5)
##########################################################################
# change in time by country of rate of infection per 100,000 cases

ggplot(data=country_data, aes(x=reorder(day, rate), y=rate, group=Country_Region)) +
  geom_line()+
  geom_point()+
  scale_x_discrete(limit = weeks)+
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        axis.title=element_blank(),
        axis.ticks = element_blank(),
        strip.text = element_blank())+
  labs(title =  "Change in time by country of rate of Corona infection per 100,000 cases",
       caption = "CSSEGISandData/COVID-19")+
  # colourise only the filtered data
  geom_line(aes(days, as.numeric(rate), colour = Country_Region), data = country_filtered, size=2)+
  theme(
    # Change legend 
    legend.position = c(0.25, 0.925),
    legend.direction = "horizontal",
    legend.background = element_rect(fill = "black", color = NA),
    legend.key = element_rect(color = "gray", fill = "black"),
    legend.title = element_text(color = "white"),
    legend.text = element_text(color = "white")
  )+
  geom_line(aes(days, as.numeric(rate), colour = Country_Region), data = country_filtered2, size=2)+
  theme(
    # Change legend 
    legend.position = c(0.25, 0.925),
    legend.direction = "horizontal",
    legend.background = element_rect(fill = "black", color = NA),
    legend.key = element_rect(color = "gray", fill = "black"),
    legend.title = element_text(color = "white"),
    legend.text = element_text(color = "white")
  )+
  geom_line(aes(days, as.numeric(rate), colour = Country_Region), data = country_filtered3, size=2)+
  theme(
    # Change legend 
    legend.position = c(0.25, 0.925),
    legend.direction = "horizontal",
    legend.background = element_rect(fill = "black", color = NA),
    legend.key = element_rect(color = "gray", fill = "black"),
    legend.title = element_text(color = "white"),
    legend.text = element_text(color = "white")
  )+
  geom_line(aes(days, as.numeric(rate), colour = Country_Region), data = country_filtered4, size=2)+
  theme(
    # Change legend 
    legend.position = c(0.25, 0.925),
    legend.direction = "horizontal",
    legend.background = element_rect(fill = "black", color = NA),
    legend.key = element_rect(color = "gray", fill = "black"),
    legend.title = element_text(color = "white"),
    legend.text = element_text(color = "white")
  )+
  geom_line(aes(days, as.numeric(rate), colour = Country_Region), data = country_filtered5, size=2)+
  theme(
    # Change legend 
    legend.position = c(0.25, 0.925),
    legend.direction = "horizontal",
    legend.background = element_rect(fill = "black", color = NA),
    legend.key = element_rect(color = "gray", fill = "black"),
    legend.title = element_text(color = "white"),
    legend.text = element_text(color = "white")
  )

ggsave(paste0(graphdir, "total_country_rate.png"), width = 11, height = 5)

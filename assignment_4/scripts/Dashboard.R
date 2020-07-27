# Assignment 4
# from: Stefan Zimmermann

# 1. Data Prep
# Repo-Script path
setwd("C:/clone/Modern Workflows/assignment_4/scripts")


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
               "summarytools", "janitor", "formattable", "data.table", "rsconnect"))


# set up rsconnect to shinyapp.to
rsconnect::setAccountInfo(name='wvsapp',
                          token='FABA818BE5F84DE71C2EFD8A9365590C',
                          secret='6WcCNO6Z17IiW2BDNFdQ4D6oPJFqUFj42jbnBBZx')

# Variables of interest
variables <- c("V2", "V228A", "V228B", "V228C", "V228D", "V228E", "V228F", "V228G", "V228H",
               "V228I", "V217", "V218", "V219", "V220", "V221", "V222", "V223", "V224", 
               "V192", "V193", "V194", "V195", "V196", "V197")

# Labels of variables
label_V228A <-  "How often in country's elections: Votes are counted fairly"
label_V228B <-  "How often in country's elections: Opposition candidates are prevented from running"
label_V228C <-  "How often in country's elections: TV news favors the governing Party"
label_V228D <-  "How often in country's elections: Voters are bribed"
label_V228E <-  "How often in country's elections: Journalists provide fair coverage of elections"
label_V228F <-  "How often in country's elections: Election officials are fair"
label_V228G <-  "How often in country's elections: Rich people buy elections"
label_V228H <-  "How often in country's elections: Voters are threatened with  violence"
label_V228I <-  "How often in country's elections: Voters are offered a genuine choice in the election"

pol_choices <- gsub('.+: ', "", c(label_V228A, label_V228B, label_V228C, 
                                  label_V228D, label_V228E, label_V228F, 
                                  label_V228G, label_V228H, label_V228I))

label_V217 <- "Information source: Daily newspaper"
label_v218 <- "Information source: Printed magazines"
label_v219 <- "Information source: TV news" 
label_v220 <- "Information source: Radio news" 
label_v221 <- "Information source: Mobile phone"
label_v222 <- "Information source: Email"
label_v223 <- "Information source: Internet" 
label_v224 <- "Information source: Talk with friends or colleagues" 

news_choices <-  gsub('.+: ', "", c(label_V217, label_v218, label_v219, 
                                    label_v220, label_v221, label_v222, 
                                    label_v223, label_v224))

label_v192 <- "Science and technology are making our lives healthier, easier, and more comfortable"
label_v193 <- "Science and technology, there will be more opportunities for the next"
label_v194 <- "We depend too much on science and not enough on faith"
label_v195 <- "One of the bad effects of science is that it breaks down peoples ideas of right"
label_v196 <- "It is not important for me to know about science in my daily life"
label_v197 <- "The world is better off, or worse off, because of science and technology"

science_choices <-  gsub('.+: ', "", c(label_v192, label_v193, label_v194, 
                                       label_v195, label_v196, label_v197))


# Prepare Dataset
# unzip dataset
files <- list.files("../input/raw/")
for (i in files) {
  print(i)
  unzip(zipfile = paste("../input/raw", i , sep = "/"), exdir = "../input/unzip")
}

get_WVS_data <- function(datapath, variables, factor) {
  
  # Function get_WVS_data 
  # Args: 
  # datapath = datapath to dataframe in .sav format as string 
  # variables = research variables as vector 
  # factor = TRUE/FALSE to define class of selected variables 
  
  # Returns: 
  # dataset = dataframe
  
  data <- read.spss(datapath, use.value.label=factor, to.data.frame=TRUE) 
  subset(data,select=variables) 
}

# get overall proportopns table
get_table_overall <- function(var) { 
  
  data_all <- data %>%
    drop_na({{ var }}) %>%
    count({{ var }}) %>%
    mutate(Proportion = prop.table(n)*100)%>%
    mutate(overall="World")
  
  return(data_all)
}

# get proportion table by country
get_table_filter <- function(var, filter) { 
  filter_data <-  data %>% 
    filter(V2 == filter) %>%
    drop_na({{ var }}) %>%
    count({{ var }}) %>%
    mutate(Proportion = prop.table(n)*100)%>%
    mutate(overall=filter)
  
  return(filter_data)
}

# create barplot
get_plot <- function(var, data, title) { 
  
  ggplot(data, aes(fill=overall, y=Proportion, x={{ var }})) + 
    geom_bar(position="dodge", stat="identity") +
    labs(y = "Proporton",
         title = title,
         caption = "Data: WVS Wave 6")+
    ylim(0,100)+
    theme_bw() +
    theme(axis.line = element_line(colour = "black"),
          axis.title.x=element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank(),
          panel.background = element_blank())+
    theme(legend.title=element_blank(),
          legend.position = "bottom")
  
}

# load dataset
data <- suppressWarnings(get_WVS_data(datapath = paste0("../input/unzip/", list.files("../input/unzip")),
                                      variables = variables, 
                                      factor = TRUE))

# recode large scale
data <- data %>% 
  mutate_at(vars(V192,V193,V194,V195,V196,V197), recode,  
            `2` = "disagree", `3`  = "disagree", `4` = "disagree",
            `6` = "agree", `7` = "agree", `8`  = "agree", `9` = "agree",
            `5` = "indecisive")

# rename varnames
setnames(data, variables[2:length(variables)], c(pol_choices, news_choices, science_choices))

# delete missing attributes of country variable
country_names <- (attributes(data$V2)[1])$levels
country_names <- sort(country_names[6:length(country_names)])

# 2. Creating the App
deployApp()

ui <- fluidPage(theme = shinytheme("journal"),
                
 titlePanel(div(column(width = 5, h2("World Value Study (WVS) Dashboard")), 
              column(width = 4, tags$img(src = 
              "https://www.worldvaluessurvey.org/photos/EV000308.PNG", height='60',width='150'))),
              windowTitle="World Value Study (WVS) Dashboard"
            ),


  mainPanel(
    h2("Overview"),
    p("The World Values Survey (WVS) is a global research project 
       that explores people's values and beliefs, how they change 
       over time, and what social and political impact they have. 
       Since 1981 a worldwide network of social scientists have 
       conducted representative national surveys as part of WVS in 
       almost 100 countries. The WVS measures, monitors and analyzes: 
       support for democracy, tolerance of foreigners and ethnic minorities, 
       support for gender equality, the role of religion and changing 
       levels of religiosity, the impact of globalization, attitudes 
       toward the environment, work, family, politics, national identity, 
       culture, diversity, insecurity, and subjective well-being. This dashboard
       lets the readers explore data from the World Value Study(WVS). 
       This dashboard allows the user to interactively view information 
       on different countries on the topics perception of democracy, 
       news consumption and perception of science. To start the analysis. 
       Please select a Country"),
  ),
  
  selectizeInput("country", 
                 label = "Please select a Country", choices = country_names,
    options = list(
      placeholder = 'Select a Country',
      onInitialize = I('function() { this.setValue(""); }')
    )
  ),
  
  h2("Exploring attitudes to democracy"),
  p("Anger at political elites, economic dissatisfaction and anxiety 
      about rapid social changes have fueled political upheaval in regions 
      around the world in recent years. Anti-establishment leaders, parties 
      and movements have emerged on both the right and left of the political 
      spectrum, in some cases challenging fundamental norms and institutions 
      of liberal democracy. Organizations from Freedom House to the Economist 
      Intelligence Unit to V-Dem have documented global declines in the health 
      of democracy. The data of the WVS can also provide an insight into the 
      perception of democracy in the different countries. "),
  
  varSelectInput("democracy", "Please select a topic", 
                 data[pol_choices], 
                 width = '400px'
                 ),

  sidebarPanel(
    tableOutput("staticpol1"),
  ),
  
  mainPanel(
    plotOutput("plotpol1")
  ),

  h2("Exploring news consumption"),
  p("Up until very recently, print newspapers dominated 
    the journalism industry. This was before the rise of digital 
    and televised media changed the game. Thanks to the widespread 
    accessibility of the internet, the whole world is now plugged 
    into an infinite database that allows people to consume media 
    and engage with a transnational network. The goal for this piece 
    is to explore how this changing landscape has affected trends in news consumption,"),
  
  varSelectInput("news", "Please select a news source", 
               data[news_choices], 
               width = '400px'
  ),

  sidebarPanel(
    tableOutput("staticnew1"),
  ),

  mainPanel(
    plotOutput("plotnew1")
  ),
  
  h2("Exploring attitudes to science"),
  p("Attitude towards science can be defined as the feelings, 
     beliefs, and values held about an object that may be the 
     endeavor of science, school science, the impact of science 
     and technology on society, or scientists. As science continues 
     to progress, attitudes towards science seem to become more 
     polarized. Whereas some put their faith in science, others routinely 
     reject and dismiss scientific evidence. The goal for this piece 
     is to explore how this changing landscape has affected the attitude to science,"),
  
  varSelectInput("science", "Please select a statement", 
                 data[science_choices], 
                 width = '600px'
  ),
  
  sidebarPanel(
    tableOutput("staticscience1"),
  ),
  
  mainPanel(
    plotOutput("plotscience1")
  )
)

server <- function(input, output, session) {
  
  # Exploring Democracy Data
  
  filtered_data_pol <- reactive({ 
    get_table_filter(var = !!input$democracy, filter = input$country)
  })
  
  output$staticpol1 <- renderTable(
    filtered_data_pol()[1:3])
  
  output$plotpol1 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = !!input$democracy), 
                           get_table_filter(var = !!input$democracy, 
                                            filter = input$country))
    get_plot(var = !!input$democracy, 
             data = data_complete, 
             title = paste0("How often in ", input$country,  " elections: ", 
                            names(filtered_data_pol()[1])))
  })
  
  # Exploring News Data
  
  filtered_data_new <- reactive({ 
    get_table_filter(var = !!input$news, filter = input$country)
  })
  
  output$staticnew1 <- renderTable(
    filtered_data_new()[1:3])
  
  output$plotnew1 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = !!input$news), 
                           get_table_filter(var = !!input$news, 
                                            filter = input$country))
    get_plot(var = !!input$news, 
             data = data_complete, 
             title = paste0("Information source in ", input$country, ": ",
                            names(filtered_data_new()[1])))
  })
  
  # Exploring Science Data
  
  filtered_data_science <- reactive({ 
    get_table_filter(var = !!input$science, filter = input$country)
  })
  
  output$staticscience1 <- renderTable(
    filtered_data_science()[1:3])
  
  output$plotscience1 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = !!input$science), 
                           get_table_filter(var = !!input$science, 
                                            filter = input$country))
    get_plot(var = !!input$science, 
             data = data_complete, 
             title = names(filtered_data_science()[1]))
  })
}

shinyApp(ui, server)
deployApp("/Dashboard.R")

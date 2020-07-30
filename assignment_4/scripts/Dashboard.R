# Assignment 4
# from: Stefan Zimmermann

# 2. Creating the App

ui <-   dashboardPage(
  dashboardHeader(title = "World Value Study (WVS) Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "Dashboard", icon = icon("dashboard")),
      menuItem("Democracy", tabName = "Democracy", icon = icon("vote-yea")),
      menuItem("News Consumption", tabName = "News", icon = icon("newspaper")),
      menuItem("Science", tabName = "Science", icon = icon("flask")) 
    )),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "Dashboard",
              tabItem(tabName = "Dashboard",
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
       news consumption and perception of science. To start the analysis."),
                      ),
                      selectizeInput("country", 
                                     label = "Please select a Country", choices = country_names,
                                     options = list(
                                       placeholder = 'Select a Country',
                                       onInitialize = I('function() { this.setValue(""); }')
                                     )
                      )
              )
      ),
      
      # Second tab content
      tabItem(tabName = "Democracy",
              h2("Exploring attitudes to democracy"),
              p("Anger at political elites, economic dissatisfaction and anxiety 
      about rapid social changes have fueled political upheaval in regions 
      around the world in recent years. Anti-establishment leaders, parties 
      and movements have emerged on both the right and left of the political 
      spectrum, in some cases challenging fundamental norms and institutions 
      of liberal democracy. Organizations from Freedom House to the Economist 
      Intelligence Unit to V-Dem have documented global declines in the health 
      of democracy."),
              varSelectInput("democracy", "Please select a topic", 
                             data[pol_choices], 
                             width = '400px'
              ),
              
              tableOutput("staticpol1"),
              plotlyOutput("plotpol1", width = "100%"),
                dataTableOutput("completepol1")
      ),
      
      # Thirs tab content
      tabItem(tabName = "News",
              h2("Exploring News Consumption"),
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
              
              tableOutput("staticnew1"),
              plotlyOutput("plotnew1", width = "100%"),
              dataTableOutput("completenew1")
      ),
      
      tabItem(tabName = "Science",
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
              
              tableOutput("staticscience1"),
              plotlyOutput("plotscience1", width = "100%"),
              dataTableOutput("completesci1")
      )
    )
  )
)

server <- function(input, output, session) {
  
  # Exploring Democracy Data
  
  complete_data_pol <- reactive({ 
    get_table_complete(var = !!input$democracy)
  })
  
  filtered_data_pol <- reactive({ 
    get_table_filter(var = !!input$democracy, filter = input$country)
  })
  
  output$staticpol1 <- renderTable(
    filtered_data_pol()[1:3])
  
  output$completepol1 <- renderDataTable(
    complete_data_pol(), options = list(
      pageLength = 5))
  
  
  output$plotpol1 <- renderPlotly({
    input$newplot
    data_complete <- rbind(get_table_overall(var = !!input$democracy), 
                           get_table_filter(var = !!input$democracy, 
                                            filter = input$country))
    print(
      ggplotly( 
        get_plot(var = !!input$democracy, 
                 data = data_complete, 
                 title = paste0("How often in elections: ",
                                names(filtered_data_pol()[1]), " in ", input$country))))
  })
  
  # Exploring News Data
  
  complete_data_new <- reactive({ 
    get_table_complete(var = !!input$news)
  })
  
  filtered_data_new <- reactive({ 
    get_table_filter(var = !!input$news, filter = input$country)
  })
  
  output$staticnew1 <- renderTable(
    filtered_data_new()[1:3])
  
  output$completenew1 <- renderDataTable(
    complete_data_new(), options = list(
      pageLength = 5))
  
  output$plotnew1 <- renderPlotly({
    data_complete <- rbind(get_table_overall(var = !!input$news), 
                           get_table_filter(var = !!input$news, 
                                            filter = input$country))
    print(
      ggplotly( 
        get_plot(var = !!input$news, 
             data = data_complete, 
             title = paste0("Information source in ", input$country, ": ",
                            names(filtered_data_new()[1])))))
  })
  
  # Exploring Science Data
  
  complete_data_sci <- reactive({ 
    get_table_complete(var = !!input$science)
  })
  
  filtered_data_science <- reactive({ 
    get_table_filter(var = !!input$science, filter = input$country)
  })
  
  output$staticscience1 <- renderTable(
    filtered_data_science()[1:3])
  
  output$completesci1 <- renderDataTable(
    complete_data_sci(), options = list(
      pageLength = 5))
  
  output$plotnew1 <- renderPlotly({
    data_complete <- rbind(get_table_overall(var = !!input$news), 
                           get_table_filter(var = !!input$news, 
                                            filter = input$country))
    print(
      ggplotly( 
        get_plot(var = !!input$news, 
                 data = data_complete, 
                 title = paste0("Information source in ", input$country, ": ",
                                names(filtered_data_new()[1])))))
  })
  
  output$plotscience1 <- renderPlotly({
    data_complete <- rbind(get_table_overall(var = !!input$science), 
                           get_table_filter(var = !!input$science, 
                                            filter = input$country))
    print(
      ggplotly( 
        get_plot(var = !!input$science, 
             data = data_complete, 
             title = names(filtered_data_science()[1]))))
  })
}


shinyApp(ui, server)
# deployApp("C:/clone/Modern Workflows/assignment_4/")

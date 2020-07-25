library(shiny)

ui <- fluidPage(
  
  titlePanel("World Value Study (WVS) Dashboard"),

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
  
  selectInput("country",
              label = "Country",
              choices = country_names),
  
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
  
  sidebarPanel(
    tableOutput("staticpol1"),
  ),
  mainPanel(
    plotOutput("plotpol1")
  ),
  sidebarPanel(
    tableOutput("staticpol2"),
  ),
  mainPanel(
    plotOutput("plotpol2")
  ),
  sidebarPanel(
    tableOutput("staticpol3"),
  ),
  mainPanel(
    plotOutput("plotpol3")
  ),
  sidebarPanel(
    tableOutput("staticpol4"),
  ),
  mainPanel(
    plotOutput("plotpol4")
  ),
  sidebarPanel(
    tableOutput("staticpol5"),
  ),
  mainPanel(
    plotOutput("plotpol5")
  ),
  sidebarPanel(
    tableOutput("staticpol6"),
  ),
  mainPanel(
    plotOutput("plotpol6")
  ),
  sidebarPanel(
    tableOutput("staticpol7"),
  ),
  mainPanel(
    plotOutput("plotpol7")
  ),
  sidebarPanel(
    tableOutput("staticpol8"),
  ),
  mainPanel(
    plotOutput("plotpol8")
  ),
  
  h2("Exploring news consumption"),
  p("Up until very recently, print newspapers dominated 
    the journalism industry. This was before the rise of digital 
    and televised media changed the game. Thanks to the widespread 
    accessibility of the internet, the whole world is now plugged 
    into an infinite database that allows people to consume media 
    and engage with a transnational network. The goal for this piece 
    is to explore how this changing landscape has affected trends in news consumption,"),
  
  sidebarPanel(
    tableOutput("static1"),
  ),
  mainPanel(
    plotOutput("plot1")
  ),
  sidebarPanel(
    tableOutput("static2")
  ),
  mainPanel(
    plotOutput("plot2")
  ),
  sidebarPanel(
    tableOutput("static3")
  ),
  mainPanel(
    plotOutput("plot3") 
  ),
  sidebarPanel(
    tableOutput("static4")
  ),
  mainPanel(
    plotOutput("plot4") 
  ),
  
  sidebarPanel(
    tableOutput("static5"),
  ),
  mainPanel(
    plotOutput("plot5")
  ),
  sidebarPanel(
    tableOutput("static6")
  ),
  mainPanel(
    plotOutput("plot6")
  ),
  sidebarPanel(
    tableOutput("static7")
  ),
  mainPanel(
    plotOutput("plot7") 
  ),
  sidebarPanel(
    tableOutput("static8")
  ),
  mainPanel(
    plotOutput("plot8") 
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
  
  sidebarPanel(
    tableOutput("staticsci1"),
  ),
  mainPanel(
    plotOutput("plotsci1")
  ),
  sidebarPanel(
    tableOutput("staticsci2"),
  ),
  mainPanel(
    plotOutput("plotsci2")
  ),
  sidebarPanel(
    tableOutput("staticsci3"),
  ),
  mainPanel(
    plotOutput("plotsci3")
  ),
  sidebarPanel(
    tableOutput("staticsci4"),
  ),
  mainPanel(
    plotOutput("plotsci4")
  ),
  sidebarPanel(
    tableOutput("staticsci5"),
  ),
  mainPanel(
    plotOutput("plotsci5")
  ),
  sidebarPanel(
    tableOutput("staticsci6"),
  ),
  mainPanel(
    plotOutput("plotsci6")
  )
  
)

server <- function(input, output, session) {
  
  # Exploring Democracy Data
  
  filtered_data_pol <- reactive({ 
    get_table_filter(var = V228A, filter = input$country)
  })
  
  output$staticpol1 <- renderTable(
    filtered_data_pol()[1:3])
  
  output$plotpol1 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = V228A), 
                           get_table_filter(var = V228A, 
                                            filter = input$country))
    get_plot(var = V228A, 
             data = data_complete, 
             title = label_V228A)
  })
  
  filtered_data_pol2 <- reactive({ 
    get_table_filter(var = V228B, filter = input$country)
  })
  
  output$staticpol2 <- renderTable(
    filtered_data_pol2()[1:3])
  
  output$plotpol2 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = V228B), 
                           get_table_filter(var = V228B, 
                                            filter = input$country))
    get_plot(var = V228B, 
             data = data_complete, 
             title = label_V228B)
  })
  
  filtered_data_pol3 <- reactive({ 
    get_table_filter(var = V228C, filter = input$country)
  })
  
  output$staticpol3 <- renderTable(
    filtered_data_pol3()[1:3])
  
  output$plotpol3 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = V228C), 
                           get_table_filter(var = V228C, 
                                            filter = input$country))
    get_plot(var = V228C, 
             data = data_complete, 
             title = label_V228C)
  })
  
  filtered_data_pol4 <- reactive({ 
    get_table_filter(var = V228D, filter = input$country)
  })
  
  output$staticpol4 <- renderTable(
    filtered_data_pol4()[1:3])
  
  output$plotpol4 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = V228D), 
                           get_table_filter(var = V228D, 
                                            filter = input$country))
    get_plot(var = V228D, 
             data = data_complete, 
             title = label_V228D)
  })
  
  filtered_data_pol5 <- reactive({ 
    get_table_filter(var = V228E, filter = input$country)
  })
  
  output$staticpol5 <- renderTable(
    filtered_data_pol5()[1:3])
  
  output$plotpol5 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = V228E), 
                           get_table_filter(var = V228E, 
                                            filter = input$country))
    get_plot(var = V228E, 
             data = data_complete, 
             title = label_V228E)
  })
  
  filtered_data_pol6 <- reactive({ 
    get_table_filter(var = V228F, filter = input$country)
  })
  
  output$staticpol6 <- renderTable(
    filtered_data_pol6()[1:3])
  
  output$plotpol6 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = V228F), 
                           get_table_filter(var = V228F, 
                                            filter = input$country))
    get_plot(var = V228F, 
             data = data_complete, 
             title = label_V228F)
  })
  
  filtered_data_pol7 <- reactive({ 
    get_table_filter(var = V228G, filter = input$country)
  })
  
  output$staticpol7 <- renderTable(
    filtered_data_pol7()[1:3])
  
  output$plotpol7 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = V228G), 
                           get_table_filter(var = V228G, 
                                            filter = input$country))
    get_plot(var = V228G, 
             data = data_complete, 
             title = label_V228G)
  })
  
  filtered_data_pol8 <- reactive({ 
    get_table_filter(var = V228H, filter = input$country)
  })
  
  output$staticpol8 <- renderTable(
    filtered_data_pol8()[1:3])
  
  output$plotpol8 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = V228H), 
                           get_table_filter(var = V228H, 
                                            filter = input$country))
    get_plot(var = V228H, 
             data = data_complete, 
             title = label_V228H)
  })
  
  
  
  
  # Exploring News Data
  filtered_data <- reactive({ 
    get_table_filter(var = V217, filter = input$country)
  })
  
  output$static1 <- renderTable(
    filtered_data()[1:3])
  
  output$plot1 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = V217), 
                       get_table_filter(var = V217, 
                                        filter = input$country))
    get_plot(var = V217, 
             data = data_complete, 
             title = label_V217)
  })
  
  filtered_data2 <- reactive({
    get_table_filter(var = V218, filter = input$country)
  })
  
  output$static2 <- renderTable(
    filtered_data2()[1:3])
  
  output$plot2 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = V218), 
                       get_table_filter(var = V218, 
                                        filter = input$country))
    get_plot(var = V218, 
             data = data_complete, 
             title = label_v218)
  })
  
  filtered_data3 <- reactive({
    get_table_filter(var = V219, filter = input$country)
  })
  
  output$static3 <- renderTable(
    filtered_data3()[1:3])
  
  output$plot3 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = V219), 
                       get_table_filter(var = V219, 
                                        filter = input$country))
    get_plot(var = V219, 
             data = data_complete, 
             title = label_v219)
  })
  
  filtered_data4 <- reactive({
    get_table_filter(var = V220, filter = input$country)
  })
  
  output$static4 <- renderTable(
    filtered_data4()[1:3])
  
  output$plot4 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = V220), 
                       get_table_filter(var = V220, 
                                        filter = input$country))
    get_plot(var = V220, 
             data = data_complete, 
             title = label_v220)
  })
  
  filtered_data5 <- reactive({
    get_table_filter(var = V221, filter = input$country)
  })
  
  output$static5 <- renderTable(
    filtered_data5()[1:3])
  
  output$plot5 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = V221), 
                           get_table_filter(var = V221, 
                                            filter = input$country))
    get_plot(var = V221, 
             data = data_complete, 
             title = label_v221)
  })
  
  filtered_data6 <- reactive({
    get_table_filter(var = V222, filter = input$country)
  })
  
  output$static6 <- renderTable(
    filtered_data6()[1:3])
  
  output$plot6 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = V222), 
                           get_table_filter(var = V222, 
                                            filter = input$country))
    get_plot(var = V222, 
             data = data_complete, 
             title = label_v222)
  })
  
  filtered_data7 <- reactive({
    get_table_filter(var = V223, filter = input$country)
  })
  
  output$static7 <- renderTable(
    filtered_data7()[1:3])
  
  output$plot7 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = V223), 
                           get_table_filter(var = V223, 
                                            filter = input$country))
    get_plot(var = V223, 
             data = data_complete, 
             title = label_v223)
  })
  
  filtered_data8 <- reactive({
    get_table_filter(var = V224, filter = input$country)
  })
  
  output$static8 <- renderTable(
    filtered_data8()[1:3])
  
  output$plot8 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = V224), 
                           get_table_filter(var = V224, 
                                            filter = input$country))
    get_plot(var = V224, 
             data = data_complete, 
             title = label_v224)
  })
  
  # Exploring Attitudes towards Science
  
  filtered_data_sci <- reactive({ 
    get_table_filter(var = V192, filter = input$country)
  })
  
  output$staticsci1 <- renderTable(
    filtered_data_sci()[1:3])
  
  output$plotsci1 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = V192), 
                           get_table_filter(var = V192, 
                                            filter = input$country))
    get_plot(var = V192, 
             data = data_complete, 
             title = label_v192)
  })
  
  filtered_data_sci2 <- reactive({ 
    get_table_filter(var = V193, filter = input$country)
  })
  
  output$staticsci2 <- renderTable(
    filtered_data_sci2()[1:3])
  
  output$plotsci2 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = V193), 
                           get_table_filter(var = V193, 
                                            filter = input$country))
    get_plot(var = V193, 
             data = data_complete, 
             title = label_v193)
  })
  
  filtered_data_sci3 <- reactive({ 
    get_table_filter(var = V194, filter = input$country)
  })
  
  output$staticsci3 <- renderTable(
    filtered_data_sci3()[1:3])
  
  output$plotsci3 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = V194), 
                           get_table_filter(var = V194, 
                                            filter = input$country))
    get_plot(var = V194, 
             data = data_complete, 
             title = label_v194)
  })
  
  filtered_data_sci4 <- reactive({ 
    get_table_filter(var = V195, filter = input$country)
  })
  
  output$staticsci4 <- renderTable(
    filtered_data_sci4()[1:3])
  
  output$plotsci4 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = V195), 
                           get_table_filter(var = V195, 
                                            filter = input$country))
    get_plot(var = V195, 
             data = data_complete, 
             title = label_v195)
  })
  
  filtered_data_sci5 <- reactive({ 
    get_table_filter(var = V196, filter = input$country)
  })
  
  output$staticsci5 <- renderTable(
    filtered_data_sci5()[1:3])
  
  output$plotsci5 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = V196), 
                           get_table_filter(var = V196, 
                                            filter = input$country))
    get_plot(var = V196, 
             data = data_complete, 
             title = label_v196)
  })
  
  filtered_data_sci6 <- reactive({ 
    get_table_filter(var = V197, filter = input$country)
  })
  
  output$staticsci6 <- renderTable(
    filtered_data_sci6()[1:3])
  
  output$plotsci6 <- renderPlot({
    input$newplot
    data_complete <- rbind(get_table_overall(var = V197), 
                           get_table_filter(var = V197, 
                                            filter = input$country))
    get_plot(var = V197, 
             data = data_complete, 
             title = label_v197)
  })
  
  
}

shinyApp(ui, server)
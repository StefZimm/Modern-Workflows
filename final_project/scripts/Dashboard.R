# Assignment 4
# from: Stefan Zimmermann

# 2. Creating the App
ui <-   dashboardPage(
  dashboardHeader(title = "European Value Study (EVS) Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "Overview", icon = icon("dashboard")),
      menuItem("Exploration", tabName = "Exploration", icon = icon("wpexplorer")),
      menuItem("Regression", tabName = "Regression", icon = icon("calculator")) 
    )),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "Overview",
              tabItem(tabName = "Overview",
                      titlePanel(div(column(width = 5, h2("Dashboard")), 
                                     column(width = 4, tags$img(src = 
                                     "https://europeanvaluesstudy.eu/wp-content/uploads/2018/09/logo-evs.png", height='60'))),
                                 windowTitle="European Value Study Dashboard"),
                      mainPanel(
                        h2("Overview"),
                        p("aims, how to navigate fewsfvergrg
                          ergrtgrtbrhtbhrtgbrtbrtb
                          brtbrtbrtrtbrtbrtbtrbr
                          brtbrtbrtbrtbtrtbtb"),
                      ),
                      selectizeInput("country", 
                                     label = "Please select a Country", choices = country_names,
                                     options = list(
                                       placeholder = 'Select a Country',
                                       onInitialize = I('function() { this.setValue(""); }')
                                     )
                      ),
                      varSelectInput("Outcome", "Please select an Outcome", 
                                     data[choices]
                      )
              )
      ),
      
      # Second tab content
      tabItem(tabName = "Exploration",
              h2("Exploration"),
              p("Graph and description"),
              plotOutput("plot"),
      ),
      
      # Thirs tab content
      tabItem(tabName = "Regression",
              h2("Regression"),
              p("Test Text C"),
              selectizeInput("Controls", 
                             label = "Select Control Variables", choices = controls,
                             options = list(
                               placeholder = 'Select Control Variables',
                               onInitialize = I('function() { this.setValue(""); }')
                             )
              ),
              numericInput("pol", "Age polynomial:", 1, min = 1, max = 5),
              verbatimTextOutput("func"),
              tableOutput("reg"),
              plotOutput("regplot")
      )
    )
  )
)

server <- function(input, output, session) {
  
  # Filter Data
  filtered_data <- reactive({ 
    get_filter_data(data = data, filter = input$country, 
                    nadrop = input$Outcome)
  })
  
  filtered_data_num <- reactive({ 
    get_filter_data(data = data2, filter = input$country, 
                    nadrop = input$Outcome)
  })
  
  # control Table
  output$staticpol1 <- renderTable(
    filtered_data_num())
  
  # creae regression formula  
  formula <- reactive({
  
  get_formula(outcome = input$Outcome, 
              control = input$Controls, 
              poly = input$pol)
  })
  
  output$func <- renderText(formula())
  
  # create regression table
  result <- reactive({ 
    lm(get_formula(outcome = input$Outcome, 
                   control = input$Controls, 
                   poly = input$pol), 
                   data = filtered_data_num())
  })
  
  output$reg <- renderTable(broom::tidy(result()))
  
  output$regplot <- renderPlot({
    plot(result(), which=1, col=c("blue")) 
  })
    
  # create Plot
  output$plot <- renderPlot({
        get_plot(var = !!input$Outcome, 
                 data = filtered_data(),
                 title = paste0(names(data[as.character(input$Outcome)])))
  })
}


shinyApp(ui, server)


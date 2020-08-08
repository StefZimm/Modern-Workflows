# Final Assingment
# from: Stefan Zimmermann

# 2. Creating the App
ui <- fluidPage(   
  dashboardPage(
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
                        p("Welcome to the European Values Study Dashboard. This app allows you to explore the EVS dataset, 
                        learn more about it and take a look at some small analyses. Select the country you are interested 
                        in. Then select a variable/outcome that interests you. On the left side you will find the Exploration 
                        and Regression section. For the regression area you can add additional control variables. 
                        For example, gender and educational level can be added. The age variable can also be modified.  
                        Under Exploration you can view first descriptive results for the selected country. 
                        In the Regression area, a linear regression model is calculated for your selected parameters"),
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
                      ),
                      selectizeInput("Controls", 
                                     label = "Select Control Variables", choices = controls,
                                     options = list(
                                       placeholder = 'Select Control Variables',
                                       onInitialize = I('function() { this.setValue(""); }')
                                     )
                      ),
                      numericInput("pol", "Age polynomial:", 1, min = 1, max = 5),
                      downloadButton("report", "Download report")
              )
      ),
      
      # Second tab content
      tabItem(tabName = "Exploration",
              h2("Exploration"),
              p("The exploration area shows you three graphs. To get an idea of the data set, a histogram 
              of the age distribution is displayed. The blue line indicates the mean value of age. In the 
              second chart, the educational level by gender in the selected country is shown in a bar chart. 
              Finally, the last figure is also a bar chart which describes a possible correlation between 
              gender, age, educational level and the selected outcome."),
              plotOutput("hist"),
              plotOutput("bar"),
              plotOutput("plot"),
      ),
      
      # Thirs tab content
      tabItem(tabName = "Regression",
              h2("Regression"),
              p("Once the parameters are set at the Overview area, the formula used to calculate 
              the regression is displayed. The coefficients of the regression are displayed and 
              the predicted values can be evaluated with the residual plot."),
              verbatimTextOutput("func"),
              tableOutput("reg"),
              plotOutput("regplot")
      )
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
    
  # create Plots
  output$hist <- renderPlot({
  get_histogram(data = filtered_data(),
                title = paste0("Age Distribution in ", input$country))
  })
  
  output$bar <- renderPlot({
  ggplot(filtered_data(), aes(x = Sex, fill = Education))+
    geom_bar(position = 'fill')+
    scale_y_continuous(labels = scales::percent)+
      labs(title = paste0("Education Level by Sex in ", input$country),
           y = "Proportion")
  })
  
  output$plot <- renderPlot({
        get_plot(var = !!input$Outcome, 
                 data = filtered_data(),
                 title = paste0(names(data[as.character(input$Outcome)])))
  })
  
  output$report <- downloadHandler(
    # For PDF output, change this to "report.pdf"
    filename = reactive({ 
      paste0(input$country, "_report.html")
    }),
    content = function(file) {
      # Copy the report file to a temporary directory before processing it, in
      # case we don't have write permissions to the current working dir (which
      # can happen when deployed).
      file.copy("report.Rmd", tempReport, overwrite = TRUE)
      
      # Set up parameters to pass to Rmd document
      params <- list(n = input$slider,
                     country = input$country,
                     poly = input$pol,
                     outcome = input$Outcome,
                     controls = input$Controls
      )
      
      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(tempReport, output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv())
      )
    }
  )
  
  
}


shinyApp(ui, server)


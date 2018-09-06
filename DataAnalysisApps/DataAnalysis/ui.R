library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Data Regression and Prediction"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        fileInput("file1",
                  "Choose CSV File",
                  multiple=TRUE,
                  accept=c("text/csv",
                           "text/comma-separated-values",
                           "text/plain",
                           ".csv")),
        tags$hr(),
        h4("Parameters for Data Loading"),
        radioButtons("sep", "Separator",
                     choices=c(Comma=",", Semicolon=";",Tab="\t"),
                     selected=","),
        
        radioButtons("quote","Quote",
                     choices=c(None="", 
                               "Double Quote" = '"',
                               "Single Quote"="'")),
        tags$hr(),
        h4("Regression Type"),
        radioButtons("method","Regression Type",
                     choices=c("Binomial"="binomial",
                               "Gaussian"="gaussian",
                               "Poisson"="poisson",
                               "Gamma"="gamma")),
        h4("Predictor Value:"),
        uiOutput("slider")
        
    ),
    
    
    mainPanel(
        tabsetPanel(type = "tabs", 
                    tabPanel("Data Table",br(),
                             h3("Loaded Data Table"),
                             tableOutput("dataTable"),
                             h4("Predicted value of y:"),
                             textOutput("PredOut")
                             ),
                    tabPanel("Model Summary",br(),
                             h3("Model Summary"),
                             verbatimTextOutput("ModelText")),
                    tabPanel("Scatter Plot", br(),
                             h3("Scatter Plot and Prediction"),
                             plotOutput("plot1")),
                    tabPanel("Using this Application", br(),
                             h2("Step-by-step Guidance on this Application"),
                             h3("Summary"),
                             h6("This application allows users to load a dataset and perform regression analysis on the data"),
                             h3("Data File:"),
                             h6("Data file to be loaded into the apps should be a .csv file with two columns. Headers should be included with predictor 'x' and dependent variable'y'"),
                             h3("Parameters for Data Loading:"),
                             h6("'Separator' and 'Quote' are to be set according to the formatting of the .csv file"),
                             h3("Regression Type:"),
                             h6("The type are to be chosen based on the type of data and regression models to be use"),
                             h3("Predictor Value:"),
                             h6("Predictor value is set by user and the predicted value of 'y' will be returned"),
                             h3("Output Tabs:"),
                             h6("- Data Table: Data loaded by user and predicted value of 'y'"),
                             h6("- Model Summary: Summary of the resulted regression model"),
                             h6("- Scatter Plot: Scatter plot of the loaded data with regression line. The predicted data point is also highlighted.")))
                    
                   
                     )

        )
  ))



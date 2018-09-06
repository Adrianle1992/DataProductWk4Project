

library(shiny)
library(sp)
library(ggplot2)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
    df <- reactive({
        read.csv(input$file1$datapath,
                   header = TRUE,
                   sep = input$sep,
                   quote = input$quote)
    })
    
    FitModel<-reactive({
        glm(y~x,data=df(),family=input$method)
    })
    
 
    output$dataTable <- renderTable({
       print(df())
    })
    
    
    output$ModelText <- renderPrint({
        summary(FitModel())
    })
    output$PredOut<- renderText({
        predict(FitModel(),newdata=data.frame(x=input$inSlider))
    })
    
    output$slider <- renderUI({
            sliderInput("inSlider", "Predictor Value", 
                        min=min(df()$x,na.rm=TRUE), 
                        max=max(df()$x,na.rm=TRUE), 
                        value=mean(df()$x))
    })
    
    
    output$plot1<-renderPlot({
      fitData<-data.frame(x=seq(min(df()$x),max(df()$x),length.out = 100))
      yfit<-predict(FitModel(),newdata=fitData)
      fitData$y<-yfit
      x_pred <-input$inSlider
      y_pred <-predict(FitModel(),newdata=data.frame(x=input$inSlider))
      ggplot(df(),aes(x,y))+
            geom_point(color="black") +
            geom_line(aes(x,y),fitData,method="smooth",color="red")+
            geom_point(aes(x_pred,y_pred), color="red", size=4)
     })
    
  
  

})

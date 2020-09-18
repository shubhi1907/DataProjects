
library(shiny)

library(plotly)

library(ggplot2)


d<- read.csv(file.choose(), header=T,sep = ",")

attach(d)


#d=na.omit(d)


ui<-fluidPage(sidebarPanel(
  
  selectInput(inputId = "y", label="y-axis:", width = "auto", choices = c("English" = "Escaleds"
                                                                                     ),selected = "Escaleds"),

   selectInput(inputId = "x",
  
               label = "X-axis:",
  
               choices = c("Graduation_Year" = "Year.of.Graduation",
                           "Grade_Level" = "Student.Grade.Level",
                           "Performance" = "S.Performance",
                           "School" = "Schname1" 
                           ),selected = "Year.of.Graduation"),
  
  
  #sliderInput(data$CLASS,label = "CLASS", min = 2013,max =2025,value = c(2013,2025))),
  
  mainPanel( plotOutput(outputId = "LineChart",width = "900"), width = "900",
             
             textOutput(outputId = "text1") 
             ) )) 




server<-function(input,output) {output$text1<-renderText({
  
  paste("The chart shows the Mcas scores of Ell's and non-Ell's for all the watertown schools")})

output$LineChart <- renderPlot({
    ggplot(data = d, aes_string(x=input$x, y=input$y, fill=factor(Ever.Ell1)), size = "auto") + 
    geom_bar(position = "dodge", stat = "identity") + ylab(input$y) + 
    xlab(input$x) + theme(legend.position="bottom" 
                                ,plot.title = element_text(size=15, face="bold")) + 
    ggtitle("English Language Learner's MCAS Score Group by School") + labs(fill = "ELL")
 # ggplot(data = d, aes_string(x = input$x,y = input$y, fill = as.factor(Ever.Ell1))) 
  #+    geom_smooth(method = "lm", se=FALSE, show.legend=TRUE)
  
  
  
})

}

shinyApp(ui = ui, server = server)
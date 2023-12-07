
if (!require("shiny")) install.packages("shiny")
if (!require("shinythemes")) install.packages("shinythemes")
if (!require("shinyjs")) install.packages("shinyjs")
if (!require("tuneR")) install.packages("tuneR")
if (!require("e1071")) install.packages("e1071")
if (!require("randomForest")) install.packages("randomForest")

library(shiny)
library(shinythemes)
library(shinyjs)
library(tuneR)
library(e1071)
library(randomForest)

# UI
ui <- fluidPage(
  useShinyjs(),
  theme = shinytheme("cerulean"),
  titlePanel("Voice Gender Recognition"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Upload a WAV file"),
      br(),
      actionButton("play", "Play"),
      actionButton("stop", "Stop"),
      br(),
      selectInput("algorithm", "Select an algorithm", choices = c("SVM", "Random Forest")),
      br(),
      actionButton("predict", "Predict"),
      br(),
      textOutput("result")
    ),
    mainPanel(
      plotOutput("waveform")
    )
  )
)

# Server
server <- function(input, output) {
  
  observeEvent(input$file, {
    file <- input$file$datapath
    wave <- readWave(file)
    output$waveform <- renderPlot({
      plot(wave, main = "Waveform", xlab = "Time (s)", ylab = "Amplitude")
    })
  })
  

  observeEvent(input$play, {
    file <- input$file$datapath
    wave <- readWave(file)
    play(wave)
  })
  

  observeEvent(input$stop, {
    stopPlayback()
  })
  
  
  observeEvent(input$predict, {
    if (!is.null(input$file)) {
      file <- input$file$datapath
      wave <- readWave(file)
      features <- data.frame(
        meanfreq = mean(wave@left),
        sd = sd(wave@left)
      )
      
      if (input$algorithm == "SVM") {
       
        prediction <- ifelse(features$meanfreq > 0.15, "male", "female")
      } else {
        
      }
      
      output$result <- renderText({
        if (prediction == "male") {
          "The speaker is male."
        } else {
          "The speaker is female."
        }
      })
    } else {
      output$result <- renderText({
        "Please select an audio file first."
      })
    }
  })
}

shinyApp(ui, server)
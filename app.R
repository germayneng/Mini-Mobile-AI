#' loading libraries
#'==================== 
library(ygdashboard)
library(shiny)
library(rwunderground)
library(cognizer)
#'
#'
#'loading functions 
#'=================
source("functions/googlefunctions.R")
#'
#'
#'loading api keys 
#'==================
rwunderground::set_api_key("")
location = set_location(PWS_id = "")
#'==================
username_TTS <-""
password_TTS <- ""
TEXT_TO_SPEECH_USERNAME_PASSWORD = paste(username_TTS,":",password_TTS,sep="")

#' UI
#' 
#' 
#' 

ui <- fluidPage(
      singleton(tags$head(tags$script(src="js/annyang.min.js"),includeScript('init.js'))),
      
      
      fluidRow(column(width = 10, 
                      tags$div(tags$img(src="dog.gif", style="width:auto; height:300px;"),
                               tags$div(class="direct-chat-text", style = "display:inline-block", 
                      h2(uiOutput("shiba.answer"))))
                      )
              ),
      
      fluidRow(box(status = "primary", solidHeader = TRUE, textOutput("shiba.question"), helpText("command line: Rusty *anything*")))
        ,fluidRow(uiOutput("play"), actionButton("gobutton","play"))
      ## for testing (input box)
        ,fluidRow(box(textInput("shibaa","Question")))
  
  
  
              ) # end of page 




#' Server
#' 
#' 
#' 
#' 

server <- function(input, output) {
  
  
  
  output$shiba.question <- renderText({paste0("you asked:",aiquestion(),"?")})  
  

  output$shiba.answer <- renderUI({aianswer()$answer})
  
  
  
  
  # reactive to store our question asked 
  aiquestion <- reactive({input$shibaa
    
  })
  
  
  
  
  # algorithm to generate answer
  
  
  
  aianswer <- reactive({
    
    question <- aiquestion()
    answer <- ""
    
    
    if (length(question) > 0 )  
      
    {
      df <- sapply(strsplit(question, " "),
                   function(x)as.character(x))
      
      
      # checks initalize
      best <- 0 
      food <- 0
      singapore <- 0
      account <- 0 
      worst <- 0
      vertical <- 0
      region <- 0 
      hello <- 0 
      there <- 0
      help <- 0
      you <- 0
      thank <- 0
      weather <- 0
      #time 
      today <- 0
      tomorrow <- 0
      # check length of df
      
      h <- length(df)
      
      
      if (h == 1) {
        
        if(df[1] == "hello") {
          hello <- 1
        } 
        if(df[1] == "weather") {
          weather <- 1
        } 
        
        
      } else {
        
        for (i in 1:h) {
          
          if(df[i] == "account"){
            account <- 1
          }
          
          if(df[i] == "food"){
            food <- 1
          }
          if(df[i] == "singapore"){
            singapore <- 1
          }
          
          if(df[i] == "best"){
            best <- 1
          }
          
          if(df[i] == "worst"){
            worst <- 1
          }
          if(df[i] == "hello"){
            hello <- 1
          }
          if(df[i] == "there"){
            there <- 1
          }
          if(df[i] == "help"){
            help <- 1
          }
          if(df[i] == "you"){
            you <- 1
          }
          if(df[i] == "thank"){
            thank <- 1
          }
          if(df[i] == "weather"){
            weather <- 1
          }
          if(df[i]== "today"){
            today <- 1
          }
          if(df[i]== "tomorrow"){
            tomorrow <- 1
          }
            } 
        
      }
      
      
      
      
      
      # answer 
      if (best == 1 & food == 1) {
        answer <- "The best food is chicken rice"
      } else if (hello == 1 & there == 1 ) {
        answer <- "hello"
      } else if (help == 1 & you == 1 ) {
        answer <- "How can I help you?"
      } else if (hello == 1 ) {
        answer <- "Nice to meet you!"
      } else if (thank == 1 & you == 1) {
        answer <- "No problem, good to help you"
      } else if (weather == 1 & today == 1) {
        z <- forecast3day(location,use_metric = TRUE, message = FALSE)
        answer <- paste0(z$date[1],"--", "highest temperature:",z$temp_high[1]," ", "lowest temprature:", z$temp_low[1],
                        " ", "Condition:", z$cond[1], ";", z$p_precip[1],"% chance of Precip.")
        } else if (weather == 1 & tomorrow == 1) {
        z <- forecast3day(location,use_metric = TRUE, message = FALSE)
        answer <- paste0(z$date[2],"--", "highest temperature:",z$temp_high[2]," ", "lowest temprature:", z$temp_low[2],
                        " ", "Condition:", z$cond[2], ";", z$p_precip[2],"% chance of Precip.")
        } else {
        
        # using google 
        
        search.term<-question
        quotes <- "FALSE"
        google.url <- getGoogleURL(search.term=search.term, quotes=quotes)
        #
        links <- getGoogleLinks(google.url)
        #
        if(length(links)>0)
        {
          for(i in 1:length(links))
          {
            if(i==1)
            {
              answer <- xmlValue(links[[1]])
              answer <- as.character(answer)
            } 
            else
            {
              answer <- c(answer,xmlValue(links[[i]]))
              answer <- as.character(answer)
            }
          }
        }
        
        
        
        
      }
      
    }
    
    
    
    
    list(answer = answer)
    
  })
  
  
  observeEvent(input$gobutton,{
    unlink("www/*.wav")
    text_audio(aianswer()$answer, TEXT_TO_SPEECH_USERNAME_PASSWORD, directory = 'www', accept = "audio/wav")
    file.rename("www/1.wav", paste0("www/number",input$gobutton,".wav"))
    output$play <- renderUI(
      tags$audio(src = paste0("temp.wav"), type = "audio/wav", controls = NA)
    )
    output$play <- renderUI(
      tags$audio(src = paste0("number", input$gobutton,".wav"), type = "audio/wav", autoplay = TRUE)
    )
    
  })
   
   
                                  }

# Run the application 
shinyApp(ui = ui, server = server)


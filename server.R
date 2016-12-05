# nraaResults Server
shinyServer(function(input, output) {
  
####################################################################################################

# Data ####
  
  results.output <- reactive({
    
    if (input$selView == "Search individual competitions"){
    
      # subset data frame with user's selections
      df %>% 
        select(Year
               , Championship
               , Match
               , Grade
               , Name
               , Club
               , Place
               , Score) %>% 
        filter(df$Year          ==  input$selYear &
               df$Championship  ==  input$selChampionship &
               df$Match         ==  input$selMatch &
               df$Grade         ==  input$selGrade) ->
      results
      
    } else if (input$selView == "Search all results by name") { 
      
      df %>% 
        select(Year
               , Championship
               , Match
               , Grade
               , Name
               , Club
               , Place
               , Score) %>% 
        filter(df$Name == input$selNm) ->
      results
      
    } else if (input$selView == "Search all results by club") {
    
      df %>% 
        select(Year
               , Championship
               , Match
               , Grade
               , Name
               , Club
               , Place
               , Score) %>% 
        filter(df$Club == input$selClb) ->
      results
      
    }
    
    # print object
    results
               
  })
  
####################################################################################################
  
  # Outputs ####
   
  output$results <- renderDataTable({
  
    results.output()
  
  }, options = list(paging = FALSE
                    , autoWidth = TRUE
                    , columnDefs = list(list(width = '125px', targets = c(3,4,5,6))))
  )
  
####################################################################################################
  
  # Download ####
  
  # Switch for download's filename
  dwnld.nm <- reactive({
    
    switch(input$selView
    , "Search all results by name"     = input$selNm
    , "Search all results by club"     = input$selClb
    , "Search individual competitions" = paste(input$selYear, input$selChampionship
                                               , input$selMatch, input$selGrade, sep = "_")
    )

  })
  
#__________________________________________________________________________________________________#
  
  # Download handler
  output$download <- downloadHandler(
    
    filename = function() {
      paste0(dwnld.nm(),"_Results.csv")
    }, 
    content = function(file) {
      write_csv(results.output(), file)
    }
  
  )

####################################################################################################  

}) 
# nraaResults Server
shinyServer(function(input, output) {
  
####################################################################################################

# Data ####
  
  results.output <- reactive({
    
    if (input$selView == "Queens Prize Honour Board"){
      
      # group historical results by winner
      df %>%
        select(everything()) %>% 
        filter(Winner != 'NA') %>%
        group_by(Winner) %>%
        summarise(`Queens Prize Count` = n()) %>%
        arrange(desc(`Queens Prize Count`)) ->
      results
      
    } else if (input$selView == "Search individual competitions from 2014 onwards"){
    
      # subset data frame with user's selections
      df2 %>% 
        select(Year
               , Championship
               , Match
               , Grade
               , Name
               , Club
               , Place
               , Score) %>% 
        filter(df2$Year          ==  input$selYear &
               df2$Championship  ==  input$selChampionship &
               df2$Match         ==  input$selMatch &
               df2$Grade         ==  input$selGrade) ->
      results
      
    } else if (input$selView == "Search results from 2014 onwards by name") { 
      
      df2 %>% 
        select(Year
               , Championship
               , Match
               , Grade
               , Name
               , Club
               , Place
               , Score) %>% 
        filter(df2$Name == input$selNm) ->
      results
      
    } else if (input$selView == "Search results from 2014 onwards by club") {
    
      df2 %>% 
        select(Year
               , Championship
               , Match
               , Grade
               , Name
               , Club
               , Place
               , Score) %>% 
        filter(df2$Club == input$selClb) ->
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
                    , columnDefs = list(list(className = 'dt-center', targets = c("_all")))))
  
  
  
####################################################################################################
  
  # Download ####
  
  # Switch for download's filename
  dwnld.nm <- reactive({
    
    switch(input$selView
    , "Queens Prize Honour Board"                        = "Queens_Prize_Honour_Board"
    , "Search results from 2014 onwards by name"         = input$selNm
    , "Search results from 2014 onwards by club"         = input$selClb
    , "Search individual competitions from 2014 onwards" = paste(input$selYear, input$selChampionship
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
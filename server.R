# nraaResults Server
shinyServer(function(input, output) {
  
####################################################################################################

# Data ####
  
  results.output <- reactive({
    
    if (input$selView == "Kings/Queens Prize Honour Board"){
    
      if (input$selHnrBrdNm == "Select name from list"){
      
        # group historical results by winner
        df %>%
          select(everything()) %>% 
          filter(Winner != 'NA') %>%
          group_by(Winner) %>%
          summarise(`Kings/Queens Prize Count` = n()) %>%
          arrange(desc(`Kings/Queens Prize Count`)) ->
        results
        
      } else {
        
        # subset data frame with user's selections
        df %>% 
          select(Year
                 , Winner
                 , `Kings/Queens Prize` = State) %>% 
          filter(Winner != 'NA' &
                 Winner == input$selHnrBrdNm) %>%
          arrange(desc(Year)) ->
        results
        
      }
      
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
  
  # data table
  output$results <- renderDataTable({
  
    results.output()
  
  }, options = list(paging = FALSE
                    , columnDefs = list(list(className = 'dt-center', targets = c("_all")))))
  
#__________________________________________________________________________________________________#
  
  # plot
  output$plot <- renderPlotly({
    
    if (input$selView == "Kings/Queens Prize Honour Board" &
        input$selHnrBrdNm == "Select name from list"){
      
      # top 10 by Kings/Queens Prize Count
      results.output() %>% 
        top_n(n = 10) ->
      results.top
      
      # get order for x axis
      x.order <- list(results.top$Winner)
      
      # plot
      p <- plot_ly(results.top, x = ~Winner, y=~`Kings/Queens Prize Count`, type = "bar") %>%
           layout(title = paste0("Top 10 Kings/Queens Winners")
                  , xaxis = list(title = "", categoryorder = "array", categoryarray = x.order)
                  , yaxis = list(title = "")
                  , margin = list(l = 20, t = 40, r = 35, b = 55)) %>%
           config(displaymodebar = FALSE)
      
      
    } else if (input$selView == "Kings/Queens Prize Honour Board" &
               input$selHnrBrdNm != "Select name from list") {
      
      # plot
      p <- plot_ly(results.output(), x = ~`Kings/Queens Prize`, type = "histogram") %>%
           layout(title = paste0(input$selHnrBrdNm, " - Wins by Location")
                  , xaxis = list(title = "")
                  , yaxis = list(dtick = 1)
                  , margin = list(l = 20, t = 40, r = 20, b = 50)) %>%
           config(displaymodebar = FALSE)
      
    } else {
      
      p <- plotly_empty()
      
    }
    
    # print object
    p
  
  })
  
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
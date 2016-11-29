# nraaResults Server
shinyServer(function(input, output) {
  
####################################################################################################

# Data ####
  
  results.output <- reactive({
    
    # subset data frame with user's selections
    df %>% 
      select(`Preferred Name`
             , `Last Name`
             , Club
             , State
             , Info
             , Score) %>% 
      filter(df$Year          ==  input$selYear &
             df$Championship  ==  input$selChampionship &
             df$Match         ==  input$selMatch &
             df$Grade         ==  input$selGrade) ->
    results
               
  })
  
#__________________________________________________________________________________________________#

  entrants.output <- reactive({
    
    # grade order
    grade.order <- c("Target Rifle - A","Target Rifle - B","Target Rifle - C","F Standard - A"
                     ,"F Standard - B","F Open - FO","F/TR - A")
    
    # calculate data for entrants plot
    df %>%
      select(everything()) %>% 
      group_by(Year
               , Championship
               , Match
               , Grade) %>%
      summarise(Entrants = n()) %>% 
      slice(match(grade.order, Grade)) ->
    table
    
    # subset by user's selections
    table <- subset(table, 
                    table$Year         == input$selYear &
                    table$Championship == input$selChampionship &
                    table$Match        == input$selMatch)
    
    # abbreviate names and match with grade.order 
    table$Grade <- c("TR-A", "TR-B", "TR-C", "FS-A", "FS-B", "FO", "F/TR")
    
    # print object
    table
                      
  })
  
####################################################################################################
  
  # Outputs ####
   
  output$results <- renderDataTable({
  
    results.output()
  
  }, options = list(paging = FALSE))
  
#__________________________________________________________________________________________________#

  output$entrants <- renderPlotly({
    
    x.order <- list("TR-A", "TR-B", "TR-C", "FS-A", "FS-B", "FO", "F/TR")
  
    p <- plot_ly(entrants.output()
                , x = ~Grade
                , y = ~Entrants
                , type = "bar") %>%
         layout(title = "Count of Entrants by Grade"
                , xaxis = list(title = "", categoryorder = "array", categoryarray = x.order)
                , margin = list(t = 80)) %>% 
         config(displayModeBar = F)
         
    
    # print object
    p
    
  })
  
####################################################################################################

}) 
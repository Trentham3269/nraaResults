# nraaResults UI
shinyUI( 
  fluidPage(
    # include Google Analytics
    tags$head(includeScript("www/google-analytics.js"))
    
    , h2(titlePanel("National Rifle Association of Australia"))
    , h3(titlePanel("Target Rifle and F-Class Queens Prize Results"))
    , br()
    , sidebarLayout(
      # sidebar ui inputs
      sidebarPanel(width = 3
        , radioButtons(inputId = "selView"
                       , label = "Choose view:"
                       , choices = c("Search all results by name"
                                     , "Search all results by club"
                                     , "Search individual competitions"))
        , br()
        , conditionalPanel(condition = "input.selView == 'Search individual competitions'"
          , selectInput(inputId = "selYear"
                        , label = "Calendar Year:"
                        , choices = levels(factor(df$Year)))
          , selectInput(inputId = "selChampionship"
                        , label = "Championship (in annual date order):"
                        , choices = c("TRA","VRA","SARA","NQRA","NTRA","NRAA","QRA","NSWRA","ACTRA"))
          , selectInput(inputId = "selMatch"
                        , label = "Match:" 
                        , choices = c("Leadup","Queens","Grand"))
          , selectInput(inputId = "selGrade"
                        , label = "Grade:"
                        , choices = c("Target Rifle - A","Target Rifle - B","Target Rifle - C",
                                      "F Standard - A","F Standard - B","F Open - FO", "F/TR - A"))
        )
        , br()
        , conditionalPanel(condition = "input.selView == 'Search all results by name'"
          , selectInput(inputId = "selNm"
                        , label = "Choose Name:"
                        , choices = c("Select name from list", sort(unique(df$Name))))
        )
        , br()
        , conditionalPanel(condition = "input.selView == 'Search all results by club'"
          , selectInput(inputId = "selClb"
                        , label = "Choose Club:"
                        , choices = c("Select club from list", sort(unique(df$Club))))
        )
        , br()
        , downloadButton(outputId = "download"
                       , label = "Download Data"
                       , class = "btn-primary")
      ), 
        
      # data table
      mainPanel( 
        dataTableOutput("results")   
      ) 
    ) 
  )
)




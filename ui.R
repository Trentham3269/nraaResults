# nraaResults UI
shinyUI( 
  fluidPage(theme = "bootswatch-v3.3.7-spacelab"
    , titlePanel(h2("National Rifle Association of Australia"))
    , titlePanel(h3("Target Rifle and F-Class Queens Prize Results"))
    , br()
    , sidebarLayout(
      # sidebar ui inputs
      sidebarPanel(width = 3
        , radioButtons(inputId = "selView"
                       , label = "Choose view:"
                       , choices = c("Search all results by name"
                                     , "Search all results by club"
                                     , "Search individual competitions"))
        , conditionalPanel(condition = "input.selView == 'Search individual competitions'"
          , selectInput(inputId = "selYear"
                        , label = "Calendar Year:"
                        , choices = levels(factor(df$Year)))
          , selectInput(inputId = "selChampionship"
                        , label = "Championship (in annual date order):"
                        , choices = c("TRA","VRA","SARA","NQRA","NTRA","NRAA","QRA","NSWRA","ACT"))
          , selectInput(inputId = "selMatch"
                        , label = "Match:" 
                        , choices = c("LEADUP","QUEENS","GRAND AGGREGATE"))
          , selectInput(inputId = "selGrade"
                        , label = "Grade:"
                        , choices = c("Target Rifle - A","Target Rifle - B","Target Rifle - C",
                                      "F Standard - A","F Standard - B","F Open - FO", "F/TR - A"))
        ),
        conditionalPanel(condition = "input.selView == 'Search all results by name'"
          , selectInput(inputId = "selNm"
                        , label = "Choose Name:"
                        , choices = sort(unique(df$Name)))
        ),
        conditionalPanel(condition = "input.selView == 'Search all results by club'"
          , selectInput(inputId = "selClb"
                        , label = "Choose Club:"
                        , choices = sort(unique(df$Club)))
        )
      ), 
        
      # data table
      mainPanel( 
        dataTableOutput("results")   
      ) 
    ) 
  )
)




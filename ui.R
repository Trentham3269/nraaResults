# nraaResults UI
shinyUI( 
  fluidPage( 
    titlePanel(h1("National Rifle Association of Australia"))
    , titlePanel(h2("Target Rifle and F-Class Queens Prize Results"))
    , br()
    , sidebarLayout(
      # sidebar ui inputs
      sidebarPanel(
        selectInput("selYear"
                    , "Calendar Year:"
                    , choices = levels(factor(df$Year)))
        , selectInput("selChampionship"
                    , "Championship (in annual date order):"
                    , choices = c("TRA","VRA","SARA","NQRA","NTRA","NRAA","QRA","NSWRA","ACT"))
        , selectInput("selMatch"
                    , "Match:", 
                    choices = c("LEADUP","QUEENS","GRAND AGGREGATE"))
        , selectInput("selGrade"
                    , "Grade:"
                    , choices = c("Target Rifle - A","Target Rifle - B","Target Rifle - C",
                                  "F Standard - A","F Standard - B","F Open - FO", "F/TR - A"))
        , br()
        , plotlyOutput("entrants")
      ),
      # data table
      mainPanel( 
        dataTableOutput("results")   
      ) 
    ) 
  ) 
) 



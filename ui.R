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
      sidebarPanel(width = 4
        , radioButtons(inputId = "selView"
                       , label = "Choose view:"
                       , choices = c("Queens Prize Honour Board"
                                     , "Search results from 2014 onwards by name"
                                     , "Search results from 2014 onwards by club"
                                     , "Search individual competitions from 2014 onwards")
                       , selected = "Queens Prize Honour Board")
        , br()
        , conditionalPanel(condition = "input.selView == 'Search individual competitions from 2014 onwards'"
          , selectInput(inputId = "selYear"
                        , label = "Calendar Year:"
                        , choices = levels(factor(df2$Year)))
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
        , conditionalPanel(condition = "input.selView == 'Search results from 2014 onwards by name'"
          , selectInput(inputId = "selNm"
                        , label = "Choose Name:"
                        , choices = c("Select name from list", sort(unique(df2$Name))))
        )
        , conditionalPanel(condition = "input.selView == 'Search results from 2014 onwards by club'"
          , selectInput(inputId = "selClb"
                        , label = "Choose Club:"
                        , choices = c("Select club from list", sort(unique(df2$Club))))
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





pageWithSidebar(
        headerPanel('Will This Mushroom Kill Me?'),
        fluidRow(column(12, 
                        "Note:  This data set includes descriptions of hypothetical samples corresponding to 23 species of gilled mushrooms in the Agaricus and Lepiota Family.  DO NOT use for actual identification!!!",
                        style = "background-color:#FF0000;"),
                 column(2, selectInput('OdorInput', 
                                       'Odor', 
                                       unique(DescribedMushrooms$Odor))),
                 column(2, selectInput('SporePrintColorInput', 
                                       'SporePrintColor', 
                                       unique(DescribedMushrooms$SporePrintColor))),
                 column(2, selectInput('GillColorInput', '
                                       GillColor', 
                                       unique(DescribedMushrooms$GillColor))),
                 column(2, selectInput('GillSizeInput', '
                                       GillSize', 
                                       unique(DescribedMushrooms$GillSize))),
                 column(2, selectInput('StalkSurfaceAboveRingInput', 
                                       'StalkSurfaceAboveRing', 
                                       unique(DescribedMushrooms$StalkSurfaceAboveRing))),
                 column(12, htmlOutput("text"),
                        style = "background-color:#FFA500;"),
                 column(12, actionButton("predict", "Determine Probability"))

        ),
        mainPanel(
                tableOutput('table1'),
                plotOutput('plot1')
        )
)

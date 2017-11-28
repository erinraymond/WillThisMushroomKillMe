
function(input, output, session) {
      
        MushroomDF = eventReactive(input$predict,{
                        df <- data.frame(Odor = input$OdorInput,
                                        SporePrintColor = input$SporePrintColorInput,
                                        GillColor = input$GillColorInput,
                                        GillSize = input$GillSizeInput,
                                        StalkSurfaceAboveRing = input$StalkSurfaceAboveRingInput)
                        
                        MushroomCharacteristics = IdentifiedMushrooms[0,]
                        
                        MushroomCharacteristics[1, "Odor"] = df$Odor
                        MushroomCharacteristics[1, "SporePrintColor"] = df$SporePrintColor
                        MushroomCharacteristics[1, "GillColor"] = df$GillColor
                        MushroomCharacteristics[1, "GillSize"] = df$GillSize
                        MushroomCharacteristics[1, "StalkSurfaceAboveRing"] = df$StalkSurfaceAboveRing

                        NewMushroom <- MushroomCharacteristics[-1]

                        df <- predict(ForestOfMushrooms2,
                                                        newdata = NewMushroom,
                                                        type = "prob")
                        
                        return(list(df=df))
                        })

        output$table1 <- renderTable({print(MushroomDF()$df)
                }
                , 'include.rownames' = FALSE, 'include.colnames' = TRUE
        )
        
        output$text <- renderUI({
                HTML("It would be a terrible idea to use a predictive model to determine probability of mushroom poisoning, but click the button anyway :)")
        })
        
        output$plot1 <- renderPlot({AllPlots
        })
}


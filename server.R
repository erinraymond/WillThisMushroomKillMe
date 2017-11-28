
function(input, output, session) {
        
        # Top 5 characheristics
        IdentifiedMushrooms <- DescribedMushrooms%>%
                select(Edibility, Odor, SporePrintColor, GillColor, GillSize, StalkSurfaceAboveRing)
        
        # Build random forest based on top 5 characteristics
        set.seed(456)
        
        inTrain2 <- createDataPartition(y = IdentifiedMushrooms$Edibility, p = 0.75, list = FALSE)
        training2 <- IdentifiedMushrooms[inTrain2,]
        testing2 <- IdentifiedMushrooms[-inTrain2,]
        
        ForestOfMushrooms2 <- randomForest(Edibility ~., data = training2)
        
        # Predict New Mushroom based on Inputs        
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
        
        output$plot1 <- renderPlot({
                OdorPlot <- ggplot(data = DescribedMushrooms, aes(x = Edibility, y = Odor)) +
                        geom_jitter(aes(color = Edibility)) +
                        scale_color_brewer(palette = "Dark2") +
                        theme(legend.position="none")
                
                SporePrintColorPlot <- ggplot(data = DescribedMushrooms, aes(x = Edibility, y = SporePrintColor)) +
                        geom_jitter(aes(color = Edibility)) +
                        scale_color_brewer(palette = "Dark2") +
                        theme(legend.position="none")
                
                GillColorPlot <- ggplot(data = DescribedMushrooms, aes(x = Edibility, y = GillColor)) +
                        geom_jitter(aes(color = Edibility)) +
                        scale_color_brewer(palette = "Dark2") +
                        theme(legend.position="none")
                
                GillSizePlot <- ggplot(data = DescribedMushrooms, aes(x = Edibility, y = GillSize)) +
                        geom_jitter(aes(color = Edibility)) +
                        scale_color_brewer(palette = "Dark2") +
                        theme(legend.position="none")
                
                StalkSurfaceAboveRingPlot <- ggplot(data = DescribedMushrooms, aes(x = Edibility, y = StalkSurfaceAboveRing)) +
                        geom_jitter(aes(color = Edibility)) +
                        scale_color_brewer(palette = "Dark2") +
                        theme(legend.position="none")
                
                plot_grid(OdorPlot, SporePrintColorPlot, GillColorPlot,
                                      GillSizePlot, StalkSurfaceAboveRingPlot,
                                      ncol = 3)
        })
        
}


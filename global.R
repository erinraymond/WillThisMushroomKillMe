library(dplyr)
library(caret)
library(randomForest)
library(ggplot2)
library(cowplot)

DescribedMushrooms <- readRDS("data/MushroomData.rds")

# Top 5 characheristics
IdentifiedMushrooms <- DescribedMushrooms%>%
        select(Edibility, Odor, SporePrintColor, GillColor, GillSize, StalkSurfaceAboveRing)

# Build random forest based on top 5 characteristics
set.seed(456)

inTrain2 <- createDataPartition(y = IdentifiedMushrooms$Edibility, p = 0.75, list = FALSE)
training2 <- IdentifiedMushrooms[inTrain2,]
testing2 <- IdentifiedMushrooms[-inTrain2,]

ForestOfMushrooms2 <- randomForest(Edibility ~., data = training2)

# Plots

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

AllPlots <- plot_grid(OdorPlot, SporePrintColorPlot, GillColorPlot,
                      GillSizePlot, StalkSurfaceAboveRingPlot,
                      ncol = 3)
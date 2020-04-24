# Plot 1
# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#       Using the base plotting system, make a plot showing the total PM2.5 emission
#       from all sources for each of the years 1999, 2002, 2005, and 2008.
# Bar Plot
# X-axis: Year
# Y-axis: total PM2.5 emission per year (megatons)

# Load libraries and data

library(plyr)
library(dplyr)

datadir <- "./NEI_data"
NEI <- readRDS(file.path(datadir,"summarySCC_PM25.rds"))
SCC <- readRDS(file.path(datadir,"Source_Classification_Code.rds"))

# Summarize data with grouping

sumData <- 
        NEI %>%
        select(Emissions,year) %>%
        group_by(year) %>%
        summarise_all(sum)

# Plot the results

png("plot1.png", width=600, height=600)
barplot(
          sumData$Emissions/10^6
        , names.arg = sumData$year
        , xlab = 'Year'
        , ylab = 'PM2.5 Emissions (megatons)'
        , main = 'Total PM2.5 Emissions From All Sources'
        , col = 'lightblue'
        )
dev.off()

# clean up environment as needed
rm(list = ls())


# Yes, emissions appear to have decreased from 1999 to 2008.
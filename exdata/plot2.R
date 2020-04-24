# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#       (\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 2008? 
#       Use the base plotting system to make a plot answering this question.
# Bar Plot
# X-axis: Year
# Y-axis: total PM2.5 emission per year (tons)

# Load libraries and data

library(plyr)
library(dplyr)
if (!(exists("NEI") & exists("SCC"))) {
        source('loaddata.R')
}

# Subset data

baltimore <- "24510"
baltimoreSumData <- 
        NEI %>%
        filter(fips == baltimore) %>%
        select(Emissions,year) %>%
        group_by(year) %>%
        summarise_all(sum)

# Plot the results

png("plot2.png", width=600, height=600)

barplot(
          baltimoreSumData$Emissions
        , names.arg= baltimoreSumData$year
        , xlab= 'Year'
        , ylab= 'PM2.5 Emissions (tons)'
        , main= 'Total PM2.5 Emissions From All Baltimore City Sources'
        , col = 'lightblue'
)

dev.off()

# clean up environment as needed
cleanup <- ls()[!(ls() %in% c("NEI", "SCC"))]
rm(list = cleanup)

## Yes, they have decreased from 1999 to 2008. However, emissions trended upward from 2002 - 2005.

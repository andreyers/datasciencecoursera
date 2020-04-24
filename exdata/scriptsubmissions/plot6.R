# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from 
#       motor vehicle sources in Los Angeles County, California (\color{red}{\verb|fips == "06037"|}fips=="06037").
#       Which city has seen greater changes over time in motor vehicle emissions?
# Multiple bar plots
# X-axis: Year
# Y-axis: Total PM2.5 emissions (megatons)
# Special data subset

# Load libraries and data

library(plyr)
library(dplyr)
library(ggplot2)

datadir <- "./NEI_data"
NEI <- readRDS(file.path(datadir,"summarySCC_PM25.rds"))
SCC <- readRDS(file.path(datadir,"Source_Classification_Code.rds"))

# Subset SCC data to find vehicle sources
vehiclesSCC <- 
        SCC %>%
        filter(grepl('vehicle',SCC.Level.Two, ignore.case=TRUE)) %>%
        distinct(SCC)

# Baltimore NEI and vehicles data

baltimore <- '24510'
lacounty <- '06037' 

baltimoreNEI <-
        NEI %>%
        filter(SCC %in% vehiclesSCC[,1]) %>%
        filter(fips == baltimore) %>%
        mutate(fips, location = "Baltimore")

lacountyNEI <-
        NEI %>%
        filter(SCC %in% vehiclesSCC[,1]) %>%
        filter(fips == lacounty) %>%
        mutate(fips, location = "Los Angeles County")

bothNEI <- rbind(baltimoreNEI, lacountyNEI)

# Plot the data

png('plot6.png', width=600, height=600)
ggp <- ggplot(bothNEI, aes(factor(year), Emissions, fill=location)) +
        geom_bar(stat='identity') +
        facet_grid(scales='free', space='free', .~location) +
        guides(fill=FALSE) +
        labs(x='Year', y=expression("Total PM"[2.5]*" Emission (tons)")) + 
        labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions, 1999-2008"), subtitle = "in Baltimore and Los Angeles County")
print(ggp)
dev.off()

# clean up environment as needed
rm(list = ls())

# Los Angeles County has a significantly larger amount of total emissions compared to Baltimore.
# It also sees the greatest variability over 1999-2008. Overall, it increases from 1999-2008.
# In Baltimore, total emissions have decreased from 1999-2008.
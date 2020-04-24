# 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# Bar plot
# X-axis: Year
# Y-axis: Total PM2.5 emissions (tons)
# Special data subset *vehicle sources in Baltimore

# Load libraries and data

library(plyr)
library(dplyr)
library(ggplot2)
if (!(exists("NEI") & exists("SCC"))) {
        source('loaddata.R')
}

# Subset SCC data to find vehicle sources
vehiclesSCC <- 
        SCC %>%
        filter(grepl('vehicle',SCC.Level.Two, ignore.case=TRUE)) %>%
        distinct(SCC)

# Baltimore NEI and vehicles data

baltimore <- "24510"

baltimorevehiclesNEI <-
        NEI %>%
        filter(SCC %in% vehiclesSCC[,1]) %>%
        filter(fips == baltimore) 

# Plot the data

png("plot5.png", width=600, height=600)

ggp <- ggplot(baltimorevehiclesNEI, aes(factor(year),Emissions)) +
        geom_bar(stat='identity', fill ='lightblue') +
        labs(x='Year', y=expression('Total PM'[2.5]*' Emission (tons)')) + 
        labs(title=expression('PM'[2.5]*' Motor Vehicle Source Emissions in Baltimore from 1999-2008'))
print(ggp)

dev.off()

# clean up environment as needed
cleanup <- ls()[!(ls() %in% c("NEI", "SCC"))]
rm(list = cleanup)

# Baltimore's PM2.5 emissions from vehicles drastically reduced from 1999-2002.
# Overall, Baltimore's emissions were reduced from 1999-2008.

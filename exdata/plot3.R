# 3. Of the four types of sources indicated by the \color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad)
#       variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#       Which have seen increases in emissions from 1999–2008? 
#       Use the ggplot2 plotting system to make a plot answer this question.
# Multiple bar plots, one for each source
# X-axis: Year
# Y-axis: Total PM2.5 emissions (tons)

# Load libraries and data

library(plyr)
library(dplyr)
library(ggplot2)
if (!(exists("NEI") & exists("SCC"))) {
        source('loaddata.R')
}

# Subset data

baltimore <- "24510"
sourceSumData <- 
        NEI %>%
        filter(fips == baltimore) %>%
        select(Emissions,year,type) %>%
        group_by(type,year) %>%
        summarise_all(sum)

# Plot data

png('plot3.png', width=600, height=600)

ggp <- ggplot(sourceSumData, aes(factor(year), Emissions, fill=type))+
        geom_bar(stat='identity')+
        facet_grid(.~type, scales='free', space='free')+
        labs(x='Year', y=expression('Total PM'[2.5]*' Emission (tons)'))+
        labs(title=expression('PM'[2.5]*' Emissions in Baltimore 1999-2008'), subtitle='by Source Type')+
        theme_bw()+
        guides(fill=FALSE)
print(ggp)

dev.off()

# clean up environment as needed
cleanup <- ls()[!(ls() %in% c("NEI", "SCC"))]
rm(list = cleanup)

# NON-ROAD, NONPOINT, and ON-ROAD source types have seen year to year decreases in emission. 
# POINT source types saw an overall increase, with a rapid increase from 1999 - 2002. A sharp drop-off is seen in 2008,
# however, total emissions were still larger in 2008 than in 1999.

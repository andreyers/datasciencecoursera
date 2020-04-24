# 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
# Bar plot
# X-axis: Year
# Y-axis: Total PM2.5 emissions (tons)
# Special data subset * coal combustion sources across the US

# Load libraries and data

library(plyr)
library(dplyr)
library(ggplot2)
if (!(exists("NEI") & exists("SCC"))) {
        source('loaddata.R')
}

# Subset SCC data to find combustion and coal related SCCs

coalcombSCC <- 
        SCC %>%
        filter(grepl("comb", SCC.Level.One, ignore.case=TRUE) | grepl("comb", SCC.Level.Two, ignore.case=TRUE)) %>%
        filter(grepl("\\<coal", SCC.Level.Three, ignore.case=TRUE) | grepl("\\<coal", SCC.Level.Four, ignore.case=TRUE)) %>%
        distinct(SCC)

coalcombNEI <- NEI[NEI$SCC %in% coalcombSCC[,1], ]

# Plot data

png('plot4.png', width=600, height=600)

ggp <- ggplot(coalcombNEI, aes(factor(year),Emissions/10^6)) +
        geom_bar(stat='identity',fill='lightblue') +
        labs(x='Year', y=expression('Total PM'[2.5]*' Emission (megatons)')) + 
        labs(title=expression('PM'[2.5]*' Coal Combustion Source Emissions Across US from 1999-2008'))
print(ggp)

dev.off()

# clean up environment as needed
cleanup <- ls()[!(ls() %in% c("NEI", "SCC"))]
rm(list = cleanup)

# Coal combustion has decreased from 1999-2008, with the sharpest decrease from 2005-2008.
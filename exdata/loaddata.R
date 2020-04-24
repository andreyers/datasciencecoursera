# Define data directory and necessary libraries

library(utils)
datadir <- "./NEI_data"
zipfile <- "exdata_data_NEI_data.zip"
pm25rds <- "summarySCC_PM25.rds"
classrds <- "Source_Classification_Code.rds"

# Check if data or zipped data exists. Download data if not available.

setwd(datadir)
if ( !file.exists(pm25rds) | !file.exists(classrds) ) {
        temp <- tempfile()
        if ( !file.exists(zipfile) ) {
                download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp) 
        }
        else {
                temp <- zipfile
        }
        unzip(temp)
        unlink(temp)
}
setwd('..')

# Load data into R

NEI <- readRDS(file.path(datadir,"summarySCC_PM25.rds"))
SCC <- readRDS(file.path(datadir,"Source_Classification_Code.rds"))


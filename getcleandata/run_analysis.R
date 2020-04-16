## Project Directions
# The run_analysis.R script does the following: 
# 1. Merges the training and the test sets to create one data set. 
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set 
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set  
#    with the average of each variable for each activity and each subject.  

## Script Description:
# The following script tidies and saves accelerometer data from Samsung Galaxy S phones 
# and creates a second dataset with analysis (average) for each variable.

## Script Author:
# [Andrea Villaroman](https://github.com/andreyers)

# Define data directory and necessary libraries
datadir <- "./UCI HAR Dataset"
library(plyr)
library(utils)
library(dplyr)

# Check if data directory exists and if there is data!

if ( !dir.exists(datadir) | length(list.files(datadir))==0 ) {
        temp <- tempfile()
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp) 
        unzip(temp)
        unlink(temp)
}

# Read data into R

features <- read.table(file.path(datadir, "features.txt"))
features <- as.character(features[,2])

trainingData <- data.frame(
        read.csv(file.path(datadir,"train/subject_train.txt"), header=FALSE, sep = " "),
        read.csv(file.path(datadir,"train/y_train.txt"), header=FALSE, sep = " "),
        read.table(file.path(datadir,"train/X_train.txt")))
names(trainingData) <- c(c('subject', 'activity'), features)

testingData <- data.frame(
        read.csv(file.path(datadir,"test/subject_test.txt"), header=FALSE, sep = " "),
        read.csv(file.path(datadir,"test/y_test.txt"), header=FALSE, sep = " "),
        read.table(file.path(datadir,"test/X_test.txt"))
)
names(testingData) <- c(c('subject','activity'), features)


## 1. Merge testing and training data

allData <- rbind(trainingData, testingData)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

# search location of 'features' for anything with 'mean' or 'std'
namesMeansStd <- grep('mean|std', names(allData))

# subset data using above indices
subsetData <- allData[,c(1,2,namesMeansStd)]

## 3. Uses descriptive activity names to name the activities in the data set 

activityLabels <- read.table(file.path(datadir,"activity_labels.txt"))
activityLabels <- as.character(activityLabels[,2])

subsetData$activity <- mapvalues(subsetData$activity, c(1:6), activityLabels)

## 4. Label the data with descriptive variable names

betternames <- names(subsetData)

betternames <- gsub("[(][)]", "", betternames)
betternames <- gsub("^t", "TimeDomain_", betternames)
betternames <- gsub("^f", "FrequencyDomain_", betternames)
betternames <- gsub("Acc", "Accelerometer", betternames)
betternames <- gsub("Gyro", "Gyroscope", betternames)
betternames <- gsub("Mag", "Magnitude", betternames)
betternames <- gsub("-mean-", "_Mean_", betternames)
betternames <- gsub("-std-", "_StandardDeviation_", betternames)
betternames <- gsub("-", "_", betternames)

names(subsetData) <- betternames

## 5. Create a data set with the average of each var for each activity & subject.

averageData <- 
        subsetData %>%
        group_by(subject, activity) %>%
        summarise_all(mean)

write.table(averageData, "UCIHAR_averageData.txt", row.names = FALSE)
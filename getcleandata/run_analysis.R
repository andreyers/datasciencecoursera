## Project Directions 
## The run_analysis.R script does the following: 
## 1. Merges the training and the test sets to create one data set. 
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set 
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set  
##    with the average of each variable for each activity and each subject.  

## The following script tidies and saves accelerometer data from Samsung Galaxy S phones 
## and creates a second dataset with analysis (average) for each variable.

# Define data directory and necessary libraries
datadir <- "./UCI HAR Dataset"
library(plyr)

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
        read.table(file.path(datadir,"train/subject_train.txt")),
        read.table(file.path(datadir,"train/y_train.txt")),
        read.table(file.path(datadir,"train/X_train.txt")))
names(trainingData) <- c(c('subject', 'activity'), features)

testingData <- data.frame(
        read.table(file.path(datadir,"test/subject_test.txt")),
        read.table(file.path(datadir,"test/X_test.txt")),
        read.table(file.path(datadir,"test/y_test.txt")))
names(testingData) <- c(c('subject','activity'), features)


## 1. Merge testing and training data

allData <- rbind(trainingData, testingData)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

# search location of 'features' for anything with 'mean' or 'std'
namesMeansStd <- grep('mean|std', names(allData))

# subset data using above indices
subsetData <- allData[,c(1,2,namesMeansStd)]

#subsetData[c(1:10),c(1:3)]

## 3. Uses descriptive activity names to name the activities in the data set 

activityLabels <- read.table(file.path(datadir,"activity_labels.txt"))
activityLabels <- as.character(activityLabels[,2])

mapvalues(subsetData$activity, c(1:6), activityLabels)

## 4. Label the data with descriptive variable names

betternames <- matrix( nrow=8, ncol=2, byrow = TRUE,
            c("[(][)]", "",
              "^f", "FrequencyDomain_",
              "Acc", "Accelerometer",
              "Gyro", "Gyroscope",
              "Mag", "Magnitude",
              "-mean-", "_Mean_",
              "-std-", "_StandardDeviation_",
              "-", "_")
)

mapvalues(names(subsetData), betternames[,1], betternames[,2], regex=TRUE)

## 5. Create a data set with the average of each var for each activity & subject.

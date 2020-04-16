# UCI HAR Averages Analysis

========================================
## Author:
[Andrea Villaroman](https://github.com/andreyers)

========================================
## Project Directions

>Via Coursera "Getting and Cleaning Data" course by John Hopkins University:

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.
 1. Merges the training and the test sets to create one data set. 
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Uses descriptive activity names to name the activities in the data set 
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data set  
    with the average of each variable for each activity and each subject.  

========================================
## Script Description:
 The 'run_analysis.R' script tidies and saves accelerometer data from Samsung Galaxy S phones 
 and creates a second dataset of computed average values of the mean and standard deviation variable.
 The variables are computed by subject and activity.

========================================
## Dataset Files:
* 'readme.md'
* 'codebook.md' - Shows information on identifiers and variables in dataset.
* 'UCIHAR_averageData.txt' - A .txt file copy of dataset with each column separated by ' '. Feature variables are averaged and given for each subject/activity.
* './UCI HAR Dataset' - A copy of the UCI HAR dataset.

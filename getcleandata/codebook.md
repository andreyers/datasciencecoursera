========================================
# CodeBook for AveragesData
# Author: [Andrea Villaroman](https://github.com/andreyers)
========================================
# Data Source

The data represent data collected from the accelerometers from Samsung Galaxy S smartphones in the Human Activity Recognition study at the UCI Machine Learning Repository. A full description is available at the site where the data was obtained is here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data was downloaded from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

========================================
# Labels and Identifiers

* 'subject'	= The subjects for this study are coded with integer values

* 'activity'	= The activity label for the data are numerically encoded in the original database but we have replaced them with their respective character strings:

	* 'WALKING'
	* 'WALKING_UPSTAIRS'
	* 'WALKING_DOWNSTAIRS'
	* 'SITTING'
	* 'STANDING'
	* 'LAYING'

========================================
# Functions

This dataset is an analysis using training and testing data from the original database. Each variable gives the average of each feature studied in that database, grouping by activity of each subject. We use the following function from the base package to calculate the averages:

	* mean()

========================================
# Feature Variables

Please see the README.txt and features_info.txt files in the original dataset to learn more about the feature selection for this dataset. Relevant information is cited below:
-----
>The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

>Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

>Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

>These signals were used to estimate variables of the feature vector for each pattern:  
>'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

>tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

>Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

>gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

>The complete list of variables of each feature vector is available in 'features.txt'

-----

I have removed parentheticals and renamed these variables with descriptive, tidier names using the following replacements:

* f = FrequencyDomain
* t = TimeDomain
* Acc = Accelerometer
* Gyro = Gyroscope
* Mag = Magnitude
* mean = Mean
* std = Standard Deviation
* - = _

========================================
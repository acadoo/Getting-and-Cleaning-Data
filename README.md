# Readme 

This document describes the code inside ```run_analysis.R``` that is in this folder.

## The data source

* Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Course Project 
 You should create one R script called run_analysis.R that does the following. 
	* Merges the training and the test sets to create one data set.
	* Extracts only the measurements on the mean and standard deviation for each measurement. 
	* Uses descriptive activity names to name the activities in the data set
	* Appropriately labels the data set with descriptive variable names. 
	* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Good luck!

## Dependencies
```run_analysis.R``` will require ```data.table``` package

#How it works
* First the file will check if you have a data directory in your working directory and create it if needed. 
* Download the zip file if needed and extract it 
* Merged data from the train et test set into variables merged.X merged.Y merged.subject
* Assign right labels
* create a tidy data set with average of each variable
* save result into a file ```data/tidy_data_result.txt```


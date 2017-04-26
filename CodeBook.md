## CodeBook

This is a code book describes the specs for the "data clean up" project, data sources, variables, 
and all transformations used to produce the tiny data.

### Overview

30 volunteers performed 6 different activities while wearing a smartphone. The smartphone captured various 
data points about their movements.


### The data source

Original Dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Experiment Data : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### The data

The dataset includes the following files:


*	'features.txt': Names of 561 features
*	'activity_labels.txt': Names and IDs for each of the 6 activities.
*	'train/X_train.txt': Training set.
*	'train/y_train.txt': Training labels.
*	'test/X_test.txt': Test set.
*	'test/y_test.txt': Test labels.

### Out of Scope

This analysis did not use the raw signal data. Therefore, the data files in the "Inertial Signals" folders were ignored.

### Processing steps

*	Load libraries reshapre2 and data.table that are required to melt and format the data.
*       Download and unzip the data files in the current working directory
*       Load activity, and feature names into the data frames
*       select only the features that have either mean or standard deviation ( sd ) in their column names
*	Load individual test files and create a single file by combining columns from subject test, x test, and y test
*	Load individual training files and create a single file by combining columns from subject training, x train, and y train
*       Merge the test and training files
*       Use descriptive activity names to name the activities in the data set
*       Finally, create a second, independent tidy data set with the average of each variable for each activity and each subject

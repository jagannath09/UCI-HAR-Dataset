## Project - Getting and Cleaning Data

run_analysis.R performs the following data clean up tasks on original human activity data captured through accelerometers 
from the Samsung Galaxy S smartphone

1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement.
3.	Uses descriptive activity names to name the activities in the data set
4.	Labels the data set with descriptive activity names.
5.	Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Steps to generate the tidy data

1.	Keep the run_analysis.R in the current working directory.       
2.	Run source("run_analysis.R"), 
3.      This program first downloads the human acitivity data into current working directory,
        cleans up, and formats the data, finally generates a new file tiny_data.txt in the current working directory.

### Assumption
This R script assumes that reshape2 and data.table libraries are installed in local R studio


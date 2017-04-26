## Run required libraries
library(lubridate)
library(dplyr)

library("data.table")
library("reshape2") # allows to use dcast, melt

## download, format, and read the file
## set the destination file path
f <- file.path(getwd(), "getdata-projectfiles-UCI HAR Dataset.zip")
## downoad file to given destination
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",f)
## unzip household power consumption data file
uzf <- unzip(f)
path <- "./UCI HAR Dataset"

# Load activity labels
activity_labels <- read.table(file.path(path, "activity_labels.txt"))[,2]

# Load column names for all features
features <- read.table(file.path(path,"features.txt"))[,2]

# Extracts labels only for mean and standard deviation .
desired_msrmt <- grepl("mean|std", features)

# Load and process x-test, y-test data
x_test <- read.table(file.path(path,"test", "X_test.txt"), header=FALSE )
y_test <- read.table(file.path(path,"test","y_test.txt"), header=FALSE)
subject_test <- read.table(file.path(path,"test","subject_test.txt"), header=FALSE)

# add labels
names(x_test) = features

# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
x_test=x_test[,desired_msrmt]

# Load activity labels
y_test[,2]= activity_labels[y_test[,1]]
names(y_test)=c("Activity.ID", "Activity.Type")
names(subject_test)=c("SubID")

# combine column set from subject test, y test and x test
test_data <- cbind(subject_test, y_test, x_test)

# repeat the same for training data


# Load and process x-train, y-train data
x_train <- read.table(file.path(path,"train","X_train.txt"), header=FALSE)
y_train <- read.table(file.path(path,"train","y_train.txt"), header=FALSE)
subject_train <- read.table(file.path(path,"train","subject_train.txt"), header=FALSE)

# add labels
names(x_train) = features

# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
x_train=x_train[,desired_msrmt]

# Load activity labels

y_train[,2]= activity_labels[y_train[,1]]
names(y_train)=c("Activity.ID", "Activity.Type")
names(subject_train)=c("SubID")

# combine column set from subject train, y train and x train
train_data <- cbind(subject_train, y_train, x_train)

# 1.Merges the training and the test sets to create one data set.

data <- rbind(test_data, train_data)

# 3. Uses descriptive activity names to name the activities in the data set
id_labels <- c("SubID", "Activity.ID", "Activity.Type")

# 4. Appropriately labels the data set with descriptive variable names.
colnames(data)<-gsub("std()", "SD", colnames(data))
colnames(data)<-gsub("mean()", "MEAN", colnames(data))
colnames(data)<-gsub("^t", "time", colnames(data))
colnames(data)<-gsub("^f", "frequency", colnames(data))
colnames(data)<-gsub("Acc", "Accelerometer", colnames(data))
colnames(data)<-gsub("Gyro", "Gyroscope", colnames(data))
colnames(data)<-gsub("Mag", "Magnitude", colnames(data))
colnames(data)<-gsub("BodyBody", "Body", colnames(data))

data_labels = setdiff(colnames(data), id_labels)

# build transpose of columns into rows using melt function
melt_data = melt( data, id = id_labels, mesaurement = data_labels)

# # 5. From the data set in step 4, creates a second, independent tidy data 
# set with the average of each variable for each activity and each subject.
# mean function here aggregates the data set 
tidy_data = dcast(melt_data, SubID + Activity.Type ~ variable, mean )
write.table(tidy_data, "./tidy_data.txt", row.names = FALSE)

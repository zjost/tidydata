library("reshape2")
library("plyr")
library("dplyr")

# This script will perform the data cleaning

################################################################
# 1. Merge the training and test data sets

# Load training and test feature data
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")

# Create master feature data frame
data <- rbind(X_train, X_test)


################################################################
################################################################

# 2. Extract only the measurements on the mean and std dev for
# each measurement

# Load feature names
features <- read.table("UCI HAR Dataset/features.txt")
features <- features$V2

# Get index list of features matching character string "mean()"
mean_list <- grep("mean()", features, fixed=T)
# Get index list of features matching character string "std()"
std_list <- grep("std()", features, fixed=T)


# Combine and sort index list
feat_list <- c(mean_list, std_list)
feat_list <- sort(feat_list)

# Extract column names for these features
col_names <- as.character(features[feat_list])

# Prune feature data to only include columns indexed by feat_list
data <- cbind(data[feat_list])

################################################################
################################################################

# 3. use descriptive activity names to name the activities

# Load train and test y data
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

# Combine data into single column
y_data <- rbind(y_train, y_test)
names(y_data) <- "y"
# Load activity list table
act_labs <- read.table("UCI HAR Dataset/activity_labels.txt")
names(act_labs) <- c("y", "Activity")

# Join tables on "y" column
y_data <- merge(y_data, act_labs, by.x="y", by.y="y", all.x=T)


# Load train and test subject data
sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Combine data into single column
sub_data <- rbind(sub_train, sub_test)
names(sub_data) <- "sub"

# Append to master DF
data <- cbind(data, y_data, sub_data)

# Update column name list with the new column names
col_names <- c(col_names, "y", "Activity", "Subject")


################################################################
################################################################

# 4. Appropriately label the data set with descriptive variable names
names(data) <- col_names


################################################################
################################################################

# 5. Create an independent, tidy data set from step 4 with the average
# of each variable for each activity and each subject

# Get list of feature variable names
feature_names <- as.character(features[feat_list])
# Melt DF using Subject/Activity id's and features as measures
data2 <- melt(data, id.vars=c("Subject", "Activity"), measure.vars=feature_names)
# Cast melted DF
data2 <- dcast(data2, Subject+Activity ~ variable, mean)

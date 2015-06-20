library("reshape2")

# This script will perform the data cleaning

################################################################
# 1. Merge the training and test data sets

# Load feature names
features <- read.table("UCI HAR Dataset/features.txt")
features <- features$V2

# Load training and test feature data
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
names(X_train) <- names(X_test) <- features

# Create master feature data frame
data <- rbind(X_train, X_test)

# Load train and test y data
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

# Combine data into single column
y_data <- rbind(y_train, y_test)
names(y_data) <- "y"

# Append to master DF
data <- cbind(data, y_data)
# Column index of y data
y_idx = ncol(data)

# Load train and test subject data
sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Combine data into single column
sub_data <- rbind(sub_train, sub_test)
names(sub_data) <- "sub"

# Append to master DF
data <- cbind(data, sub_data)
# Column index of sub data
sub_idx = ncol(data)

################################################################
################################################################

# 2. Extract only the measurements on the mean and std dev for
# each measurement

# Get index list of features matching character string "mean()"
mean_list <- grep("mean()", features, fixed=T)
# Get index list of features matching character string "std()"
std_list <- grep("std()", features, fixed=T)


# Combine and sort index list
feat_list <- c(mean_list, std_list)
feat_list <- sort(feat_list)

# Prune data to only include columns indexed by feat_list
data2 <- cbind(data[feat_list], data$y, data$sub)
################################################################
################################################################

# 3. use descriptive activity names to name the activities
act_labs <- read.table("UCI HAR Dataset/activity_labels.txt")
names(act_labs) <- c("y", "Activity")
data3 <- merge(data2, act_labs, by.x="y", by.y="y", all.x=T)

################################################################
################################################################

# 4. Appropriately label the data set with descriptive variable names
# Completed in Step 1 when added names data frames

################################################################
################################################################

# 5. Create an independent, tidy data set from step 4 with the average
# of each variable for each activity and each subject




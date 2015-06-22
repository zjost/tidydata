# tidydata
Submission for Coursera course

The "run_analysis.R" script requires the following packages:
* reshape
* plyr
* dplyr

The script does the following operations:
* Combines X_train and X_test feature data.
* Loads in all feature names
* Searches all feature names for the character string "mean()" or "std()" and returns the indices of matches
* Uses these indices to filter the feature data such that only column names containing those strings remain
* The y_train and y_test data files are imported and combined into a single column
* Similar to the y data, the "subject" train and test data are imported and combined to a single column
* The "activity_labels" file is merged with this data to match column names using the y_data code
* The y data, subject data, and activity labels are added to the feature data frame
* The feature names are appended to the data frame as column names
This process results in a data frame named "data".

The script aggregates observations by activity/subject id pairs by doing the following:
* The "melt" command is uses to melt the "data" data frame by using "Subject" and "Activity" as id's and a list of the feature names as the measures.  
* This melt is then input to the "cast" function by Subject + Activity and aggregates via the "mean" function.
This process results in a data frame named "data2".

See the CodeBook.md file for more details on the structure of the data frames output by this script.

See the README.txt in the "UCI HAR Dataset" directory for details on the original data set.

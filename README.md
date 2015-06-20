# tidydata
Submission for Coursera course

The "run_analysis.R" script requires the following packages:
* reshape
* plyr
* dplyr

The script results in two data frames
* "data" is a table of all observations for the features listed in "CodeBook.md" and is labeled by Subject and Activity.
* "data2" is a table that aggregates all observations for a given Subject/Activity pair using the mean function.

See the CodeBook.md file for more details on the structure of the data frames output by this script.

See the README.txt in the "UCI HAR Dataset" directory for details on the original data set.
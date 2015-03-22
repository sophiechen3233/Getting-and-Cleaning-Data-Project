# Getting-and-Cleaning-Data-Project

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called run_analysis.R that does the following. 


Step 1: Merges the training and the test sets to create one data set.
Use read.table function( )to read train and test files, and then merge the files rbind() and cbind().

Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
extracts each measurement using mean() and std(),  new data frame is then created.

Step 3: Uses descriptive activity names to name the activities in the data set
change the type to character.

Step 4: Appropriately labels the data set with descriptive variable names. 
use gsub() to rename all the activity names.

Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
set subject to factor using as.factor(), then use aggregate() to create a new data frame.

Final step:

save the script and name it "run_analysis.R" and then source the file in Rstudio. A text file "finalTidy" is generated.

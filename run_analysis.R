

#part1: Merges the training and the test sets to create one data set.
library("dplyr")
library("data.table")

featurenames <- read.table("UCI HAR Dataset/features.txt")

activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
trainsubject <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
trainactivity<- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
trainfeatures<- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
testsubject <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
testactivity <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
testfeatures <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

subject <- rbind(trainsubject, testsubject)
activity <- rbind(trainactivity, testactivity)
features <- rbind(trainfeatures, testfeatures)

colnames(features) <- t(featurenames[2])
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
newdata <- cbind(features,activity,subject)


#part2:Extracts only the measurements on the mean and standard deviation for each measurement. 
columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(newdata), ignore.case=TRUE)

columns3 <- c(columnsWithMeanSTD, 562, 563)

extracteddata <- newdata[,columns3]
dim(newdata)

extracteddata$Activity <- as.character(extracteddata$Activity)
dim(extracteddata)

#part3:Uses descriptive activity names to name the activities in the data set
extracteddata$Activity <- as.character(extracteddata$Activity)
for (i in 1:6){
extracteddata$Activity[extracteddata$Activity == i] <- as.character(activitylabels[i,2])
}
extracteddata$Activity <- as.factor(extracteddata$Activity)

#part4:Appropriately labels the data set with descriptive variable names. 
names(extracteddata)
names(extracteddata)<-gsub("Acc", "Accelerometer", names(extracteddata))
names(extracteddata)<-gsub("gravity", "Gravity", names(extracteddata))
names(extracteddata)<-gsub("Gyro", "Gyroscope", names(extracteddata))
names(extracteddata)<-gsub("angle", "Angle", names(extracteddata))
names(extracteddata)<-gsub("BodyBody", "Body", names(extracteddata))
names(extracteddata)<-gsub("-freq()", "Frequency", names(extracteddata), ignore.case = TRUE)
names(extracteddata)<-gsub("Mag", "Magnitude", names(extracteddata))
names(extracteddata)<-gsub("^f", "Frequency", names(extracteddata))
names(extracteddata)<-gsub("^t", "Time", names(extracteddata))
names(extracteddata)<-gsub("-std()", "STD", names(extracteddata), ignore.case = TRUE)
names(extracteddata)<-gsub("-mean()", "Mean", names(extracteddata), ignore.case = TRUE)
names(extracteddata)<-gsub("^t", "Time", names(extracteddata))
names(extracteddata)


extracteddata <- data.table(extracteddata)

#part5:From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
extracteddata$Subject <- as.factor(extracteddata$Subject)
extracteddata <- data.table(extracteddata)
head(extracteddata)
tidyData <- aggregate(. ~Subject + Activity, extracteddata, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "finalTidy.txt", row.names = FALSE)


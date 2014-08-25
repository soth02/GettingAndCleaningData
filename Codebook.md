# Codebook - Getting and Cleaning Data Course Project
========================================

1. Based on the environment assumptions laid out in the README.md, we set the cwd to the downloaded dataset folder.
setwd("C:\\Users\\Chris\\Desktop\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset")

2. I interpreted "merge datasets" to mean to combine the test and training data under the respective UCI HAR Dataset\test and UCI HAR Dataset\train folders.  The relevant files were subject_test.txt,X_test.txt, Y_test.txt as well as their train counterparts subject_train.txt, X_train.txt, and Y_train.txt.  I ignored the Inertial Signals folders.

``` code
#merge training and test sets

#read in test data
subjectTest<-read.table("test\\subject_test.txt")
xTest<-read.table("test\\X_test.txt")
yTest<-read.table("test\\Y_test.txt")

#read in training data
subjectTrain<-read.table("train\\subject_train.txt")
xTrain<-read.table("train\\X_train.txt")
yTrain<-read.table("train\\Y_train.txt")

#combine data
combinedSubjectData<-rbind(subjectTest, subjectTrain)
combinedXData<-rbind(xTest,xTrain)
combinedYData<-rbind(yTest,yTrain)
```
3. Here I crossed referenced the activity_labels.txt file to add another column in the merged dataset that corresponded activity ID numbers to their actual activity (e.g., 1=WALKING, 2=WALKING_UPSTAIRS,etc)

``` code
#tranform ydata numbers to their corresponding descriptive activity names
actLabels<-read.table("activity_labels.txt")[,2]
combinedYData[,2] <- actLabels[combinedYData[,1]]

#label data
names(combinedSubjectData) <- "subject_ID"
names(combinedYData) <- c("act_ID","activity")
```
4.  Similarly, I updated the variable names using the features.txt as an index

``` code
#transform variable names in x data to appropriate subject names from features.txt
features<-read.table("features.txt")[,2]
names(combinedXData) <- features
```

5.  All data (subject, x data, y data) was combined into one large table

``` code
#combine all data
allData<-cbind(combinedSubjectData,combinedXData,combinedYData)
```

6.  I filtered merged dataset to only include columns that had mean or std results.  I interpreted "mean" as columns that ended in "mean()", and "std" as "std()".  meanfreq() was not included

``` code
#get variable numbers that correspond to only the mean and sd for each measurement
featureMeanStdCols<-grep("mean\\(\\)|std\\(\\)",features)
combinedMeanStdData<-allData[,c(featureMeanStdCols,563,564)] #hacked in names of act_ID, activity
```

7.  Merged Data is writted to a file.

``` code
write.table(combinedMeanStdData, file="../mergedDataSet.txt", col.names=TRUE, row.names=FALSE, sep=",")
```
``` code
#save RAM, reomve unneeded variables
#rm(xTest,xTrain,subjectTest,yTest,yTrain,subjectTrain,combinedSubjectData,combinedXData,combinedYData,allData)
rm(xTest,xTrain,subjectTest,yTest,yTrain,subjectTrain)
``` code

8.  Average values are calculated on a per subject per activity basis and written to a file.

``` code
write.table(combinedMeanStdData, file="../tidyDataSet.txt", col.names=TRUE, row.names=FALSE, sep=",")
```

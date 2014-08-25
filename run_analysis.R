setwd("C:\\Users\\Chris\\Desktop\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset")

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

#tranform ydata numbers to their corresponding descriptive activity names
actLabels<-read.table("activity_labels.txt")[,2]
combinedYData[,2] <- actLabels[combinedYData[,1]]

#label data
names(combinedSubjectData) <- "subject_ID"
names(combinedYData) <- c("act_ID","activity")

#transform variable names in x data to appropriate subject names from features.txt
features<-read.table("features.txt")[,2]
names(combinedXData) <- features

#combine all data
allData<-cbind(combinedSubjectData,combinedXData,combinedYData)

#get variable numbers that correspond to only the mean and sd for each measurement
featureMeanStdCols<-grep("mean\\(\\)|std\\(\\)",features)
combinedMeanStdData<-allData[,c(featureMeanStdCols,563,564)] #hacked in names of act_ID, activity

write.table(combinedMeanStdData, file="../mergedDataSet.txt", col.names=TRUE, row.names=FALSE, sep=",")

#save RAM, reomve unneeded variables
#rm(xTest,xTrain,subjectTest,yTest,yTrain,subjectTrain,combinedSubjectData,combinedXData,combinedYData,allData)
rm(xTest,xTrain,subjectTest,yTest,yTrain,subjectTrain)

#create tidy dataset
numSubjects <- nrow(unique(combinedSubjectData))
activities <- unique(combinedYData)
numActivities <- nrow(activities)



write.table(tidyData, file="../tidyDataSet.txt", col.names=TRUE, row.names=FALSE, sep=",")

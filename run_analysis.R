# Getting and Cleaning Data Final Project
# July 2016

# Load libraries
library(data.table)

# Download the file if it doesnt exist
if (!file.exists("MobileData.zip"))
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","MobileData.zip")

# Now unzip the contents if the file has not be unzipped before
if (!dir.exists("UCI HAR Dataset"))
  unzip("MobileData.zip")

# Now read the data into R, make sure to take in the data sets, the labels and the individuals
trainTable <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainY <- read.table("./UCI HAR Dataset/train/y_train.txt")
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
testTable <- read.table("./UCI HAR Dataset/test/X_test.txt")
testY <- read.table("./UCI HAR Dataset/test/y_test.txt")
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Now form the total data table by merging the data that we previously input
totalTable <-rbind(trainTable,testTable) # these are the features
totalY <- rbind(trainY,testY) # these are the activity labels
totalSubject <- rbind(trainSubject,testSubject) # lastly, we have the subject numbers

# Now put the data into a data frame, R allows us to manipulate data easier if it is in the data frame format.
df <- data.frame(matrix(unlist(totalTable), nrow=10299, byrow=T)) # note here that we manually input the row number, this can also be automatically coded.
df_y<- data.frame(totalY) # Here we form the data frame for the activity labels
df_Subject<- data.frame(totalSubject) # here we form the data frame for the subject labels

# Import the column names - we need to both select the columns we want and format the names
featureNames <- read.table("./UCI HAR Dataset/features.txt")

#Groom the column names - format the names in a nice human readable fashion
featureNames[,2]<-sub("-mean()"," Mean",featureNames[,2])
featureNames[,2]<-sub("-std()"," Std",featureNames[,2])
featureNames[,2]<-sub("()-X"," Horizontal-X",featureNames[,2])
featureNames[,2]<-sub("()-Y"," Horizontal-Y",featureNames[,2])
featureNames[,2]<-sub("()-Z"," Vertical",featureNames[,2])
featureNames[,2]<-sub("tGravityAcc"," Gravitational Accelerometer Raw ",featureNames[,2])
featureNames[,2]<-sub("tGravityAccJerk"," Gravitational Accelerometer Jerk Raw ",featureNames[,2])
featureNames[,2]<-sub("tBodyGyro"," Body Gyroscope Raw ",featureNames[,2])
featureNames[,2]<-sub("tGravityAcc"," Gravitational Accelerometer Raw ",featureNames[,2])
featureNames[,2]<-sub("tBodyAcc"," Body Accelerometer Raw ",featureNames[,2])
featureNames[,2]<-sub("tBodyAccJerk"," Body Accelerometer Jerk Raw " ,featureNames[,2])

featureNames[,2]<-sub("fGravityAcc"," Gravitational Accelerometer FFT ",featureNames[,2])
featureNames[,2]<-sub("fGravityAccJerk"," Gravitational Accelerometer Jerk FFT ",featureNames[,2])
featureNames[,2]<-sub("fBodyGyro"," Body Gyroscope FFT ",featureNames[,2])
featureNames[,2]<-sub("fGravityAcc"," Gravitational Accelerometer FFT ",featureNames[,2])
featureNames[,2]<-sub("fBodyAcc"," Body Accelerometer FFT ",featureNames[,2])
featureNames[,2]<-sub("fBodyAccJerk"," Body Accelerometer Jerk FFT " ,featureNames[,2])

featureNames[,2]<-sub("fBodyBodyGyro"," Body Gyroscope FFT ",featureNames[,2])
featureNames[,2]<-sub("fBodyBodyAcc"," Body Accelerometer FFT ",featureNames[,2])
featureNames[,2]<-sub("fBodyBodyAccJerk"," Body Accelerometer Jerk FFT " ,featureNames[,2])
featureNames[,2]<-sub(".1","" ,featureNames[,2])
featureNames[,2]<-sub("()$","" ,featureNames[,2])


# now place the column names in the data frame, ie remove the generic labels v1, v2, etc
colnames(df) <- featureNames[[2]]
colnames(df_y) <- "Activity Label"
colnames(df_Subject) <- "Subject Num"

# Now extract the column vectors that have mean or standard deviation measurements
b<-grep("Std",featureNames[[2]])
a<-grep("Mean",featureNames[[2]])
sortedColIndex<-sort(c(a,b))

#Extract the data cols
subsetDF<-df[sortedColIndex]

# now append the subject and activity columns
tidyFrame <- cbind(subsetDF,df_y,df_Subject)

# Now sort the data set first by user and then by activity. Return a new data frame that contains only the average of each feature for the activity and the user.
meanFrame<-aggregate(tidyFrame,by=list(tidyFrame$`Activity Label`,tidyFrame$`Subject Num`),mean)

# Now replace the activity codes 1-6 with the real activity names 
meanFrame$`Activity Label`<-sub("1","Walking",meanFrame$`Activity Label`)
meanFrame$`Activity Label`<-sub("2","Walking Upstairs",meanFrame$`Activity Label`)
meanFrame$`Activity Label`<-sub("3","Walking Downstairs",meanFrame$`Activity Label`)
meanFrame$`Activity Label`<-sub("4","Sitting",meanFrame$`Activity Label`)
meanFrame$`Activity Label`<-sub("5","Standing",meanFrame$`Activity Label`)
meanFrame$`Activity Label`<-sub("6","Laying",meanFrame$`Activity Label`)

# Save the results so that we can post the tidy frame to github
write.csv(meanFrame,"tidyFrame.csv")

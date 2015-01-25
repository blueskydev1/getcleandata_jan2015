##
## run_analysis.r
##
##
## Getting & Cleaning Data - January 2015
## UCI HAR Dataset Analysis
## Course Project Analysis Script
## Katherine R. Lieber
## January 25, 2015
##
##

###########

## Script Description
## This script operates on the UCI HAR Dataset and performs the following steps:
##	1. Merges the training and the test sets, including the detailed
##		inertial data, to create one data set.##	2. Extracts only the measurements on the mean and standard deviation 
##		for each measurement.##	3. Uses descriptive activity names to name the activities in the data set##	4. Appropriately labels the data set with descriptive variable names.##	5. From the data set in step 4, creates a second, independent tidy data set 
##		with the average of each variable for each activity and each subject.
##	6. Writes this to a file finalAnalysisData.txt and places this file 
##		in the data folder.

## This script assumes you have already downloaded the UCI HAR Dataset and placed it
##	in a folder entitled "data" located in your working directory.


##
## (A.) Analysys Set 1 - TEST SET DATA
##


## (I.1.testSet) Load the Main Variables and Data Sets

## set directory for the main course project sub-subfolder (inside the data folder)
## read the text files into R 
setwd("/Users/nightshade/datamaximus/data/UCI HAR Dataset")
myActivities <- read.table("activity_labels.txt")
myFeatures <- read.table("features.txt")
length(myFeatures)
## myFeatures has 561 obs of 2 variables representing the type of acceleration data gathered (ex. "tBodyAcc-mean()-X")

## First, we confirm the deepest data (the inertial data) is consistent (it is)
setwd("/Users/nightshade/datamaximus/data/UCI HAR Dataset/test/Inertial Signals")
## these yield length 128 variables - confirmed for all files as per the code below, which yielded 128 for each answer; 2947 obs for each
myAccX <- read.table("body_acc_x_test.txt")
length(myAccX)
myAccY <- read.table("body_acc_y_test.txt")
length(myAccY)
myAccZ <- read.table("body_acc_z_test.txt")
length(myAccZ)
myGyroX <- read.table("body_gyro_x_test.txt")
length(myGyroX)
myGyroY <- read.table("body_gyro_y_test.txt")
length(myGyroY)
myGyroZ <- read.table("body_gyro_z_test.txt")
length(myGyroZ)
myTotalX <- read.table("total_acc_x_test.txt")
length(myTotalX)
myTotalY <- read.table("total_acc_y_test.txt")
length(myTotalX)
myTotalZ <- read.table("total_acc_z_test.txt")
length(myTotalX)

## next, we move up a level to the Test folder
setwd("/Users/nightshade/datamaximus/data/UCI HAR Dataset/test")
## we find that mySubjects contains 2947 obs of 1 variable 
## in this file subject_train, the rows (observations) identify the subject of the observation by a number from 1 to 30.
mySubjects <- read.table("subject_test.txt")
## myX contains 2947 obs of 5 variables. It is identified as the "training set" but they don't link it to the acc/gyro/total data.
myX <- read.table("X_test.txt")
## myY contains 2947 obs of 1 variables. It is identifie as the test labels
myY <- read.table("Y_test.txt")


##############

## (II.1.testSet) 10 Points To Gryffindor (manipulate inertial detail data ACC, GYRO, TOTAL) (test set)

## Next we manipulate the Inertial Detail Data.

###### This is the ACC-X set ##############

## The first operation is to paste the subject's ID onto the body_acc data.
## The variables are loaded via code elsewhere. They are:
## mySubjects
## myAccX

myAccXid <- cbind( mySubjects, myAccX)

## Set the initial variables. Use = NULL to create a blank vector for the names.

## Initialize:
myNameVariable <- "AccX"
myColumnVariable <- 1
myDepthDataColNames = NULL

for (i in 1:128 ) {
myDepthDataColCalculator <- c( paste(myNameVariable, myColumnVariable , sep="") )
myDepthDataColNames <- append( myDepthDataColNames, myDepthDataColCalculator )
myColumnVariable <- myColumnVariable + 1
}

## head(myDepthDataColNames)

myAccColNames <- c("Subject", myDepthDataColNames)
colnames(myAccXid) <- myAccColNames


#################### ACCX ends here

###### This is the ACC-Y set ##############

## The first operation is to paste the subject's ID onto the body_acc data.
## The variables are loaded via code elsewhere. They are:
## mySubjects
## myAccY

myAccYid <- cbind( mySubjects, myAccY)

## Set the initial variables. Use = NULL to create a blank vector for the names.

## Initialize:
myNameVariable <- "AccY"
myColumnVariable <- 1
myDepthDataColNames = NULL

for (i in 1:128 ) {
myDepthDataColCalculator <- c( paste(myNameVariable, myColumnVariable , sep="") )
myDepthDataColNames <- append( myDepthDataColNames, myDepthDataColCalculator )
myColumnVariable <- myColumnVariable + 1
}

## head(myDepthDataColNames)

myAccColNames <- c("Subject", myDepthDataColNames)
colnames(myAccYid) <- myAccColNames


#################### ACC-Y ends here

###### This is the ACC-Z set ##############

## The first operation is to paste the subject's ID onto the body_acc data.
## The variables are loaded via code elsewhere. They are:
## mySubjects
## myAccZ

myAccZid <- cbind( mySubjects, myAccZ)

## Set the initial variables. Use = NULL to create a blank vector for the names.

## Initialize:
myNameVariable <- "AccZ"
myColumnVariable <- 1
myDepthDataColNames = NULL

for (i in 1:128 ) {
myDepthDataColCalculator <- c( paste(myNameVariable, myColumnVariable , sep="") )
myDepthDataColNames <- append( myDepthDataColNames, myDepthDataColCalculator )
myColumnVariable <- myColumnVariable + 1
}

## head(myDepthDataColNames)

myAccColNames <- c("Subject", myDepthDataColNames)
colnames(myAccZid) <- myAccColNames


#################### ACC-Z ends here

## We need to merge in a new way due to the naming.

myAccXid$Subject <- NULL
myAccYid$Subject <- NULL
myAccZid$Subject <- NULL
myAccXYZid <- cbind ( mySubjects, myAccXid, myAccYid, myAccZid )
## head(myAccXYZid)
## dim(myAccXYZid)
## names(myAccXYZid)

gryffindorACC <- myAccXYZid


###########

## Now we include GYRO. 

###### This is the GYRO-X set ##############

## The first operation is to paste the subject's ID onto the body_Gyro data.
## The variables are loaded via code elsewhere. They are:
## mySubjects
## myGyroX

myGyroXid <- cbind( mySubjects, myGyroX)

## Set the initial variables. Use = NULL to create a blank vector for the names.

## Initialize:
myNameVariable <- "GyroX"
myColumnVariable <- 1
myDepthDataColNames = NULL

for (i in 1:128 ) {
myDepthDataColCalculator <- c( paste(myNameVariable, myColumnVariable , sep="") )
myDepthDataColNames <- append( myDepthDataColNames, myDepthDataColCalculator )
myColumnVariable <- myColumnVariable + 1
}

## head(myDepthDataColNames)

myGyroColNames <- c("Subject", myDepthDataColNames)
colnames(myGyroXid) <- myGyroColNames


#################### Gyro-X ends here

###### This is the Gyro-Y set ##############

## The first operation is to paste the subject's ID onto the body_Gyro data.
## The variables are loaded via code elsewhere. They are:
## mySubjects
## myGyroY

myGyroYid <- cbind( mySubjects, myGyroY)

## Set the initial variables. Use = NULL to create a blank vector for the names.

## Initialize:
myNameVariable <- "GyroY"
myColumnVariable <- 1
myDepthDataColNames = NULL

for (i in 1:128 ) {
myDepthDataColCalculator <- c( paste(myNameVariable, myColumnVariable , sep="") )
myDepthDataColNames <- append( myDepthDataColNames, myDepthDataColCalculator )
myColumnVariable <- myColumnVariable + 1
}

## head(myDepthDataColNames)

myGyroColNames <- c("Subject", myDepthDataColNames)
colnames(myGyroYid) <- myGyroColNames


#################### Gyro-Y ends here

###### This is the Gyro-Z set ##############

## The first operation is to paste the subject's ID onto the body_Gyro data.
## The variables are loaded via code elsewhere. They are:
## mySubjects
## myGyroZ

myGyroZid <- cbind( mySubjects, myGyroZ)

## Set the initial variables. Use = NULL to create a blank vector for the names.

## Initialize:
myNameVariable <- "GyroZ"
myColumnVariable <- 1
myDepthDataColNames = NULL

for (i in 1:128 ) {
myDepthDataColCalculator <- c( paste(myNameVariable, myColumnVariable , sep="") )
myDepthDataColNames <- append( myDepthDataColNames, myDepthDataColCalculator )
myColumnVariable <- myColumnVariable + 1
}

## head(myDepthDataColNames)

myGyroColNames <- c("Subject", myDepthDataColNames)
colnames(myGyroZid) <- myGyroColNames


#################### Gyro-Z ends here

## We need to merge in a new way due to the naming.

myGyroXid$Subject <- NULL
myGyroYid$Subject <- NULL
myGyroZid$Subject <- NULL
myGyroXYZid <- cbind ( mySubjects, myGyroXid, myGyroYid, myGyroZid )
## head(myGyroXYZid)
## dim(myGyroXYZid)
## names(myGyroXYZid)

gryffindorGYRO <- myGyroXYZid

## Now we include TOTAL. 

###### This is the TOTAL-X set ##############

## The first operation is to paste the subject's ID onto the total data.
## The variables are loaded via code elsewhere. They are:
## mySubjects
## myTotalX

myTotalXid <- cbind( mySubjects, myTotalX)

## Set the initial variables. Use = NULL to create a blank vector for the names.

## Initialize:
myNameVariable <- "TotalX"
myColumnVariable <- 1
myDepthDataColNames = NULL

for (i in 1:128 ) {
myDepthDataColCalculator <- c( paste(myNameVariable, myColumnVariable , sep="") )
myDepthDataColNames <- append( myDepthDataColNames, myDepthDataColCalculator )
myColumnVariable <- myColumnVariable + 1
}

## head(myDepthDataColNames)

myTotalColNames <- c("Subject", myDepthDataColNames)
colnames(myTotalXid) <- myTotalColNames


#################### Total-X ends here

###### This is the Total-Y set ##############

## The first operation is to paste the subject's ID onto the body_Total data.
## The variables are loaded via code elsewhere. They are:
## mySubjects
## myTotalY

myTotalYid <- cbind( mySubjects, myTotalY)

## Set the initial variables. Use = NULL to create a blank vector for the names.

## Initialize:
myNameVariable <- "TotalY"
myColumnVariable <- 1
myDepthDataColNames = NULL

for (i in 1:128 ) {
myDepthDataColCalculator <- c( paste(myNameVariable, myColumnVariable , sep="") )
myDepthDataColNames <- append( myDepthDataColNames, myDepthDataColCalculator )
myColumnVariable <- myColumnVariable + 1
}

## head(myDepthDataColNames)

myTotalColNames <- c("Subject", myDepthDataColNames)
colnames(myTotalYid) <- myTotalColNames


#################### Total-Y ends here

###### This is the Total-Z set ##############

## The first operation is to paste the subject's ID onto the body_Total data.
## The variables are loaded via code elsewhere. They are:
## mySubjects
## myTotalZ

myTotalZid <- cbind( mySubjects, myTotalZ)

## Set the initial variables. Use = NULL to create a blank vector for the names.

## Initialize:
myNameVariable <- "TotalZ"
myColumnVariable <- 1
myDepthDataColNames = NULL

for (i in 1:128 ) {
myDepthDataColCalculator <- c( paste(myNameVariable, myColumnVariable , sep="") )
myDepthDataColNames <- append( myDepthDataColNames, myDepthDataColCalculator )
myColumnVariable <- myColumnVariable + 1
}

## head(myDepthDataColNames)

myTotalColNames <- c("Subject", myDepthDataColNames)
colnames(myTotalZid) <- myTotalColNames



#################### Total-Z ends here

## We need to merge in a new way due to the naming.

myTotalXid$Subject <- NULL
myTotalYid$Subject <- NULL
myTotalZid$Subject <- NULL
myTotalXYZid <- cbind ( mySubjects, myTotalXid, myTotalYid, myTotalZid )
## head(myTotalXYZid)
## dim(myTotalXYZid)
## names(myTotalXYZid)

gryffindorTOTAL <- myTotalXYZid

gryffindorACC$V1 <- NULL
gryffindorGYRO$V1 <- NULL
gryffindorTOTAL$V1 <- NULL
gryffindorFULL <- cbind ( mySubjects, gryffindorACC, gryffindorGYRO, gryffindorTOTAL )
## head(gryffindorFULL)
## dim(gryffindorFULL)
## names(gryffindorFULL)

## Inertial Data has been loaded. End of 10 Points to Gryffyndor.

###########


## (II.2.testSet) Frodo's Frisbees (Working with the Test Data)  (test set)

## The next operation is to meld the Activity, Features and Subjects. The variables are:
## myX
## myY
## mySubjects

## Two of our variables aren't clear, so we'll reload them into clearer names 
myTestData <- myX
myTestActivityids <- myY

## Now we need to add a column of literal names for the activity ids
## This code generates the literal activity names from the test data in preparation for the cbinds.

df1 <- data.frame(myTestActivityids)
myData <- NULL
activityType <- function(x) { 
if(x == 1) y <- "WALKING"
if(x == 2) y <- "WALKING_UPSTAIRS"
if(x == 3) y <- "WALKING_DOWNSTAIRS"
if(x == 4) y <- "SITTING"
if(x == 5) y <- "STANDING"
if(x == 6) y <- "LAYING"
return(y)
}
myData <- sapply(df1$V1, activityType)
x <- myData
myTestActivityNames <- matrix(unlist(x), ncol=length(1) )
myTestActivityIdsNames <- cbind( myTestActivityids, myTestActivityNames )

## Now we cbind, then cbind again for the Subject ID's:

myTestid <- cbind ( myTestActivityIdsNames, myTestData )
myTestidSubjectid <- cbind ( mySubjects , myTestid )

## We now have a table of 2947 obs x 564 variables with subject, activity, activity name, and the data vector. This looks like it would benefit from some better column names.

myFeaturesWorking <- myFeatures
myFeaturesWorking$V1 <- NULL
myFeaturesCols <- t(myFeaturesWorking)
featureNames <- myFeaturesCols
myColNames <- c("Subject", "Activity", "ActivityName", featureNames)
colnames(myTestidSubjectid) <- myColNames

frodosFrisbees <- myTestidSubjectid


## (II.3.testSet) The Sorting Hat (Frodo vs Gryffindor)  (test data set)

## So we have two data sets. Gryffindor, the detail data, 2947 x 385; Frodo, the test data; 2947 x 563. 
## We bind the two into one huge data set, myMegaDataTestSet.

myMegaDataTestSet <- cbind( frodosFrisbees , gryffindorFULL )
names(myMegaDataTestSet)

## There you have it folks. One jumbo set by Subject, showing activity and all the depth data. 2947 x 948.
## Code works - paste full file into R. 01/23/15 1:36pm
## All systems go - final approval on full file confirmed. 01/24/15 9:16a.

## Additional updates: 1/24/15 09:24:00 myMegaData was updated to myMegaDataTestSet to account for second training set. None of the other variables was updated in this way, so frodosFrisbees and gryffindorFULL will depend on which script is being run (test or training).

## Add "Which Set ID" - this is the Test Set one (for "test", variable = 1)

myRowCount <- nrow(myMegaDataTestSet)
x <- rep(1, myRowCount )
whichSetId <- matrix(unlist(x), ncol=length(myRowCount) )
myColNames <- c("WhichSet")
colnames(whichSetId) <- myColNames
myMegaDataTestSet2 <- cbind ( whichSetId, myMegaDataTestSet )

## End of The Sorting Hat (Test Set)

#######################

##
## (B.) Analysys Set 2 - TRAINING SET DATA
## This repeats the analysis from "A" on the Training Set.
## This was conceived as a separate fully portable script on its own, 
## so contains some re-loading of variables, etc.
##

## (I.1.) Load the Main Variables and Data Sets (training set)

## Load of the Main Variables and Data Sets
## set directory for the main course project sub-subfolder (inside the data folder)
## read the text files into R 
setwd("/Users/nightshade/datamaximus/data/UCI HAR Dataset")
myActivities <- read.table("activity_labels.txt")
myFeatures <- read.table("features.txt")
length(myFeatures)
## myFeatures has 561 obs of 2 variables representing the type of acceleration data gathered (ex. "tBodyAcc-mean()-X")

## First, we confirm the deepest data is consistent (it is)
setwd("/Users/nightshade/datamaximus/data/UCI HAR Dataset/train/Inertial Signals")
## these yield length 128 variables - confirmed for all files as per the code below, which yielded 128 for each answer; 2947 obs for each
myAccX <- read.table("body_acc_x_train.txt")
length(myAccX)
myAccY <- read.table("body_acc_y_train.txt")
length(myAccY)
myAccZ <- read.table("body_acc_z_train.txt")
length(myAccZ)
myGyroX <- read.table("body_gyro_x_train.txt")
length(myGyroX)
myGyroY <- read.table("body_gyro_y_train.txt")
length(myGyroY)
myGyroZ <- read.table("body_gyro_z_train.txt")
length(myGyroZ)
myTotalX <- read.table("total_acc_x_train.txt")
length(myTotalX)
myTotalY <- read.table("total_acc_y_train.txt")
length(myTotalX)
myTotalZ <- read.table("total_acc_z_train.txt")
length(myTotalX)
setwd("/Users/nightshade/datamaximus/data/UCI HAR Dataset")

## next, we move up a level 
setwd("/Users/nightshade/datamaximus/data/UCI HAR Dataset/train")
## we find that mySubjects contains 2947 obs of 1 variable 
## (some of these I am just reading from the Environment window in R studio rather than printing to the console)
## in this file subject_train, the rows (observations) identify the subject of the observation by a number from 1 to 30.
mySubjects <- read.table("subject_train.txt")
## myX contains 2947 obs of 5 variables. It is identified as the "training set" but they don't link it to the acc/gyro/total data.
myX <- read.table("X_train.txt")
## myY contains 2947 obs of 1 variables. It is identifie as the train labels
myY <- read.table("Y_train.txt")


##############

## (II.1.trainSet) 10 Points To Gryffindor (manipulate inertial detail data ACC, GYRO, TOTAL) (training data set)

## Next we manipulate the Inertial Detail Data.

###### This is the ACC-X set ##############

## The first operation is to paste the subject's ID onto the body_acc data.
## The variables are loaded via code elsewhere. They are:
## mySubjects
## myAccX

myAccXid <- cbind( mySubjects, myAccX)

## Set the initial variables. Use = NULL to create a blank vector for the names.

## Initialize:
myNameVariable <- "AccX"
myColumnVariable <- 1
myDepthDataColNames = NULL

for (i in 1:128 ) {
myDepthDataColCalculator <- c( paste(myNameVariable, myColumnVariable , sep="") )
myDepthDataColNames <- append( myDepthDataColNames, myDepthDataColCalculator )
myColumnVariable <- myColumnVariable + 1
}

## head(myDepthDataColNames)

myAccColNames <- c("Subject", myDepthDataColNames)
colnames(myAccXid) <- myAccColNames


#################### ACCX ends here

###### This is the ACC-Y set ##############

## The first operation is to paste the subject's ID onto the body_acc data.
## The variables are loaded via code elsewhere. They are:
## mySubjects
## myAccY

myAccYid <- cbind( mySubjects, myAccY)

## Set the initial variables. Use = NULL to create a blank vector for the names.

## Initialize:
myNameVariable <- "AccY"
myColumnVariable <- 1
myDepthDataColNames = NULL

for (i in 1:128 ) {
myDepthDataColCalculator <- c( paste(myNameVariable, myColumnVariable , sep="") )
myDepthDataColNames <- append( myDepthDataColNames, myDepthDataColCalculator )
myColumnVariable <- myColumnVariable + 1
}

## head(myDepthDataColNames)

myAccColNames <- c("Subject", myDepthDataColNames)
colnames(myAccYid) <- myAccColNames


#################### ACC-Y ends here

###### This is the ACC-Z set ##############

## The first operation is to paste the subject's ID onto the body_acc data.
## The variables are loaded via code elsewhere. They are:
## mySubjects
## myAccZ

myAccZid <- cbind( mySubjects, myAccZ)

## Set the initial variables. Use = NULL to create a blank vector for the names.

## Initialize:
myNameVariable <- "AccZ"
myColumnVariable <- 1
myDepthDataColNames = NULL

for (i in 1:128 ) {
myDepthDataColCalculator <- c( paste(myNameVariable, myColumnVariable , sep="") )
myDepthDataColNames <- append( myDepthDataColNames, myDepthDataColCalculator )
myColumnVariable <- myColumnVariable + 1
}

## head(myDepthDataColNames)

myAccColNames <- c("Subject", myDepthDataColNames)
colnames(myAccZid) <- myAccColNames


#################### ACC-Z ends here

## We need to merge in a new way due to the naming.

myAccXid$Subject <- NULL
myAccYid$Subject <- NULL
myAccZid$Subject <- NULL
myAccXYZid <- cbind ( mySubjects, myAccXid, myAccYid, myAccZid )
## head(myAccXYZid)
## dim(myAccXYZid)
## names(myAccXYZid)

gryffindorACC <- myAccXYZid


###########

## Now we include GYRO. 

###### This is the GYRO-X set ##############

## The first operation is to paste the subject's ID onto the body_Gyro data.
## The variables are loaded via code elsewhere. They are:
## mySubjects
## myGyroX

myGyroXid <- cbind( mySubjects, myGyroX)

## Set the initial variables. Use = NULL to create a blank vector for the names.

## Initialize:
myNameVariable <- "GyroX"
myColumnVariable <- 1
myDepthDataColNames = NULL

for (i in 1:128 ) {
myDepthDataColCalculator <- c( paste(myNameVariable, myColumnVariable , sep="") )
myDepthDataColNames <- append( myDepthDataColNames, myDepthDataColCalculator )
myColumnVariable <- myColumnVariable + 1
}

## head(myDepthDataColNames)

myGyroColNames <- c("Subject", myDepthDataColNames)
colnames(myGyroXid) <- myGyroColNames


#################### Gyro-X ends here

###### This is the Gyro-Y set ##############

## The first operation is to paste the subject's ID onto the body_Gyro data.
## The variables are loaded via code elsewhere. They are:
## mySubjects
## myGyroY

myGyroYid <- cbind( mySubjects, myGyroY)

## Set the initial variables. Use = NULL to create a blank vector for the names.

## Initialize:
myNameVariable <- "GyroY"
myColumnVariable <- 1
myDepthDataColNames = NULL

for (i in 1:128 ) {
myDepthDataColCalculator <- c( paste(myNameVariable, myColumnVariable , sep="") )
myDepthDataColNames <- append( myDepthDataColNames, myDepthDataColCalculator )
myColumnVariable <- myColumnVariable + 1
}

## head(myDepthDataColNames)

myGyroColNames <- c("Subject", myDepthDataColNames)
colnames(myGyroYid) <- myGyroColNames


#################### Gyro-Y ends here

###### This is the Gyro-Z set ##############

## The first operation is to paste the subject's ID onto the body_Gyro data.
## The variables are loaded via code elsewhere. They are:
## mySubjects
## myGyroZ

myGyroZid <- cbind( mySubjects, myGyroZ)

## Set the initial variables. Use = NULL to create a blank vector for the names.

## Initialize:
myNameVariable <- "GyroZ"
myColumnVariable <- 1
myDepthDataColNames = NULL

for (i in 1:128 ) {
myDepthDataColCalculator <- c( paste(myNameVariable, myColumnVariable , sep="") )
myDepthDataColNames <- append( myDepthDataColNames, myDepthDataColCalculator )
myColumnVariable <- myColumnVariable + 1
}

## head(myDepthDataColNames)

myGyroColNames <- c("Subject", myDepthDataColNames)
colnames(myGyroZid) <- myGyroColNames


#################### Gyro-Z ends here

## We need to merge in a new way due to the naming.

myGyroXid$Subject <- NULL
myGyroYid$Subject <- NULL
myGyroZid$Subject <- NULL
myGyroXYZid <- cbind ( mySubjects, myGyroXid, myGyroYid, myGyroZid )
## head(myGyroXYZid)
## dim(myGyroXYZid)
## names(myGyroXYZid)

gryffindorGYRO <- myGyroXYZid

## Now we include TOTAL. 

###### This is the TOTAL-X set ##############

## The first operation is to paste the subject's ID onto the total data.
## The variables are loaded via code elsewhere. They are:
## mySubjects
## myTotalX

myTotalXid <- cbind( mySubjects, myTotalX)

## Set the initial variables. Use = NULL to create a blank vector for the names.

## Initialize:
myNameVariable <- "TotalX"
myColumnVariable <- 1
myDepthDataColNames = NULL

for (i in 1:128 ) {
myDepthDataColCalculator <- c( paste(myNameVariable, myColumnVariable , sep="") )
myDepthDataColNames <- append( myDepthDataColNames, myDepthDataColCalculator )
myColumnVariable <- myColumnVariable + 1
}

## head(myDepthDataColNames)

myTotalColNames <- c("Subject", myDepthDataColNames)
colnames(myTotalXid) <- myTotalColNames


#################### Total-X ends here

###### This is the Total-Y set ##############

## The first operation is to paste the subject's ID onto the body_Total data.
## The variables are loaded via code elsewhere. They are:
## mySubjects
## myTotalY

myTotalYid <- cbind( mySubjects, myTotalY)

## Set the initial variables. Use = NULL to create a blank vector for the names.

## Initialize:
myNameVariable <- "TotalY"
myColumnVariable <- 1
myDepthDataColNames = NULL

for (i in 1:128 ) {
myDepthDataColCalculator <- c( paste(myNameVariable, myColumnVariable , sep="") )
myDepthDataColNames <- append( myDepthDataColNames, myDepthDataColCalculator )
myColumnVariable <- myColumnVariable + 1
}

## head(myDepthDataColNames)

myTotalColNames <- c("Subject", myDepthDataColNames)
colnames(myTotalYid) <- myTotalColNames


#################### Total-Y ends here

###### This is the Total-Z set ##############

## The first operation is to paste the subject's ID onto the body_Total data.
## The variables are loaded via code elsewhere. They are:
## mySubjects
## myTotalZ

myTotalZid <- cbind( mySubjects, myTotalZ)

## Set the initial variables. Use = NULL to create a blank vector for the names.

## Initialize:
myNameVariable <- "TotalZ"
myColumnVariable <- 1
myDepthDataColNames = NULL

for (i in 1:128 ) {
myDepthDataColCalculator <- c( paste(myNameVariable, myColumnVariable , sep="") )
myDepthDataColNames <- append( myDepthDataColNames, myDepthDataColCalculator )
myColumnVariable <- myColumnVariable + 1
}

## head(myDepthDataColNames)

myTotalColNames <- c("Subject", myDepthDataColNames)
colnames(myTotalZid) <- myTotalColNames



#################### Total-Z ends here

## We need to merge in a new way due to the naming.

myTotalXid$Subject <- NULL
myTotalYid$Subject <- NULL
myTotalZid$Subject <- NULL
myTotalXYZid <- cbind ( mySubjects, myTotalXid, myTotalYid, myTotalZid )
## head(myTotalXYZid)
## dim(myTotalXYZid)
## names(myTotalXYZid)

gryffindorTOTAL <- myTotalXYZid

gryffindorACC$V1 <- NULL
gryffindorGYRO$V1 <- NULL
gryffindorTOTAL$V1 <- NULL
gryffindorFULL <- cbind ( mySubjects, gryffindorACC, gryffindorGYRO, gryffindorTOTAL )
## head(gryffindorFULL)
## dim(gryffindorFULL)
## names(gryffindorFULL)

## End of 10 Points to Gryffyndor (training set)

###########


## (II.2.trainSet) Frodo's Frisbees (Working with the Test Data)  (training data set)


## The next operation is to meld the Activity, Features and Subjects. The variables are:
## myX
## myY
## mySubjects

## Two of our variables aren't clear, so we'll reload them into clearer names 
mytrainData <- myX
mytrainActivityids <- myY

## Now we need to add a column of literal names for the activity ids
## This code generates the literal activity names from the train data in preparation for the cbinds.

df1 <- data.frame(mytrainActivityids)
myData <- NULL
activityType <- function(x) { 
if(x == 1) y <- "WALKING"
if(x == 2) y <- "WALKING_UPSTAIRS"
if(x == 3) y <- "WALKING_DOWNSTAIRS"
if(x == 4) y <- "SITTING"
if(x == 5) y <- "STANDING"
if(x == 6) y <- "LAYING"
return(y)
}
myData <- sapply(df1$V1, activityType)
x <- myData
mytrainActivityNames <- matrix(unlist(x), ncol=length(1) )
mytrainActivityIdsNames <- cbind( mytrainActivityids, mytrainActivityNames )

## Now we cbind, then cbind again for the Subject ID's:

mytrainid <- cbind ( mytrainActivityIdsNames, mytrainData )
mytrainidSubjectid <- cbind ( mySubjects , mytrainid )

## We now have a table of 2947 obs x 564 variables with subject, activity, activity name, and the data vector. This looks like it would benefit from some better column names.

myFeaturesWorking <- myFeatures
myFeaturesWorking$V1 <- NULL
myFeaturesCols <- t(myFeaturesWorking)
featureNames <- myFeaturesCols
myColNames <- c("Subject", "Activity", "ActivityName", featureNames)
colnames(mytrainidSubjectid) <- myColNames

frodosFrisbees <- mytrainidSubjectid


## (II.3.trainSet) The Sorting Hat (Frodo vs Gryffindor) (training data set)

## So we have two data sets. Gryffindor, the detail data, 2947 x 385; Frodo, the train data; 2947 x 563. 
## What if we bind the two into one huge data set?

myMegaDataTrainSet <- cbind( frodosFrisbees , gryffindorFULL )
## names(myMegaDataTrainSet)

## There you have it folks. One jumbo set by Subject, showing activity and all the depth data. 2947 x 948.
## Code works - paste full file into R. 01/23/15 1:36pm
## All systems go - final approval on full file confirmed. 01/24/15 9:16a.

## Additional updates: 1/24/15 09:24:00 myMegaData was updated to myMegaDataTrainSet to account for second training set. None of the other variables was updated in this way, so frodosFrisbees and gryffindorFULL will depend on which script is being run.

## :Which Set ID" script - this is the training Set script (TRAIN, variable = 2)

myRowCount <- nrow(myMegaDataTrainSet)
x <- rep(2, myRowCount )
whichSetId <- matrix(unlist(x), ncol=length(myRowCount) )
myColNames <- c("WhichSet")
colnames(whichSetId) <- myColNames
myMegaDataTrainSet2 <- cbind ( whichSetId, myMegaDataTrainSet )

## End of The Sorting Hat (training set).

####################

##
## (C.) Frodo's Journey - Isolating the Means and Stds, Creating the Aggregate, 
##		Writing out the final results
## 

## (1) Leaving the Shire (and all the little rivers and woodlands)
## Shire Part 1 & 2 - Merging the two sets

myMegaDataFullSet <- rbind ( myMegaDataTestSet2, myMegaDataTrainSet2 )

## Completed. We have Left The Shire.


## (2) Heading to Amon Sul (The Great Watchtower) - Extracting MEAN and STD

myGreppedMeanData <- myMegaDataFullSet[grep("mean",names(myMegaDataFullSet))]
myGreppedStdData <- myMegaDataFullSet[grep("std",names(myMegaDataFullSet))]
myGreppedDataHeaders <- myMegaDataFullSet[,1:4]
myGreppedCbind <- cbind( myGreppedDataHeaders, myGreppedMeanData, myGreppedStdData )
myMegaDataFullSetMeanStd <- myGreppedCbind

## This works and creates the new requested data set, "myMegaDataFullSetMeanStd". We have made it to Amon Sul.
## myMegaDataFullSetMeanStd has 10299 obs x 83 variables.



## (3) The Road to Rivendell

## To get to Rivendell, we need to take "myMegaDataFullSetMeanStd" and create a second, independent tidy data set with the average of each variable for each activity and each subject. This is a subtotaling exercise involving averages. I am interpreting this to mean that we average By Subject By Activity (since one Subject has several Activities).

## Here is the consolidated code for the Mean set:

## [snip]

## But oops, we have different numbers of rows (by 1) - how'd that happen?

## Well, it happened because Frodo and company got very lost. We were really just trying to test the rowMeans command in a simple way on the main database. And it worked, but we don't need to formally build it in, because we're going to perform some new operations on it.



## (4) Lost on the Misty Downs - Creating the Summary Data Set

## So we're back to needing to apply colMeans to myMegaDataFullSetMeanStd in terms of getting a new summary data set that summarizes by subject by activity.

library(plyr)
MyGrepMeanNames <- names(myGreppedMeanData)
MyGrepStdNames <- names(myGreppedStdData)
MyDataNames <- c( MyGrepMeanNames, MyGrepStdNames)
cdata.means <- aggregate(myMegaDataFullSetMeanStd[c(MyDataNames)], by = myMegaDataFullSetMeanStd[c("Subject","Activity","ActivityName","WhichSet")], FUN=mean)
cdata.means2  <- arrange(cdata.means, Subject, Activity)

## This works!

##Now, update the data file with better naming convention.
## the final data involves 180 obs of 3 variables
finalAnalysis.data <- cdata.means2

## Extract names for codebook (optional - for developer reference)
## myCodebookNames <- names(finalAnalysis.data)
## write.table(myCodebookNames, file = "MyCodebookNames.txt", row.names = FALSE, col.names = TRUE)


## (5) Getting to Rivendell In Time For Dinner
## (..."but I don't like green food...")

## The code below resets the working directory and does the write.table to export the new, clean data set into a *.txt file.

setwd("/Users/nightshade/datamaximus/data/")
write.table(finalAnalysis.data, file = "UCIHAR_finalAnalysisData.txt", row.names = FALSE,
            col.names = TRUE)

## You made it! Enjoy dinner at Rivendell!

## DONE 01/24/15 7:36p.
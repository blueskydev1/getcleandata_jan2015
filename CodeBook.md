==================================================================
Getting and Cleaning Data Course Project - January 2015
UCI HAR Dataset Analysis
Katherine R. Lieber
January 25, 2014

Project Codebook

==================================================================
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone for 30 volunteers performing 6 activities. The UCI HAR Dataset consists of a number of nested folders containin main data and inertial detail data on 3-axial linear acceleration and 3-axial angular velocity obtained from smartphone sensors. The original data may be found online at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The complete range of original variables are well-documented in the UCI HAR Dataset README and features.txt (list of the 561 variables of inertial data) and features_info.txt (description of the inertial and master data). Users are referred to these documents for descriptions of the original data.

==================================================================
Script Process - Summary of Transformations

A. Working on the Test Set
I.1 Creates and populates a variety of variables from the UCH HAR files.
II.1 Assembles the ACC, GYRO, and TOTAL inertial data into a single dataset.
II.2 Assembles the inertial and main data. Binds in the Activity, Features and Subjects.
II.3 Assembles the full Test data into a single dataset.

B. Working on the Training Set
I.1 Creates and populates a variety of variables from the UCH HAR files.
II.1 Assembles the ACC, GYRO, and TOTAL inertial data into a single dataset.
II.2 Assembles the inertial and main data. Binds in the Activity, Features and Subjects.
II.3 Assembles the full Training data into a single dataset.

C. Isolating the Means and Stds, Creating the Aggregate, Writing out the final results
1. Merges the full Test and full Training datasets.
2. Extracts MEAN and STD data.
3. Creates the summary data set of averages.
4. Performs write.file on the final file and exports it to a *.txt file in the data directory.

==================================================================
Script Process - Detail of Transformations

The following processes were performed in the indicated sequence to transform the data. The whimsical names have been left in as they serve as useful memory-triggers to follow the sequence of steps in this codebook and in the run_analysis.r script.

Note that the full narrative of these steps is also included as part of the run_anaysis.r script.

########

(A.) Test Set Operations

########

(I.1) Load the Variables

read the text files into R (these examples assume you have already setwd())
myFeatures has 561 obs of 2 variables representing the type of acceleration data gathered (ex. "tBodyAcc-mean()-X")

First, we confirm the deepest data is consistent (it is)
these yield length 128 variables - confirmed for all files as per the code below, which 

next, we move up a level 
we find that mySubjects contains 2947 obs of 1 variable 
in this file subject_train, the rows (observations) identify the subject of the 
myX contains 2947 obs of 5 variables. It is identified as the "training set" but they don't link it to the acc/gyro/total data.
myY contains 2947 obs of 1 variables. It is identifie as the test labels


(II.1) 10 Points To Gryffindor (detail data ACC, GYRO, TOTAL)

The following operations were performed on each of the following inertial data sets (ACC-X, ACC-Y, ACC-Z, GYRO-X, GYRO-Y, GYRO-Z, TOTAL-X, TOTAL-Y, TOTAL-Z).

The first operation is to paste the subject's ID onto the body_acc data.
The variables are loaded via code elsewhere. They are:
mySubjects
myAccX
Set the initial variables. 
Add an identifier involving type + dimension (x. "AccY") so that the ACC, GYRO, and TOTAL data columns for dimensions X, Y and Z are all clearly identifiable from one another once they are merged into a single dataset. 
Update the column names in the data set with the descriptive names. 

The final dataset for the inertial data is loaded into the variable "gryffindorFULL".

(II.2) Frodo's Frisbees (Test Data)

The next operation is to meld the Activity, Features and Subjects of the main dataset. The variables are:
myX
myY
mySubjects

Two of our variables aren't clear, so we'll reload them into clearer names 
myTestData <- myX
myTestActivityids <- myY

Now we need to add a column of literal (descriptive text) names to accompany the activity ids
The code in the script generates the literal activity names from the test data in preparation for the cbinds.
Now we cbind, then cbind again for the Subject ID's:

We now have a table of 2947 obs x 564 variables with subject, activity, activity name, and the data vector. This looks like it would benefit from some better column names.

The final result is loaded into the variable "frodosFrisbees".

(II.3) The Sorting Hat (Frodo vs Gryffindor)

We now have two data sets. gryffindorFULL, the detail data, 2947 x 385; frodosFrisbees, the test data; 2947 x 563. 
We bind the two into one huge data set, "myMegaDataTestSet".
Which Set ID is added to create a column to identify  - this is the Test Set one (variable = 1)

########

(B.) Training Set Operations

########

The same operations in Item A are performed again, only this time on the Training Set located in the TRAIN folder.

The Test and Training versions of these operations were conceived to be able to run totally independently of one another so there are some aspects of loading the main variables and generating the Gryffindor dataset which are repeated. Although both scripts end up being integrated into a single master script, it could be conceived that each might be extracted to run separately. I maintain that the duplication is worth being able to isolate each operation completely as a standalone script, as desired.

(I.1) Load the Variables
(II.1) 10 Points To Gryffindor (detail data ACC, GYRO, TOTAL)
(II.2) Frodo's Frisbees (Training Data)
(II.3) The Sorting Hat (Frodo vs Gryffindor)

The resulting final dataset is "myMegaDataTrainSet".

########

(C.) Frodo's Journey - Isolating the Means and Stds, Creating the Aggregate, 
		Writing out the final results


(1) Leaving the Shire 
The two data sets created in Parts A and B are merged into "myMegaDataFullSet".

(2) Heading to Amon Sul (The Great Watchtower) - Extracting MEAN and STD
The GREP command is used to subset on columns containing the string MEAN.
The GREP command is used to subset on columns containing the string STD.
The first four columns of non-numeric data are pulled into myGreppedDataHeaders.
A cbind combines all of the resulting data back into one large dataset, "myMegaDataFullSetMeanStd".

(3) The Road to Rivendell
[snip]
This section was later relocated into other operations, but left here for clarity in re-creating the thought process.

(4) Lost on the Misty Downs - Creating the Summary Data Set
We apply colMeans to myMegaDataFullSetMeanStd to get a new summary data set that summarizes by subject by activity.
PLYR is used along with the AGGREGATE command to sub-summarize on Subject and Activity.
The working name of this dataset is then given a proper naming convention.
The resulting file is the final dataset and is called "finalAnalysis.data"

(5) Getting to Rivendell In Time For Dinner
The last step in the script resets the working directory and performs the write.table to export the new, clean data set into a *.txt file.
The final dataset is called finalAnalysis.data.
The final output file is called UCIHAR_finalAnalysisData.txt.

End of Process Steps

==================================================================
Script Assessment

The script run_analysis.r performs all of the processing as required for the assignment, as below:

1. Merges the training and the test sets to create one data set.2. Extracts only the measurements on the mean and standard deviation for each measurement.3. Uses descriptive activity names to name the activities in the data set4. Appropriately labels the data set with descriptive variable names.5. From the data set in step 4, creates a second, independent tidy data set with the average of eachvariable for each activity and each subject.

==================================================================
Codebook of Variables

These are the variables found in the "UCIHAR_finalAnalysisData.txt" final data set as created by the script run_analysis.r. 

"Subject" - a number 1-30 representing the subject
"Activity" - a number 1-6 representing the activity
"ActivityName" - a text description representing the activity
"WhichSet" - a number 1-2 representing test or training set; 1=test, 2=training

The variables below represent the extracted MEAN and STD related data as output into the final dataset. 
"tBodyAcc-mean()-X"
"tBodyAcc-mean()-Y"
"tBodyAcc-mean()-Z"
"tGravityAcc-mean()-X"
"tGravityAcc-mean()-Y"
"tGravityAcc-mean()-Z"
"tBodyAccJerk-mean()-X"
"tBodyAccJerk-mean()-Y"
"tBodyAccJerk-mean()-Z"
"tBodyGyro-mean()-X"
"tBodyGyro-mean()-Y"
"tBodyGyro-mean()-Z"
"tBodyGyroJerk-mean()-X"
"tBodyGyroJerk-mean()-Y"
"tBodyGyroJerk-mean()-Z"
"tBodyAccMag-mean()"
"tGravityAccMag-mean()"
"tBodyAccJerkMag-mean()"
"tBodyGyroMag-mean()"
"tBodyGyroJerkMag-mean()"
"fBodyAcc-mean()-X"
"fBodyAcc-mean()-Y"
"fBodyAcc-mean()-Z"
"fBodyAcc-meanFreq()-X"
"fBodyAcc-meanFreq()-Y"
"fBodyAcc-meanFreq()-Z"
"fBodyAccJerk-mean()-X"
"fBodyAccJerk-mean()-Y"
"fBodyAccJerk-mean()-Z"
"fBodyAccJerk-meanFreq()-X"
"fBodyAccJerk-meanFreq()-Y"
"fBodyAccJerk-meanFreq()-Z"
"fBodyGyro-mean()-X"
"fBodyGyro-mean()-Y"
"fBodyGyro-mean()-Z"
"fBodyGyro-meanFreq()-X"
"fBodyGyro-meanFreq()-Y"
"fBodyGyro-meanFreq()-Z"
"fBodyAccMag-mean()"
"fBodyAccMag-meanFreq()"
"fBodyBodyAccJerkMag-mean()"
"fBodyBodyAccJerkMag-meanFreq()"
"fBodyBodyGyroMag-mean()"
"fBodyBodyGyroMag-meanFreq()"
"fBodyBodyGyroJerkMag-mean()"
"fBodyBodyGyroJerkMag-meanFreq()"
"tBodyAcc-std()-X"
"tBodyAcc-std()-Y"
"tBodyAcc-std()-Z"
"tGravityAcc-std()-X"
"tGravityAcc-std()-Y"
"tGravityAcc-std()-Z"
"tBodyAccJerk-std()-X"
"tBodyAccJerk-std()-Y"
"tBodyAccJerk-std()-Z"
"tBodyGyro-std()-X"
"tBodyGyro-std()-Y"
"tBodyGyro-std()-Z"
"tBodyGyroJerk-std()-X"
"tBodyGyroJerk-std()-Y"
"tBodyGyroJerk-std()-Z"
"tBodyAccMag-std()"
"tGravityAccMag-std()"
"tBodyAccJerkMag-std()"
"tBodyGyroMag-std()"
"tBodyGyroJerkMag-std()"
"fBodyAcc-std()-X"
"fBodyAcc-std()-Y"
"fBodyAcc-std()-Z"
"fBodyAccJerk-std()-X"
"fBodyAccJerk-std()-Y"
"fBodyAccJerk-std()-Z"
"fBodyGyro-std()-X"
"fBodyGyro-std()-Y"
"fBodyGyro-std()-Z"
"fBodyAccMag-std()"
"fBodyBodyAccJerkMag-std()"
"fBodyBodyGyroMag-std()"
"fBodyBodyGyroJerkMag-std()"

Feature Description - Excerpted from UCI HAR Dataset "features_info.txt".

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

Activity Labels

The six activities are:
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING





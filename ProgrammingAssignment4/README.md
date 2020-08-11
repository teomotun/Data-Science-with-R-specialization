# week4project
The orginial data is from UCI. It attempts to recognize Human Activity using the dataset acquired from smartphones. The dataset has entries for 30 volunteers doing six activities Walking, Walking Upstairs, Walking down, Sitting, Standing and Lying.
This codebook gives a description of the variables and methods used in compiling the final output tidyData.txt The features selected for this database come from time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.
Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).
We first load the file activity_labels.txt. It contains the six levels of type of Activity. The file is read and each activity is assigned a numerical for easy identification. The numerical is labeled as Category and name of activity is labeled as Activity.
Next we read the features.txt file. It contains all the features for the activities.
Reading the data
We use the grepl function to extract features with -mean( or -std( were selected.
We use the gsub function to substitute -mean and -std with Mean and Std to make the names more legible.
The data in X_Train is then read along with Y_train and subject_train and combined using cbind. The same is repeated for the test data set. The columns are names according to the data in features.txt.
Once we have all the data we find the average by user and activity.
Finally, the data is combined and output as week4.txt

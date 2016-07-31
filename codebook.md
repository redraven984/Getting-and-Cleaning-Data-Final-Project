Codebook.md

About
=====
This code book will describe the variables in the tidy data set, the input data, and details about the transformations performed while composing the tidy data set.

Tidy Data Frame Variables
===============================
- Gravitational Accelerometer Raw
- Gravitational Accelerometer Jerk Raw
- Body Gyroscope Raw
- Body Accelerometer Raw
- Body Accelerometer Jerk Raw
- Gravitational Accelerometer FFT
- Gravitational Accelerometer Jerk FFT
- Body Gyroscope FFT
- Gravitational Accelerometer FFT
- Body Accelerometer FFT
- Body Accelerometer Jerk FFT

Input Data
==========
The input data for this project comes from the accelerometers and the gyroscopes of a mobile device. The accelerometers and the gyroscopes are mounted in three directions X,Y and Z. This is customary and mems chips typically have the xy,z mounted devices on a single chip.
The data is taken from a group of 30 individuals each performing six activities - walking, walking upstairs, walking downstairs, sitting, standing, and laying. Furethermore, the data is sampled at 50Hz and each user provides 128 data points.
Lastly, of the many input features to the data set, only the features corresponding to the mean of the measurements or the standard deviation of the mesurements are retained in the final data set. 


Transformations
===============
The transformations performed are used to fulfill the requirements of the project:
- Merges the training and the test sets to create one data set.
-- Here we load both the training and the testing data (including the user and activity labels) and merge the data sets using the rbind commmand.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
-- Here we use grep to identify which column name include "mean" and "str". Then using the indicies of these columns we subset the data frame and extract only the desired columns.
- Uses descriptive activity names to name the activities in the data set.
-- After the correct data is extracted we use sub() to replace the activity codes: 1-6 with the proper names: Walking, Walking Upstairs...
- Appropriately labels the data set with descriptive variable names. 
-- Here again we use the sub() command to remove characters like, '-', and to fully write out names, for ex. Accelerometer vs Acc.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
-- Lastly, we use the base command aggregate to collect the data by user and then by activity and to provide the mean value for each feature.

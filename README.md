Getting and Cleaning data course project Repository.
==============

This repository contains 3 different files:

* Readme.md: Contains information about this repository
* CodeBook.md: describes the variables, the data, and transformations of the resultant tidy data.
* run\_analysis.R

## Generating the tidy data.
### Overview
run\_analysis.R has the code to create tidy data from the [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
To generate the tidy data you need to call the run\_analysis function, this function has two optional parameters:

* dirname: directory from where to read the uncompressed UCI HAR Dataset, it defaults to 'UCI HAR Dataset/'
* destfile: file where to store the tidy data generated, it defaults to 'tidyData.txt'

Return value of run\_analysis is a data frame with the tidy data that gets generated.

Two helper functions have been created:

* test\_file( filename ): verifies if the file 'filename' exists, if not then the program will stop with an error message.
* read\_data( directory,dataname,features ): reads the 'dataname' (expected to be 'train' or 'test' ) data set, subjects and activities from 'directory' it then filters columns by interested 'features', and appends subject and activities.

### Process

1. Verify if directory exists and if it has the required structure (i.e directory contains 'train' and 'test' directories and 'features.txt' and 'activity\_labels.txt' files) testing for file existance using test\_file function.
2. Reads the features and filters them to keep only the 'std()' and 'mean()' variables.
3. Replaces variable names from original data to make variable names meaningfull, this is the list of changes done (camelCase is used to enhance readability of data variables):
    * Variables beginning with 't' will begin with 'timeDomain'.
    * Variables beginning with 'f' will begin with 'frequencyDomain'. 
    * Variables where the Accelerometer was used to get the data will have the 'Accelerometer' word instead of 'Acc'.
    * Variables where the Gyroscope was used to get the data will have the 'Gyroscope' work instead of 'Gyro'.
    * Variables calculated used the mean will contain the word Mean instead of mean().
    * Variables calculated using std will contain the word StandardDeviation instead of std().
    * X is replaced with XAxis.
    * Y is replaced with YAxis.
    * Z is replaced with ZAxis.
    * Mag is replaced with Magnitude.
4. Reads the activity\_labels from activity\_labels.txt
5. Reads train set using the read_data function and store it in a variable 'data'.
6. Appends the test set to 'data' using rbind and read_data functions.
7. Relabels activities to use the activity name instead of using it's integer identifier.
8. Read subjects and activities from data and store them in different vectors (this is required to not duplicate columns when aggregating the data set)
9. Remove subjects and activities from 'data'.
10. Create the tidyData running aggregate using subjects and activities as key and mean as function.
11. write the tidyData to destfile
12. return tidyData
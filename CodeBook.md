UCI HAR Tidy Dataset
==============

The dataset contains 68 different variables, key variables is the pair (subject,activity).

* **subject** : Identifier of subject who carried the experiment, values are from 1 to 30
* **activity** : Activity realized in the experiment, value is one of these
    * WALKING
    * WALKING_UPSTAIRS
    * WALKING_DOWNSTAIRS
    * SITTING
    * STANDING
    * LAYING

The rest of variables each is the mean of all values for each key from the merged training and testing sets taken from the [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The dataset contains only information of those variables that were estimated by mean and std functions from the original dataset leaving in this way a total of 66 variables, these variables were relabeled in the following way. 

* **Time domain variables**: Prefix is timeDomain
* **Frequency domain variables**: Prefix is frequencyDomain
* **Accelerometer data**: Accelerometer is used instead of Acc
* **Gyroscope data**: Gyroscope is used instead of Gyro
* **X Axis labels**: XAxis is used instead of X
* **Y Axis labels**: YAxis is used instead of Y
* **Z Axis labels**: ZAxis is used instead of Z
* **Magnitude variables** : Magnitude word is used instead of Mag
* **Mean variables**: Variables estimated using mean use the word Mean instead of mean()
* **Std variables**: Variables estimated using std use the word StandardDeviation instead of std()

test_file <- function(filename){
    if(!file.exists(filename)){
        stop(filename, " Does not exist")
    }
}
read_data <- function(directory, dataname, features) {
    data_file <- paste(directory, "/X_", dataname,".txt", sep="") 
    subjects_file <- paste(directory, "/subject_", dataname, ".txt", sep="")
    activities_file <- paste(directory, "/y_" , dataname, ".txt", sep="")
    test_file(data_file)
    test_file(subjects_file)
    test_file(activities_file)
    res_data <- read.table(data_file, header = FALSE, colClasses = "numeric")
    subjects <- read.table(subjects_file, header = FALSE, colClasses = "numeric")
    activities <- read.table(activities_file, header = FALSE, colClasses = "numeric")
    res_data <- res_data[,features[,1]]
    names(res_data) <- features[,2]
    res_data$subject <- subjects[,1]
    res_data$activity <- activities[,1]
    res_data
} 

run_analysis <- function(dirname,destfile){
    #First verify we have the directory structure we need
    test_file(dirname)
    train_directory <- paste(dirname, "/train/", sep="")
    test_directory  <- paste(dirname, "/test/", sep="")
    features_file <- paste(dirname,"/features.txt",sep="")
    activity_labels_file <- paste(dirname,"/activity_labels.txt",sep="")
    test_file(train_directory)
    test_file(test_directory)
    test_file(features_file)
    test_file(activity_labels_file)
    #Read features file and filter for std() and mean()
    features <- read.csv(features_file, header = FALSE, sep=" ")
    std_feats <- grep("std\\(\\)", features[,2])
    mean_feats <- grep("mean\\(\\)",features[,2])
    features <- features[c(std_feats,mean_feats),]
    features[,2] <- gsub("^t","timeDomain",features[,2])
    features[,2] <-gsub("^f","frequencyDomain",features[,2])
    features[,2] <-gsub("Acc","Accelerometer",features[,2])
    features[,2] <-gsub("Gyro","Gyroscope",features[,2])
    features[,2] <-gsub("mean\\(\\)","Mean",features[,2])
    features[,2] <-gsub("std\\(\\)","StandardDeviation",features[,2])
    features[,2] <-gsub("Mag","Magnitude",features[,2])
    features[,2] <-gsub("X","XAxis",features[,2])
    features[,2] <-gsub("Y","YAxis",features[,2])
    features[,2] <-gsub("Z","ZAxis",features[,2])
    #Read activity labels
    activity_labels <- read.table(activity_labels_file, header = FALSE)
    #Read training data set
    data <- read_data(train_directory, "train", features)
    #Append test data set
    data <- rbind(data,read_data(test_directory,"test",features))
    #Replace activity with activityname
    data$activity <- activity_labels[data$activity,2]
    #Get subjects
    subjects <- data$subject
    #Get activities
    activities <- data$activity
    #Remove subjects, activities to use them to aggregate
    data <- data[,1:66]
    tidyData <- aggregate(data, list( subject = subjects , activity = activities ),mean)
    write.table(tidyData,file = destfile,row.names = FALSE)
    tidyData
}
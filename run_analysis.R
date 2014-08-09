ObtainFiles <- function() {
  download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                destfile ="getdata-projectfiles-UCI HAR Dataset.zip", method = "curl")
  unzip("getdata-projectfiles-UCI HAR Dataset.zip")
}

MergeTrainingAndTest <- function() {
  train.X.data <- read.table("UCI HAR Dataset/train/X_train.txt")
  test.X.data <- read.table("UCI HAR Dataset/test/X_test.txt")
  rbind(train.X.data, test.X.data)
}

ExtractMeanAndStd <- function(data) {
  features <- read.table("UCI HAR Dataset/features.txt")[[2]]
  names(data) <- features
  have.mean.or.std <- grep("mean\\(\\)|std()", features)
  data[, have.mean.or.std]
}

UseDescriptiveActivityNames <- function(data) {
  train.y.data <- read.table("UCI HAR Dataset/train/y_train.txt")
  test.y.data <- read.table("UCI HAR Dataset/test/y_test.txt")
  y.data <- rbind(train.y.data, test.y.data)
  
  activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt")
  activities <- merge(y.data, activity.labels, by.y = "V1")
  data$Activity <- activities[[2]]
  data
}
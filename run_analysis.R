ObtainFiles <- function() {
  download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                destfile ="getdata-projectfiles-UCI HAR Dataset.zip", method = "curl")
  unzip("getdata-projectfiles-UCI HAR Dataset.zip")
}

MergeTrainingAndTest <- function() {
  train.x.data <- read.table("UCI HAR Dataset/train/X_train.txt")
  test.x.data <- read.table("UCI HAR Dataset/test/X_test.txt")
  rbind(train.x.data, test.x.data)
}

ExtractMeanAndStd <- function(data) {
  features <- read.table("UCI HAR Dataset/features.txt")[[2]]
  names(data) <- features
  have.mean.or.std <- grep("mean\\(\\)|std()", features)
  data[, have.mean.or.std]
}
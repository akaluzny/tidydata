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

RunAnalysis <- function() {
  # Download file from given location and unzip its contents
  download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                destfile ="getdata-projectfiles-UCI HAR Dataset.zip", method = "curl")
  unzip("getdata-projectfiles-UCI HAR Dataset.zip")
  
  # Read all the feature vectors and combine them together
  feature.data <- rbind(read.table("UCI HAR Dataset/train/X_train.txt"), read.table("UCI HAR Dataset/test/X_test.txt"))
  
  # Read all feature vector names, which are in the second column of the file, and assign them to feature data frame columns
  feature.names <- read.table("UCI HAR Dataset/features.txt")[[2]]
  names(feature.data) <- feature.names
  
  # Extract only those features that have mean() or std() in the name. Features with meanFreq are not included.
  feature.data <- feature.data[, grep("mean\\(\\)|std()", feature.names)]
  
  # Read all the activity data and combine it together
  activity.data <- rbind(read.table("UCI HAR Dataset/train/y_train.txt"), read.table("UCI HAR Dataset/test/y_test.txt"))
  
  # Read activity descriptive names
  activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt")
  
  # Merge activity data with descriptive names. Id will be in the first column and description in the second column.
  activity.data <- merge(activity.data, activity.labels, by.y = "V1")
  
  # Read all the subject data and combine it together
  subject.data <- rbind(read.table("UCI HAR Dataset/train/subject_train.txt"), read.table("UCI HAR Dataset/test/subject_test.txt"))
  
  # Aggregate feature data by activity and subject
  tidy <- aggregate(feature.data, list(Activity = activity.data[[2]], Subject = subject.data[[1]]), mean)
  
  write.table(tidy, "tidy.txt")
}
"Checks for data directory and creates one if it doesn't exist"
if (!file.exists("data")) {
  message("Creating data directory")
  dir.create("data")
}
if (!file.exists("data/UCI HAR Dataset")) {
  # download the data
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  zipfile="data/UCI_HAR_data.zip"
  message("Downloading data")
  download.file(fileURL, destfile=zipfile)
  unzip(zipfile, exdir="data")
}


"Merge training and test datasets"


# Read data
training.x <- read.table("data/UCI HAR Dataset/train/X_train.txt")
training.y <- read.table("data/UCI HAR Dataset/train/y_train.txt")
training.subject <- read.table("data/UCI HAR Dataset/train/subject_train.txt")

test.x <- read.table("data/UCI HAR Dataset/test/X_test.txt")
test.y <- read.table("data/UCI HAR Dataset/test/y_test.txt")
test.subject <- read.table("data/UCI HAR Dataset/test/subject_test.txt")

# Merge
merged.x <- rbind(training.x, test.x)
merged.y <- rbind(training.y, test.y)
merged.subject <- rbind(training.subject, test.subject)

"Read the feature list based on the previous merged training dataset"

# Read the feature list file 
features <- read.table("data/UCI HAR Dataset/features.txt")
#Extracts only the measurements on the mean and standard deviation for each measurement
indices_of_good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
#and Appropriately labels the data set with descriptive activity names
merged.x<- merged.x[, indices_of_good_features]
names(merged.x) <- features[indices_of_good_features, 2]
names(merged.x) <- gsub("\\(|\\)", "", names(merged.x))
names(merged.x) <- tolower(names(merged.x))

activities <- read.table("data/UCI HAR Dataset/activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
merged.y[,1] = activities[merged.y[,1], 2]
names(merged.y) <- "activity"

names(merged.subject) <- "subject"
cleaned <- cbind(merged.subject, merged.y, merged.x)


# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.
uniqueSubjects = unique(merged.subject)[,1]
numSubjects = length(unique(merged.subject)[,1])
numActivities = length(activities[,1])
numCols = dim(cleaned)[2]
result = cleaned[1:(numSubjects*numActivities), ]
row = 1
for (s in 1:numSubjects) {
  for (a in 1:numActivities) {
    result[row, 1] = uniqueSubjects[s]
    result[row, 2] = activities[a, 2]
    tmp <- cleaned[cleaned$subject==s & cleaned$activity==activities[a, 2], ]
    result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}
write.table(result, "data/tidy_data_result.txt")

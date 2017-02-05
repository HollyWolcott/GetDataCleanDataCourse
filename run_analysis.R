library("reshape2")
#download and unzip files
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","./data/proj.zip")
unzip("./data/proj.zip")

# Load activity labels + features into R
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
activity_labels[,2] <- as.character(activity_labels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract column numbers for only the data on mean and standard deviation
features_subset <- grep(".*mean.*|.*std.*", features[,2])
#select names of each column that contains mean or std
features_subset.names <- features[features_subset,2]
#clean names
features_subset.names <- gsub('-mean', 'Mean', features_subset.names)
features_subset.names <- gsub('-std', 'Std', features_subset.names)
features_subset.names <- gsub('[-()]', '', features_subset.names)

# Load the datasets, only load mean and std data
#Merge datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[features_subset]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[features_subset]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

merged_data <- rbind(train, test)

# Add data labels

colnames(merged_data) <- c("subject", "activity", features_subset.names)

# turn activities & subjects into factors
merged_data$activity <- factor(merged_data$activity, levels = activity_labels[,1], labels = activity_labels[,2])
merged_data$subject <- as.factor(merged_data$subject)

#reshape the data
merged_data.melted <- melt(merged_data, id = c("subject", "activity"))
merged_data.mean <- dcast(merged_data.melted, subject + activity ~ variable, mean)

write.table(merged_data.mean, "tidy.txt", row.names = FALSE, quote = FALSE)

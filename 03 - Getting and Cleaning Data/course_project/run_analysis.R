
if (!file.exists("UCI HAR Dataset")) {
  message("Creating UCI HAR Dataset directory")
  dir.create("UCI HAR Dataset")
  
  # download the data
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  zipfile="UCI HAR Dataset/UCI_HAR_data.zip"
  message("Downloading data")
  download.file(fileURL, destfile=zipfile, method="curl")
  unzip(zipfile, exdir=".")
}

#===============================================================================
# Read files and load Data
#===============================================================================

#Column Names - As this Dataframe contains 2 columns we only want the 2nd one
message("Reading Features Data")
features.available <- read.table("UCI HAR Dataset/features.txt")[,2]

#activity labels
message("Reading Activity Label Data")
activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt")

#DATA
  #Test
  message("Reading Test Subject Data")
  test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
  message("Reading Test Data")
  test.X <- read.table("UCI HAR Dataset/test/X_test.txt")
  message("Reading Test Activity Data")
  test.y <- read.table("UCI HAR Dataset/test/y_test.txt")
  
  #Train
  message("Reading Train Subject Data")
  train.subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
  message("Reading Train Data")
  train.X <- read.table("UCI HAR Dataset/train/X_train.txt")
  message("Reading Train Activity Data")
  train.y <- read.table("UCI HAR Dataset/train/y_train.txt")

#===============================================================================
# Extract Data/Columns We need to work with - mean/standard deviation
#===============================================================================

#Produces indicies of columns we want to use
features.wanted <- grep("mean()|std()", features.available)

#Clean up the names - Make any additional changes here
features.cleaned <- gsub("()", "", features.available[features.wanted], fixed = TRUE)
features.cleaned <- gsub("mean", "Mean", features.cleaned, fixed = TRUE)
features.cleaned <- gsub("std", "StandardDeviation", features.cleaned, fixed = TRUE)
features.cleaned <- gsub("BodyBody", "Body", features.cleaned, fixed = TRUE)

#Add Names to the Activity Label Columns - Used for Merging later on
names(activity.labels) = c("ID", "ActivityType")

#Extract the columns we want to use out of the Test data
test.data <- test.X[,features.wanted]

#Assign the cleaned up feature names to the Test columns
names(test.data) <- features.cleaned

#append the user Data to the Test table
test.data$Subject = test.subject[,1]
test.data$Activity = test.y[,1]

#Extract the columns we want to use out of the Train data
train.data <- train.X[,features.wanted]

#Assign the cleaned up feature names to the Train columns
names(train.data) <- features.cleaned

#append the user Data to the Train table
train.data$Subject = train.subject[,1]
train.data$Activity = train.y[,1]

#Bind all the rows of both datasets together
data = rbind(test.data, train.data)

#Summarize the data by finding the mean of everthing
data.tidy <- aggregate(data, list(SubjectMean = data$Subject, ActivityMean = data$Activity), mean)

#Merge the Activity Labels to the Activity ID in the newly combined dataset
data.merged <- merge(data.tidy, activity.labels, by.x = "Activity", by.y = "ID")

#Write out the cleaned tidy data
write.table(data.merged , "tidy.txt", row.names=FALSE)

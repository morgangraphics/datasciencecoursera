#Getting and Cleaning Data


The purpose of this project is to demonstrate the  ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

###Course Project Requirements:

  1. a tidy data set as described below
  
  2. a link to a Github repository with your script for performing the analysis, and 
  
  3. a code book that describes the variables, the data, and any transformations or work that I performed
  

### run_analysis.R Requirements

  1. Merges the training and the test sets to create one data set.
  
  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  
  3. Uses descriptive activity names to name the activities in the data set
  
  4. Appropriately labels the data set with descriptive variable names. 
  
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  

**Running the script**

Remember, set current directory as the working directory.
Some of the data loading may take a while, I've added messages to show progress
  
    
**Assumptions**
  
  This README.md file also serves as the CODEBOOK

  KISS Mentality. While the data has been merged and some of the variables (column names) changed to meet the requirements, I didn't alter the 
  names drastically from the original dataset. Reinventing the wheel is not really necessary here. Additionally, making the variable
  names more readable often leads to ridiculously long names which is a pain to type. I kept things simple leaving the option to add more
  changes where needed.
  
  My variable names are standardized that logically groups things together (SUBJECT.INSTANCE) i.e.
  
   * features.available
   * features.wanted
   * features.cleaned
  
   This project is confusing enough, I didn't want to make it worse.
   This has the added benefit of showing progress without having to write a ton of comments explaining everything

**The Raw Data**

The original data and descriptions are located

  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
  
run_analysis.R automatically checks to see if the appropriate data is present before running. 
If it is not, it will download the data and unzip the file as needed

**Files of Note**

File                    | Description
-------------           | -------------
features.txt            | Lists the variable (a.k.a Column Names)
activity_labels.txt     | The activity that generates the data (WALKING, SITTING, etc)
subject_[test/tain].txt | Subject ID for the dataset
X_[test/tain].txt       | Dataset coresponding to the features
y_[test/tain].txt       | Subject activity data



**The Tidy Data**
The basic process is WELL documented in run_analyis.R file. We download the files, select 
columns that are the MEAN or STANDARD DEVIATION, and then combine the various datasets, output data to tidy.ext file according to the requirements.

The code below shows what has changed for Feature Names (Column Names)


````
features.cleaned <- gsub("()", "", features.available[features.wanted], fixed = TRUE)
features.cleaned <- gsub("mean", "Mean", features.cleaned, fixed = TRUE)
features.cleaned <- gsub("std", "StandardDeviation", features.cleaned, fixed = TRUE)
features.cleaned <- gsub("BodyBody", "Body", features.cleaned, fixed = TRUE)
````

1. Remove any Parens 
2. Capitalize Mean 
3. Change std to StandardDeviation 
4. Remove extra Body from name

The code is set up such that if needed, you can add more changes as required


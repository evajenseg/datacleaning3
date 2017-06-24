# Merges the training and the test sets to create one data set.
## 1: download and unzip
if(!file.exists("./mydata")) dir.create("./mydata") #create catalogue "mydata"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./mydata/projectData_getCleanData.zip")
unzipping <- unzip("./mydata/projectData_getCleanData.zip", exdir = "./mydata")

## 2: reading data to R
train.x <- read.table("./mydata/UCI HAR Dataset/train/X_train.txt")
train.y <- read.table("./mydata/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./mydata/UCI HAR Dataset/train/subject_train.txt") #info -subject who performed the activity
test.x <- read.table("./mydata/UCI HAR Dataset/test/X_test.txt")
test.y <- read.table("./mydata/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./mydata/UCI HAR Dataset/test/subject_test.txt")  #tester id's

## 3: merging data
Training_data <- cbind(subject_train, train.y, train.x)  #binding training data
Testing_data<- cbind(subject_test, test.y, test.x)     ##binding test results and tester's id
Combinded_data <- rbind(Training_data, Testing_data)  ##merging total data

#Extracts only the measurements on the mean and standard deviation for each measurement. 

## 1: extract mean and standard deviation from file "features"
File.features <- read.table("./mydata/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)[,2] #reading col 2 only
extract_mean_std <- grep(("mean\\(\\)|std\\(\\)"), File.features)   # all mean, std and ()
Extracted_data <- Combinded_data[, c(1, 2, extract_mean_std+2)]
colnames(Extracted_data) <- c("subject", "activity", File.features[extract_mean_std])  #names 2 first col to subject,activity, and names from extracts of file "features" 

#Uses descriptive activity names to name the activities in the data set

activity_labels <- read.table("./mydata/UCI HAR Dataset/activity_labels.txt") # read file who Links the class labels with their activity name
Extracted_data$activity <- factor(Extracted_data$activity, levels = activity_labels[,1], labels = activity_labels[,2])  #replacing numbers with activity labels

#Appropriately labels the data set with descriptive variable names. 

names(Extracted_data) <- gsub("\\()", "", names(Extracted_data))  #remove ()
names(Extracted_data) <- gsub("^t", "time", names(Extracted_data)) #remove firts t and "time"
names(Extracted_data) <- gsub("^f", "frequence", names(Extracted_data))     #remove first f and "frequence


# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
library(dplyr)
new_data <- Extracted_data %>%
  group_by(subject, activity) %>%
    summarise_each(funs(mean))
write.table(new_data, file="new_data.txt", row.names = FALSE)






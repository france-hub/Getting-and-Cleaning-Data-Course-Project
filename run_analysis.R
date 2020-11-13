rm(list = ls()) #Clean the workspace

library(data.table)

getwd()
setwd("~/Documents/CourseraAssignments/Getting_and_cleaning/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset") 

#Load in the test dataset, labels and subjects' id
dt_test <- fread("./test/X_test.txt")
test_lab <- fread("./test/y_test.txt", col.names = "labels")
dt_subj_test <- fread("./test/subject_test.txt", col.names = "subjects") 

#Load in the training dataset, labels and subjects' id
dt_train <- fread("./train/X_train.txt")
train_lab <- fread("./train/y_train.txt", col.names = "labels") 
dt_subj_train <- fread("./train/subject_train.txt", col.names = "subjects") 

#Load in features (same in both the datasets)
features <- fread("features.txt")

#Add a column with the activities id in the test dataset
dt_subj_test <- dt_subj_test[,c("activities"):= test_lab$labels]

#Set features as test data.table columnames 
dt_test <- dt_test[,.(setnames(dt_test, features$V2))]
dt_test <- cbind(dt_subj_test, dt_test)

#Add a column with the activities id in the train dataset
dt_subj_train <- dt_subj_train[,c("activities"):= train_lab$labels]

#Set features as test data.table columnames 
dt_train <- dt_train[,.(setnames(dt_train, features$V2))]
dt_train <- cbind(dt_subj_train, dt_train)

#1) Merge the two datasets into one
dt <- rbindlist(list(dt_test, dt_train))

#2) Extracts only the measurements on the mean and standard deviation for each measurement
dt_sub <- dt[,.SD, .SDcols = names(dt) %like% "subjects|activities|mean|std"]

#3) Uses descriptive activity names to name the activities in the data set
old_variables <- as.character(1:6)
new_variables <- c("WALKING", "WALKING_UP", "WALKING_DOWN", "SITTING", "STANDING", "LAYING")
dt_sub <- dt_sub[, activities := factor(activities, levels = old_variables, labels = new_variables)]

#4) From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
#for each activity and each subject
dt_mean <- dt_sub[,lapply(.SD,mean), .(activities, subjects)]

#Export the data as a txt file called "final"
write.table(dt_mean, "final.txt", row.names = FALSE)

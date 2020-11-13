The run_analysis.R script uses data.table package to get and clean the data assigned for the project by the following steps:
1- Import the data using the fread function:
  a) dt_test and dt_train are respectively the test and training datasets;
  b) test_lab and train_lab correspond to the activity_labels:1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS, 4 SITTING, 5 STANDING, 6 LAYING;
  c) dt_subj_test and dt_subj_train are the two datasets with the identifies the subject who performed the activity for each window sample;
  d) features contains all the features
2- Create clean test and train datasets:
  a) create dt_subj_test and dt_subj_train consisting each of two columns, one with the subjects' id and one with the labels' id
  b) set the features (same for the test and training dataset) as column names
  c) merge (cbind function) the dt_subj_test with the dt_test and the dt_subj_train with the dt_train
3- Merge the two (test and train) datasets into one (rbindlist function) called dt (requirement #1);
4- Extract only the measurements on the mean and standard deviation for each measurement (requirement #2);
5- Use descriptive activity names to name the activities in the data set (requirement #3):
  a) assign to a variable called old_variables the activity labels
  b) assign the related descriptive variables to a variable called new_variables (WALKING_DOWN = WALKING_DOWNSTAIRS, WALKING_UP = WALKING_UPSTAIRS)
  c) replace the numbers with the descriptive variables 
6- Create a second, independent tidy data set with the average of each variable for each activity and each subject
7- Write the final datasets in a txt file called final.txt

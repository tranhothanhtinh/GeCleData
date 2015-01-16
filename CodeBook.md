Getting and Cleaning Data Course Project CodeBook
=================================================
This file describes the variables, the data, and any transformations or work that I have performed to clean up the data.  

* The site where the data was obtained:  

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones      

The data file for the project:  

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

* The run_analysis.R script performs the following steps to clean the data: Library(plyr) should be loaded first

1. Read *X_train.txt and X_test.txt* from the "./train" and "./test" folders and store them in sets *train_X*, *test_X* respectively
2. Merge sets *train_X* and *test_X* in set *train_test* 10299x561 dimension

3. Read *X_train.txt and y_train.txt* from the "./train" and "./test" folders and store them in sets *train_labels*, *test_labels* respectively.  
4. Merge sets *train_labels* and *test_labes* in set *labels* 10299x1 dimension

5. Read *subject_train.txt and subject_test.txt* from the "./train" and "./test" folders and store them in sets *subject_train*, *subject_test* respectively.  
6. Merge sets *subject_train and subject_test* in set *subjects* 10299x1 dimension

7. Read the features.txt file from the working directory and store the data in a variable called *features*
8. Use names of features in above set *train_test*
9. Use name *Label* in above set *labels*
10.Use name *Subject* in above set *subjects*

11.Use a variable *features_no_meanFreq* to store names of features, string *meanFreq()* is replaced by *NA* in this variable
12.Select only features measuring the mean and standard deviation and store them in variable *mean_std*
13.We only extract the measurements on the mean and standard deviationand and store them in subset *extracted_set*

14.Read *activity_labels.txt* from the working directory and store it in set *map_activity_label*
15.Use names("Label","Activity") in above set *map_activity_labels*
16.Join sets labels and map_activity_label to name the activities in set *labels* and store it in set *labels_activities* 10299x2 dimension
17.Combine sets *subjects*, *labels_activities* and *extracted_set* and store it in clean dataset *data_set*

18.Store ID of subjects in variable *subjectID*
19 Store number of activities in variable *activities*
20.Calculate the average of each variable for each activity and each subject in clean dataset *data_set* and store the result in list *mean_by_activity_subject*
21.Convert the list *mean_by_activity_subject* to a dataframe 180x66 dimension

22.Create empty data set *tidydata* with 03 columns("Subject","Label","Activity") 180X3 dimension
23.Combine sets *tidydata* and *mean_by_activity_subject* and reassign *tidydata*
24.Name appropriately for data set tidydata
25.Write the tidy data set tidydata to the working directory in format text "Tidy_dataset.txt"
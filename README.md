Getting and Cleaning Data Course Project
========================================
This file describes how run_analysis.R script works.

* First, unzip the data file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

* Second, Set working directory to the folder "UCI HAR Dataset"

* Make sure the run_analysis.R script are in the working directory.

* Third, use source("run_analysis.R") command in RStudio. 

* Fourth, you will find an output file written to the current working directory:
  
  - Tidy_dataset.txt (220 Kb): it contains the result data: a dataframe 180*69 dimension.
  
  The dimension of dataframe is 180*69,because, 
  
  - There are 66 variables which measure the mean and standard deviation are required to get the average for each activity and each subject. 
    Beside, Subject, Label and Activity involving each average value are added to the dataset. Thus, total columns of the dataframe is 69
  
  - There are 6 activities carried by each subject and 30 subjects in total, we have 6X30 = 180 rows

* Finally, type command line test <- read.table("Tidy_dataset.txt") in RStudio to read the file. Use functions head("Tidy_dataset.txt") and names("Tidy_dataset.txt") to check the dataframe
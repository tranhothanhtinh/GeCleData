#MERGE ALL SETS OF TRAIN AND TEST TO CREATE ONLY ONE DATASET FOR ALL

#setwd("D:/Coursera/Data_Science/Getting and Cleaning Data/Project Course Dataset")

library(plyr)

# 1- Merge training and test sets

#Training data and test data

train_X<-read.table("./train/X_train.txt") # Training data
dim(train_X)
test_X<-read.table("./test/X_test.txt")    # Test data
dim(test_X)
train_test<-rbind(train_X,test_X)          # Merge training data and test data
dim(train_test)

#Labels data

train_labels<-read.table("./train/y_train.txt") # Labels of training data 
dim(train_labels)
test_labels<-read.table("./test/y_test.txt")    # Labels of test data
dim(test_labels)
labels<-rbind(train_labels,test_labels)         # Merge all labels of training data and test data
dim(labels)

# Subjects carried out the experiment

subject_train<-read.table("./train/subject_train.txt")  # The subject train who performed the activity
dim(subject_train)
subject_test<-read.table("./test/subject_test.txt")     # The subject test who performed the activity
dim(subject_test)
subjects<-rbind(subject_train,subject_test)             # Merge all subjects who performed the activity

# Use name of features in train_test set

features<-read.table("./features.txt")    # List of features vectors
names(train_test)<-features[,2]           # Use name of features in train_test set

# USe name "Label" in labels set

names(labels)<-"Label"

# USe name "Subject" in subjects set

names(subjects)<-"Subject"

#2- Extracting only the measurements on the mean and standard deviation for each measurement from dataset raw_set

# Use a variable *features_no_meanFreq* to store names of features, string *meanFreq()* is replaced by *NA* in this variable

features_no_meanFreq<-gsub("meanFreq()","NA",features$V2)

# Select only features measuring the mean and standard deviation

mean_std<-grep("mean|std",features_no_meanFreq,value=TRUE)

# Extracting only the measurements on the mean and standard deviation for each measurement from dataset train_test

extracted_set<-train_test[mean_std]

#3- Uses descriptive activity names to name the activities in the data set labels_activities

# Load data into activity_labels set

map_activity_label<-read.table("./activity_labels.txt") 

# Use names("Label","Activity") in map_activity_labels set

names(map_activity_label)<-c("Label","Activity")   

# Join sets labels and map_activity_label to name the activities in the data set labels and store it in set labels_activities

labels_activities<-join(labels,map_activity_label)

# Step4: Appropriately labels extracted_set with descriptive activity 

data_set<-cbind(subjects,labels_activities,extracted_set)


#Step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Store ID of subjects in variable subjectID in order

subjectID<-unique(subjects$Subject)

# Store number of activities in variable *activities*

activities<-nrow(map_activity_label) 

# Calculate the average of each variable for each activity and each subject in clean dataset *data_set*

mean_by_activity_subject<-by(data_set,list(data_set$Label,data_set$Subject),
                   FUN = function(y) {apply(y[4:ncol(data_set)], 2, mean)} )
    
# Convert the result to a dataframe

mean_by_activity_subject<-do.call(rbind,mean_by_activity_subject)
mean_by_activity_subject<-data.frame(mean_by_activity_subject)
dim(mean_by_activity_subject)

# Create a data set tidydata with 03 columns("Subject","Label","Activity")

tidydata<-data.frame(Subject=rep(1:length(subjectID), each = activities),
                 Label=rep(1:activities,length(subjectID)),
                 Activity =rep(map_activity_label$Activity,length(subjectID)))

dim(tidydata)    

tidydata<-cbind(tidydata,mean_by_activity_subject)

# Good names for data set tidydata

names(tidydata)<-names(data_set)

names(tidydata)[4:ncol(tidydata)]<-paste("Average of", 
                                         names(tidydata)[4:ncol(tidydata)])

# Write the tidy data set tidydata to the working directory in format text "Tidy_dataset.txt"

write.table(tidydata, "Tidy_dataset.txt", row.name=FALSE)
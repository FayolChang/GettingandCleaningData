
library(data.table)
library(dplyr)
        

setwd("./UCI HAR Dataset/")

#load features
features = read.table("./features.txt", header = F, row.names=1, sep="")

#load train dataset.
Xtrain = read.table( "./train/X_train.txt", header = F, sep = "" )
Ytrain = read.table( "./train/y_train.txt", header = F, sep = "" )
subject.train = read.table( "./train/subject_train.txt", header =F , sep = "" )


names(Xtrain) = features[,1]

#combine Xtrain,Ytrain,subject.train together.
data.train = Xtrain %>%
        mutate(activity = Ytrain[,1],subject = subject.train[,1])

data.train = as.tbl(data.train)
rm(Xtrain,Ytrain,subject.train)


Xtest = read.table( "./test/X_test.txt", header = T, sep = "" )
Ytest = read.table( "./test/y_test.txt", header = T, sep = "" )
subject.test = read.table("./test/subject_test.txt", header = T, sep = "")

names(Xtest) = features[,1]

data.test = Xtest %>%
        mutate(activity = Ytest[,1],subject = subject.test[,1])

data.test = as.tbl(data.test)

rm(Xtest,Ytest,subject.test)
rm(features)









## Task 1. create one dataset.
ActivityDataset = rbind_all(list(data.train,data.test))

ActivityDataset = as.tbl(ActivityDataset)

rm(data.train,data.test)






## Task2. select columns that contains mean() and std()
columns.mean = grep("mean\\(\\)",names(ActivityDataset),value = T)
columns.std = grep("std\\(\\)",names(ActivityDataset),value = T)

Select_mean_and_std_column = ActivityDataset[,
                c("subject","activity",columns.mean,columns.std)]

rm(list = ls(pattern="columns"))

rm(ActivityDataset)










## Task3. and Task 4 
## Uses descriptive activity names

activity = read.table("./activity_labels.txt",header = F)

Select_mean_and_std_column$activity = factor(Select_mean_and_std_column$activity,
                                             labels = activity[,2])








## Task5 Caculate the average value of each feature grouped by subject and activity.

tidydata = Select_mean_and_std_column %>%
        group_by(subject,activity) %>%
        summarise_each(funs(mean))

## Finally, write the tidydata to the disk.
write.table(x=tidydata,file="./tidydata.txt")


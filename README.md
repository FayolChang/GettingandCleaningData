GettingandCleaningData
======================

For the peer assignments of Getting and cleaning data

the data is downloaded at

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

When the data is downloaded, unzip the ZIP file and you would get a directory "UCI HAR Dataset".
Make sure the directory "UCI HAR Dataset" is in your R working Directory.

The directory "UCI HAR Dataset" includes the following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.


The Training set and the test set both have 561 columns(AKA features), but they do not have headers.

So first,I load the data set of X_train and name it using the data in the features.txt, which has 561 rows.

then, add two new column **activity** and **subject** using the data in y_train.txt and subject_train.txt, respectively. Name the new data set as **data.train**.

Similarly, We can follow the above steps on the test data set and Name it as **data.test**.

Finally, We append the test data set to the training dataset and get a new data set named **ActivityDataset**.

The next step is to extract features that we needed. We extract the columns of which their names containing "mean()" and "std()". the function "grep()" did the job perfectly.

We select features talked above and plus two feature **activity** and **subject** from  **ActivityDataset**, and name the data set as **Select_mean_and_std_column**. When it is done, We replace the **activity** value form number(1,2,3,4,5,6) to their descriptive names. the names comes from activity_labels.txt.

Finally, We calculate the average of each feature in the data set of **Select_mean_and_std_column**  grouped by **subject** and **activity**


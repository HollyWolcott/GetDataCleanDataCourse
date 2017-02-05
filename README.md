## Course Project

`run_analysis.R` is a script that:

1. Downloads zip file from <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip> and unzips file.
2. Loads activities and features into R.
3. Identifies columns containing data on mean and standard deviation.
4. Loads and merges the training and the test sets to create one data set. Only measurements on the mean and standard deviation are extracted.
5. Adds descriptive labels to variables in the data set.
5.Refine data from Step 4 and creates a second, independent tidy data set with the average of each variable for each activity and each subject.



# Getting And Cleanning Data Course Project
#
# Create one R script called run_analysis.R that does the following:
#
#    Steps:
#       1. Merges the training and the test sets to create one data set.
#       2. Extracts only the measurements on the mean and standard deviation for each measurement.
#       3. Uses descriptive activity names to name the activities in the data set
#       4. Appropriately labels the data set with descriptive activity names.
#       5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
#
#    Notes:
# 	   The code is well-documented and I also chose to display ("print") some comments as the script executes
#	   so I could see the resulting set of operations performed by this script.

writeLines("Script run_analysis.R has started.")

# Read all the data into variables
writeLines("   Loading features to features variable and retaining only mean and standard deviation...")
features <- read.table("./UCI HAR Dataset/features.txt", strip.white=TRUE, stringsAsFactors=FALSE)
writeLines("   Loading labeLs to labels variable ...")
labels <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
writeLines("   Loading test activity labels to testLables variable...")
testLabels <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names="label")
writeLines("   Loading test subject to testSubjects variable...")
testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names="subject")
writeLines("   Loading X_Test to testData variable...")
testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
writeLines("   Loading train activity labels to trainLabels variable...")
trainLabels <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names="label")
writeLines("   Loading train subject to trainSubjects variable...")
trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names="subject")
writeLines("   Loading X_Train to trainData variable...")
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt")


# Bind subjects, labels, data (test & train)
writeLines("   Binding all data...")
data <- rbind(cbind(testSubjects, testLabels, testData),cbind(trainSubjects, trainLabels, trainData))

# select only the mean and standard deviation from features and data
writeLines("   Filtering means and standard deviations...")
processedFeatures <- features[grep("mean\\(\\)|std\\(\\)", features$V2), ]
processedData <- data[, c(1, 2, processedFeatures$V1+2)]

# Re-assign labels to the processedData 
writeLines("   Re-assigning labels to the processedData...")
processedData$label <- labels[processedData$label, 2]

# Capture the column names into the processedColumnNames variable
processedColumnNames <- c("subject", "label", processedFeatures$V2)

# Re-assign column names to the processedData
writeLines("   Re-assigning column names to the processedData...")
colnames(processedData) <- processedColumnNames

# Aggregate the means for each (subject,label) pair 
writeLines("   Aggregating the data...")
tidyData <- aggregate(processedData[, 3:ncol(processedData)], by=list(subject = processedData$subject, label = processedData$label),mean)

# Output results to file
writeLines("   Formatting and Writing tidyData table to ./tidy_data.txt file...")
write.table(format(tidyData, scientific=T), "tidy_Data.txt", row.names=F, col.names=F, quote=2)

writeLines("Script run_analysis.R has completed.")

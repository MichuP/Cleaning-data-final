library(dplyr)

# my working directory  
# if you want to test, change to the rootWorkspace to where the 'getdata-projectfiles-UCI HAR Dataset' folder is on your machine
rootWorkspace <- "./Data Science Working Directory/Getting and Cleaning Data/final project/"
# fixed list containing activity names
activityLbls <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

# file reads
#train
trainingSet <- read.table(paste(rootWorkspace, "getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", sep = ""),
                          sep = "" , header = F, na.strings ="", stringsAsFactors= F)
trainingActivities <- read.table(paste(rootWorkspace, "getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", sep = ""),
                          header = F, na.strings ="", stringsAsFactors= F)
trainingSubjects <- read.table(paste(rootWorkspace, "getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", sep = ""),
                          header = F, na.strings ="", stringsAsFactors= F)

#test
testSet <- read.table(paste(rootWorkspace, "getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", sep = ""),
                          sep = "" , header = F, na.strings ="", stringsAsFactors= F)
testActivities <- read.table(paste(rootWorkspace, "getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", sep = ""),
                                 header = F, na.strings ="", stringsAsFactors= F)
testSubjects <- read.table(paste(rootWorkspace, "getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", sep = ""),
                               header = F, na.strings ="", stringsAsFactors= F)

#features file read - col names
colNames <- read.table(paste(rootWorkspace, "getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt", sep = ""),
                       header = F, na.strings ="", stringsAsFactors= F)[2]
validColNames <- make.names(names=as.vector(colNames[, 1]), unique=TRUE, allow_ = TRUE)
#remove multiple periods
validColNames <- gsub('\\.\\.+', '.', validColNames)
#remove trailing periods 
validColNames <- gsub('\\.$', '', validColNames)

# setting column names and adding subject, activity and activity label columns
colnames(testSet) <- validColNames
colnames(trainingSet) <- validColNames
testSet <- mutate(testSet, activity = testActivities[, 1], subject = testSubjects[, 1], activityLabel = activityLbls[activity])
trainingSet <- mutate(trainingSet, activity = trainingActivities[, 1], subject = trainingSubjects[, 1], activityLabel = activityLbls[activity])

# merge training and test data
merged <- rbind(trainingSet, testSet)

# final data frame 1 - mean, std, descriptive activity and subject selected
final1 <- select(merged, matches('[Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]|activityLabel|subject'))

# final data frame 2 - based on df1, the averages for subject and activity groups
final2 <- group_by(final1, subject, activityLabel) %>% summarise_each(funs(mean))






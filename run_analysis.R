#source("get_data.R")
setwd("./Accelerometers_Samsung_Galaxy_S")
###read data from data files
library(dplyr)
X_test <- read.table(file = "./dataset//UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table(file = "./dataset//UCI HAR Dataset/test/Y_test.txt")
subject_test <-read.table(file = "./dataset//UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table(file = "./dataset//UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table(file = "./dataset//UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table(file = "./dataset//UCI HAR Dataset/train/Y_train.txt")
feature <- read.table("./dataset//UCI HAR Dataset/features.txt") 
activity <- read.table("./dataset//UCI HAR Dataset/activity_labels.txt")

## step 1 : merge test set and train set and give the column names 
total_set <- rbind(cbind(subject_test,Y_test,X_test),cbind(subject_train,Y_train,X_train))
rm(list = c('X_test','Y_test','subject_test','X_train','Y_train','subject_train'))
names(total_set) <- c("SubjectID", "Activity",as.character(feature[,2]))

## step 2: mean_sd_set file includes only the measurements 
##      on the mean and standard deviation for each measurement. 

sdid <- grep("std",names(total_set))
meanid <- grep("mean",names(total_set))
mean_sd_set <- total_set[,c(1,2,meanid,sdid)]

## step3 
mergeData <- merge(activity, mean_sd_set,by.x="V1",by.y="Activity")
rm(mean_sd_set,meanid,sdid,activity,feature)

## step 4
names(mergeData)[2]<- "Activity" 
mergeData <- select(mergeData,SubjectID,Activity,4:ncol(mergeData),-V1)
## step 5 
mergeData %>% 
        group_by(SubjectID,Activity) %>%
        summarise_each(funs(mean),3:ncol(mergeData)) %>% 
        write.table(file="mean_table.txt",row.names=FALSE)
#mean_table<- read.table("mean_table.txt",header=FALSE)
#head(mean_table,n=10)

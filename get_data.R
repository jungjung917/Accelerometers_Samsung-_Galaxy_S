## download data files and unzip the data
#setwd("/Users/zhengshizhao/lecture_yale/courseea_DEC/part2_JAN/Get&CleanDAta/projects")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile <- "./dataset.zip"
method <- "curl"
download.file(url,destfile,method)
dateDwonloaded <- date()

if(!file.exists("./dataset")){dir.create("./dataset")}
unzip("dataset.zip",exdir = "./dataset")

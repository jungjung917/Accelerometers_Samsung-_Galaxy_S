## download data files and unzip the data

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile <- "./dataset.zip"
method <- "curl"
download.file(url,destfile,method)
dateDwonloaded <- date()

if(!file.exists("./dataset")){dir.create("./dataset")}
unzip("dataset.zip",exdir = "./dataset")

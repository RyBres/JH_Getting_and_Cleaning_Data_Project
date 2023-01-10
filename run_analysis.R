#Coursera: Johns Hopkins Data Science Specialization: Getting and Cleaning Data
#Course Project
#Acknowledgement: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

#Generating directories for data and output. This step (while technically unnecessary) acts as a push button for creating
#the directories (neatly) - which we'll need later on. This will create files in your current wd.

rm(list = ls())                                                                                         #clear environment
library(data.table)
library(dplyr)
if(!file.exists("./courseproject")){dir.create("./courseproject")}                                      #creates course project folder in current working directory
if(getwd() != "./courseproject"){setwd("./courseproject")}                                              #sets working directory to courseproject folder
if(!file.exists("./output")){dir.create("./output")}                                                    #creates output folder for tidy data
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"     #url
download.file(fileURL, destfile = "./data.zip", method = "curl"); rm(fileURL)                           #download zipped file
unzip("data.zip"); file.remove("data.zip")                                                              #unzip and remove zipped file
file.rename("UCI HAR Dataset", "data")                                                                  #rename for simplicity
setwd("./data")

#1. Merge training and test datasets
rm(list = ls())
activities <- read.table("activity_labels.txt", col.names = c("id", "activity"))

subjtrain <- read.table("./train/subject_train.txt", header = FALSE, col.names = "subject")             #read in subject files
subjtest <- read.table("./test/subject_test.txt", header = FALSE, col.names = "subject")

ytrain <- read.table("./train/y_train.txt", header = FALSE, col.names = "id")                           #read in y files
ytest <- read.table("./test/y_test.txt", header = FALSE, col.names = "id")

feature <- read.table("features.txt", col.names = c("n", "fun"))                                        #read in features

xtrain <- read.table("./train/X_train.txt", header = FALSE, col.names = feature$fun)                    #read in x files
xtest <- read.table("./test/X_test.txt", header = FALSE, col.names = feature$fun)

xdf <- rbind(xtrain, xtest)                                                                             #merge df's
ydf <- rbind(ytrain, ytest)
subjdf <- rbind(subjtrain, subjtest)
merged <- cbind(subjdf, ydf, xdf)

#2. Extract columns containing mean and standard deviation - regexp unnecessary
tidydata <- merged %>% select(subject, id, contains("mean"), contains("std"))
tidydata$id <- activities[tidydata$id, 2]; colnames(tidydata)[colnames(tidydata) == "id"] ="activity"

#3. Appropriate label data with descriptive variable names - see names below for key
# mean(): Mean value
# std(): Standard deviation
# mad(): Median absolute deviation 
# max(): Largest value in array
# min(): Smallest value in array
# sma(): Signal magnitude area
# energy(): Energy measure. Sum of the squares divided by the number of values. 
# iqr(): Interquartile range 
# entropy(): Signal entropy
# arCoeff(): Autorregresion coefficients with Burg order equal to 4
# correlation(): correlation coefficient between two signals
# maxInds(): index of the frequency component with largest magnitude
# meanFreq(): Weighted average of the frequency components to obtain a mean frequency
# skewness(): skewness of the frequency domain signal 
# kurtosis(): kurtosis of the frequency domain signal 
# bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
# angle(): Angle between to vectors.

names(tidydata) <- gsub("^t", "time", names(tidydata))
names(tidydata) <- gsub("^f", "freqdomsignal", names(tidydata))                         #freqdomsignal = frequency domain signal  
names(tidydata) <- gsub("[Aa]cc", "Acceleration", names(tidydata))
names(tidydata) <- gsub("[Gg]yro", "Gyroscope", names(tidydata))
names(tidydata) <- gsub("[Mm]ag", "Magnitude", names(tidydata))
names(tidydata) <- gsub("Inds", "Indexes", names(tidydata))
names(tidydata) <- gsub("BodyBody", "Body", names(tidydata))                            #don't see the point in Body x 2
names(tidydata) <- gsub("[^0-9A-Za-z///' ]","" , names(tidydata),ignore.case = TRUE)    #removing all special characters from tidydata names

rm(list = ls()[!(ls() %in% 'tidydata')])                                                #remove everything from environment except data

#4. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidydatafinal <- tidydata %>% group_by(subject, activity) %>% summarise_all(funs(mean))

#5. Writing table to output file
setwd("../output")
write.table(tidydatafinal, file = "tidydata.txt", row.name = FALSE)
# JH_Getting_and_Cleaning_Data_Project

This is the README.md file for the final course project for Johns Hopkins "Getting and Cleaning Data" Coursera course. The code found in "run_analysis.R" completes the assignment in 6 total steps (4 of which were specified in the assignment instructions).

1. Generate a new directory "courseproject" in the current working directory, along with "data" and "output" subdirectories. Alongside this, the data is downloaded from the internet and placed into the "data" directory - so there is no need to have the data in your current working directory.
2. The "test" and "train" datasets are merged together. This is preceded by a number of merges within the train and test datasets. This results in a merged dataframe named "tidydata".
3. The "tidydata" dataframe is trimmed so that only columns related to the mean and standard deviation of the variables are included - the rest is dropped.
4. The "tidydata" dataframe is then appropriately labeled (not only the column names, but also the factor levels of activity).
5. A second tidy dataset "tidydatafinal" is created with the average of each variable for each activity and each subject.
6. "tidydatafinal" is then written to a .txt file as "tidydata.txt" in the output directory.

Note that the final dataset "tidydata.txt" is contained in the courseproject/output/ folder in this repository.

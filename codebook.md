# Codebook

## Variable overview
The output dataset "tidydata.txt" (see this repo's courseproject/output folder) contains a total of 88 variables and 180 observations. Each row indicates a respective subject, activity, and mean value for a given measurement.

## Transformations
The following (which can also be partially found in README.txt) are the steps that were carried out in the process of generating "tidydata.txt":

1. Generate a new directory "courseproject" in the current working directory, along with "data" and "output" subdirectories. Alongside this, the data is downloaded from the internet and placed into the "data" directory - so there is no need to have the data in your current working directory.
2. The "test" and "train" datasets are merged together. This is preceded by a number of merges within the train and test datasets. This results in a merged dataframe named "tidydata".
3. The "tidydata" dataframe is trimmed so that only columns related to the mean and standard deviation of the variables are included - the rest is dropped.
4. The "tidydata" dataframe is then appropriately labeled (not only the column names, but also the factor levels of activity).
    a. t and f prefix changed to time and freqdomsignal (frequency domain signal)
    b. [Aa]cc changed to Acceleration
    c. [Gg]yro changed to Gyroscope
    d. [Mmag] changed to Magnitude
    e. Inds changed to Indexes
    f. BodyBody changed to Body
    g. All special characters are removed and replaced with no space (variable names are only alphabetical characters with no separators)
5. A second tidy dataset "tidydatafinal" is created with the average of each variable for each activity and each subject.
"tidydatafinal" is then written to a .txt file as "tidydata.txt" in the output directory.



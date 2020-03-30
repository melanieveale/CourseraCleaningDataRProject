# This script reads the original data from both test and train sets,
#  cleaning them appropriately as it reads them,
#  then saves them to a file "clean_data.txt".
# Then, it aggregates the data to get the mean of each column per subject and activity,
# and saves to a file "clean_data_aggregated.txt".

source("my_tidying_code/tidy_x.R")
source("my_tidying_code/add_subject_and_activity.R")

original_data_dir <- "original_data/UCI HAR Dataset"

read_tidily <- function(test_or_train) {
  # Define all of the directory names and file names
  current_data_dir <- paste(original_data_dir, test_or_train, sep='/')
  x_filename <- paste("X_", test_or_train, ".txt", sep='')
  subject_filename <- paste("subject_", test_or_train, ".txt", sep='')
  y_filename <- paste("y_", test_or_train, ".txt", sep='')
  # Read the main part of the data, then add the subject and activity information
  tidy_data <- tidy_x(paste(current_data_dir, x_filename, sep='/'))
  tidy_data <- add_subject_and_activity(
    tidy_data,
    paste(current_data_dir, subject_filename, sep='/'),
    paste(current_data_dir, y_filename, sep='/')
    )
}

print("Getting clean test data")
tidy_test <- read_tidily("test")

print("Getting clean train data")
tidy_train <- read_tidily("train")

print("Combining and saving")
tidy_total <- rbind(tidy_test, tidy_train)
write.table(tidy_total, "clean_data.txt", row.names=FALSE)

print("Aggregating mean per subject and sctivity")
tidy_agg <- summarize_all(group_by(tidy_total, subject, activity),
                          mean)
write.table(tidy_agg, "clean_data_averages.txt", row.names=FALSE)
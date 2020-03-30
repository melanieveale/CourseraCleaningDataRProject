# This function read the "subject" and "y" (aka activity) data from the original data, and adds them as columns to the x data.
# The descriptive names for activities are read from the activity_labels.txt file in the original data.
# (The "original_data_dir" variable is expected to be present in the main script that sources this one. Messy I know.)

activity_translation <- read.table(paste(original_data_dir, "activity_labels.txt", sep='/'),
                                   header=FALSE,
                                   col.names = c("index", "name"))
# The "index" column just repeats the row numbers - all I really need is the "name" column
activity_translation <- activity_translation$name

add_subject_and_activity <- function(data, subject_file_path, activity_file_path) {
  # Read subject data
  subjects <- read.csv(subject_file_path, header=FALSE)
  # Add it as a column to the "x" data that got passed in
  data$subject <- subjects$V1
  # Read y/activity data
  activities <- read.csv(activity_file_path, header=FALSE)
  # Translate to names
  named_activities <- sapply(activities$V1, function(x) {activity_translation[x]})
  # Add it as a column
  data$activity <- named_activities
  # Put the new columns at the beginning
  data <- select(data, subject, activity, everything())
}
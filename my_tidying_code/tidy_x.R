# This function will read all of the "x" data from the original data file, and clean it appropriately
# The columns I wish to keep are specified in the feature_translation.txt file (see README for details).

library(dplyr)
library(readr)

# Read column translation info from file
column_info <- read.table("my_tidying_code/feature_translation.txt",
                          header=FALSE,
                          col.names=c("old_index","old_name","new_name"))
# Preserve the current index/order; this is the order I want them in
column_info$new_index = c(1:nrow(column_info))
# Sort by "old index", aka the column number in the original data
column_info <- arrange(column_info, old_index)

tidy_x <- function(path_to_x_data) {
  # Skip all columns but those included in my column translation info
  column_types=rep("NULL", 561)
  # Columns to include are referenced by column number (in the original data)
  column_types[column_info$old_index]="numeric"
  data <- read.table(path_to_x_data,
                     colClasses=c(column_types),
                     header=FALSE)
  # Add column names (it is important that they are sorted by the column order in the original data for this step!)  
  names(data) <- column_info$new_name
  # Now reorder the columns to match the order I want them
  data <- data[,order(column_info$new_index)]
}
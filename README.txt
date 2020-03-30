Here be the readme!

Contents of this repo:
======================

- clean_data.txt
  A file containing "tidy data" as described below in the "code book" section

- clean_data_averages.txt
  A file containing "tidy aggregated data" as described below in the "code book" section
  
- my_tidying_code
  Supporting code referenced by the main analysis script run_analysis.R

- original_data
  The original dataset, downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  (original source http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

- this readme

- run_analysis.R
  The main analysis script that creates the two tidy data files from the original data.



Code Book:
==========

See original_data/UCI HAR Dataset/README.txt for a full description of the experiments.

This data is from the accelerometer/gyroscope of cell phones worn by 30 volunteers ("subject" 1 thru 30 in the clean data files) during various physical activities ("activity" in the clean data files).

Each row of clean_data.txt represents a window of 2.56 seconds, during which 128 readings (at 50Hz) were taken from the accelerometer and gyroscope of a cell phone worn at the waist of the subject.

Each row of clean_data_averages.txt represents the average over all windows for each subject corresponding to each activity.

The columns of the dataset represent the mean and standard deviation (over the 128 readings that make up each window) of two major types of measurement:
- acceleration
- angular velocity ("gyro")

For each of those, the 3 axial measurements (X, Y, Z) and the Magnitude are reported, for 4 (x,y,z,mag) x 2 (mean, std) x 2 (acceleration, gyro) = 16 columns.

For each of those, the same analysis is done for the corresponding "jerk" (time derivative of the measurement over the window), for 32 columns.

For each of those, the same analysis is done in the frequency domain using a fast fourier transform (denoted by "fourier" in the column names), for 64 columns, except that only the magnitude of the fourier transform of the angular velocity jerk ("gyrojerk") is kept. This means 3 (x, y, z) x 2 (mean, std) = 6 columns are dropped, for 58 columns.

Finally, a separate measurement of gravitational acceleration (subtracted out of the raw data to give the acceleration described above) is recorded. It is assumed to be very slowly varying in time, so no jerk or fourier transforms are included. This adds 4 (X, Y, Z, magnitude) x 2 (mean, std) = 8 columns for a grand total of 66 measurement variables.

More details on these measurements can be found in original_data/UCI HAR Dataset/feature_info.txt. The original data contains many more columns beyond mean and standard deviation. The exact translation from original data columns to "tidy" data columns can be found in my_tidying_code/feature_translation.txt. That file was generated manually according to the following steps:
- start from a copy of original_data/features.txt
- remove unwanted columns
- reorder columns to group (x, y, z, magnitude) for the same measurement together first, followed by (mean, std), followed by (standard/time domain, fourier/frequency domain), followed by (standard/acceleration, time derivative/jerk), followed by (linear acceleration, angular velocity/"gyro"), with the gravity measurements as the last 8 columns
- create a new column for standardized/friendly names to appear in the new data set.
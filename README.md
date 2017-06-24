fileGetting and Cleaning Data Course Project

Purpose
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit:
1. a tidy data set as described below;
2. a link to a Github repository with your script for performing the analysis; and
3. a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called         CodeBook.md.
4. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are         connected.

Objectives
run_analysis.R is divided in steps and performs the following:
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive activity names.
- Creates a new file with the tidy data, called "new_data"

run_analysis.R
The script is downloading datasets from : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Then it unzips the files

It then merges the different datasets ,in steps, to one data table.
By using grep command, only the mean and standard deviation values are extracted.
Then finally some cleaning of columns, based on the UCD files (activity_labels and features), and also cleaning the different columns for (), t and f (se "names" commands. 

writing the new tidy'ed file to new_file

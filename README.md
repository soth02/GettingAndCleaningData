Getting and Cleaning Data Course Project
========================================

This readme is for the Getting and Cleaning Data course project.  It describes the setup of the environment and prework for running data cleanup, and also describes the interactions of the cleaning scripts.

Environmental assumptions:

1. Downloaded zipped dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
2. Unzipped folder to local location

Generating datasets:

3. After the Environmental assumptions are complete, run_analysis.R is run with a cwd of 

	setwd("C:\\Users\\Chris\\Desktop\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset")

which generates mergedDataSet.txt and tidyDataSet.txt
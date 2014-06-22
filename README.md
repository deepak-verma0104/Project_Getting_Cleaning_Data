1) Prerequisites to run run_analysis.R

	a. - Place following files in one common work directory.
		- X_train.txt	
		- X_test.txt
		- features.txt
		- y_train.txt
		- y_test.txt
 	`	- activity_labels.txt
		- subject_train.txt
		- subject_test.txt
		- run_analysis.R
 
	b. - Install and load sqldf package in R-Environment

		- Install the package by running the command	> install.packages("sqldf")

	      - Load the package by running the command 	> library("sqldf")

		- This would be required to calculate the mean of all columns of first tidy data set and preparing 
		the second tidy data set using sql query.
				 
2) Running the R Script - run_analysis.R

	a. Go to the work directory where you have placed all the files as in 1.a

		- setwd("<working directory>")

	b. Run the followling command on R Console

		- source("run_analysis.R")	

	c. Running the script as in 2.b will create the following files in the current working directory. 

		- tidy_data_1.txt - This file contains all the columns/features/measurements with mean() 
		and  std() measurements with first two columns being subject and activity labels. Please note that
		only those columns names which are having mean() and std() as substring are considered for the purpose 
		of preparing tidy_data_1.txt. 			

		- Labels_Features_tidy_data_1.txt - This file contains column names/variable details with Labels 
		( subject & activity ) of tidy_data_1.txt.

		- tidy_data_2.txt - This file is contains all the mean values of the columns/features/measurements
		in tidy_data_1.txt grouped by subject and activity. The column names have been prefixed by "avg" string.

		
		- Labels_Features_tidy_data_2.txt - This file contains column names/variable details with Labels 
		( subject & activity ) of tidy_data_2.txt.The columns names are prefixed by "avg" string. 

3) Files uploaded in Github 
		
		- README.md
		- run_analysis.R
		- tidy_data_1.txt
		- Labels_Features_tidy_data_1.txt
		- tidy_data_2.txt
		- Labels_Features_tidy_data_2.txt
		- Codebook.md - which is a listing of the column names of the tidy_data_2.txt i.e. it is same as Labels_Features_tidy_data_2.txt. 
		The raw version of the codebook.md gives the column names in different rows. 
					

4) File Uploaded in Coursera Site
		- tidy_data_2.txt

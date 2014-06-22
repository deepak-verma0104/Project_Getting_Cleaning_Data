#################################################################################################################################################################################################################
##Read the training and test set values and row bind them to form one data set - df_train_plus_test

df_train <- read.table("X_train.txt")                                           
df_test <- read.table("X_test.txt")                                             
df_train_plus_test <- rbind(df_train, df_test)                                  
##dim(df_train);dim(df_test);dim(df_train_plus_test)           #for dim check                 

##################################################################################################################################################################################################################
##Get only mean() and std() measurement/features from features.txt from df_train_plus_test
##For this first need to get the indices for mean() and std() measurement columns and then extract those columns from df_train_plus_test data set
##Change the columns names to little better descriptive names - "mean()" changed to "Mean", "std()" changed to "StandardDeviation"
## "-" (hyphen) in the column name was replaced with "_" (underscore) for the sql query to work later for preparing 2nd data set with mean values

df_features <- read.table("features.txt")
mean_std_indexes <- grep("mean\\(\\)|std\\(\\)", df_features[,2])
df_train_plus_test_mean_std_vars <- df_train_plus_test[, mean_std_indexes]              #df_train_plus_test_mean_std_vars with only mean and standard deviation measurement columns
df_features_modified <- gsub("\\(\\)", "", df_features[mean_std_indexes,2]) 
df_features_modified <- gsub("mean", "Mean", df_features_modified) 
df_features_modified <- gsub("std", "StandardDeviation", df_features_modified)
df_features_modified <- gsub("-", "_", df_features_modified)
names(df_train_plus_test_mean_std_vars) <- df_features_modified                          #df_train_plus_test_mean_std_vars with modified column/feature names 

#################################################################################################################################################################################################################
##Create activity data set (train + test) with descriptive activity names/labels for y values and rename the column as "activity"

df_train_label <- read.table("y_train.txt")
df_test_label <- read.table("y_test.txt")
df_train_plus_test_label <- rbind(df_train_label, df_test_label)
activity_labels <- read.table("activity_labels.txt")
activity <- activity_labels[df_train_plus_test_label[,1], 2]
df_train_plus_test_label[,1] <- activity
names(df_train_plus_test_label) <- "activity"

#################################################################################################################################################################################################################
##Create subject data set (train + test) and rename the column as "subject" 

df_subject_train <- read.table("subject_train.txt")
df_subject_test <- read.table("subject_test.txt")
df_train_plus_test_subject <- rbind(df_subject_train, df_subject_test )
names(df_train_plus_test_subject) <- "subject"

#################################################################################################################################################################################################################
##Preaper first tidy data set by column binding subject data set , activity data set and df_train_plus_test_mean_std_vars data set
##Write the first tidy data set to tidy_data_1.txt file in the current working directory
##Write the columns names/features to another file - Labels_Features_tidy_data_1.txt - which acts as code book for this data - contains the summary of the columns/features 

df_tidy_1 <- cbind(df_train_plus_test_subject,df_train_plus_test_label, df_train_plus_test_mean_std_vars )
##dim(df_tidy_1)        #for check                        
write.table(df_tidy_1, "tidy_data_1.txt", row.names=FALSE)
write.table(names(df_tidy_1), "Labels_Features_tidy_data_1.txt", quote=FALSE, col.names=FALSE)

#################################################################################################################################################################################################################
#Finding out mean of every features group by subject and activity of first data set df_tidy_1
#We will use sqldf package to run this part of the code
#Need to install and load the sqldf package 
        #Install        > install.packages("sqldf")
        #Load pacakge   > library("sqldf")
#Create and run the sql query to calculate average of all features/columns group by subject and activity
##Write the query result to second tidy data set to tidy_data_2.txt file in the current working directory
##Write the columns names/features to another file - Labels_Features_tidy_data_2.txt - which acts as code book for this data - contains the summary of the columns/features


t1 <- gsub("^", "avg\\(", df_features_modified)                         #forming the sql query string with avg(col_name) for every columns
t2 <- gsub("$", "\\)", t1)                                              #forming the sql query string with avg(col_name) for every columns

sql_query_for_mean <- "select subject, activity  "                      #forming the sql query string with avg(col_name) for every columns
for (i in 1:length(t2)) { 
        sql_query_for_mean <- paste(sql_query_for_mean, "," , t2[i])    #forming the sql query string with avg(col_name) for every columns
        i = i + 1 
}

sql_query_for_mean <- paste ( sql_query_for_mean , " from df_tidy_1 group by subject, activity")        #sql query string with avg(col_name) for every columns group by subject and activity column
df_tidy_2 <- sqldf(sql_query_for_mean)                                                                  #store query result in df_tidy_2 data frame

write.table(df_tidy_2, "tidy_data_2.txt", row.names=FALSE)                                                               #write df_tidy_2 data frame to tidy_data_2.txt file
write.table(names(df_tidy_2), "Labels_Features_tidy_data_2.txt", quote=FALSE, col.names=FALSE)          #write names of labels and names of avergae of feature columns in Labels_Features_tidy_data_2.txt file                             

#################################################################################################################################################################################################################
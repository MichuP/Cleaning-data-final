## Transformations done by run_analysis.R file

**All the variables come from the following project: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones**

If you want information on specific variables and project general info - refer features_info.txt and README.txt files

Here is a step by step guide to the transformations that were performed to get the two final data frames:

1. A character vector is defined with descriptive activity labels. The order of items in the vector is aligned with the activity number (1 - "WALKING", 2 - "WALKING_UPSTAIRS" etc.)
2. All training files (the set, activities and subjects) are read with no headings. 
3. All test files (the set, activities and subjects) are read with no headings.
4. The features.txt file is read and saved to colNames data frame
5. The columns are then extracted from data frame and changed using make.names to ensure uniqueness in names and to remove invalid characters.
6. Multiple periods and trailing periods are removed from column names with simple regular expressions.
7. The valid column names are assigned to training and test sets
8. Subject, activity and activity label columns are added to both training and test sets using mutate function.
9. Training and test sets are merged together using rbind.
10. final1 data frame is created as a subset of merged data frame. Variables containing std, mean, activityLabel and subject words are extracted.
11. final2 data frame is created using group by on final1. The data is grouped by subject and descriptive activity. Then it is summarized using mean function for each (not grouped) variable.



**Note that if you wish to test the functionality of the code, you simply need to unpack the files with data, put the run_analysis.R file to the location of the unpacked folder (getdata-projectfiles-UCI HAR Dataset) and change the rootWorkspace variable in the script to point to the directory where the unpacked folder is placed.**
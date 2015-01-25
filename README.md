# getting_and_cleaning_data(HOW DOES THE CODE WORK)

#code block1:read the test and training data

	Variable			Description
	test			reads the x_test data
	subject_test		reads the subject_id(1-30) 
	y_test			reads the activity_id(1-5)

	train			reads the x_train data
	subject_train		reads the subject_id(1-30) 
	y_train			reads the activity_id(1-5)


#code block2:to merge the training and test datasets

	Variable			Description
	merged_data		merged the train & test data by row
	merged_subject		merged the subject_test & subject_train by row
	merged_activity		merged the y_train & y_test by row

#code block3:to identify the mean and standard deviation variables among other features

	Variable			Description
	features		reads the different features like mean,std,max,min etc of all the variables
	split			splits the features names by the separator "-"(i.e,tBodyAcc-mean()-X is separated
				into tBodyAcc,mean(),X
	logic			a logical variable which finds the observations having mean() or std() in split

#code block4:to assign proper activity names to the corresponding indicators

	Variable			Description
	activity_names		reads the different activity names(i.e walking,sitting,etc) and corresponding codes 
				for from activity_labels
	join			joined the merged_activity and activity_names to assign names to the respective 
				activities done by different subjects

#code block5:Organising the data into a tidy dataset	

	Variable			Description
	merged_data		the names of the coloumns are assigned from features[,2],and then it is subsetted
				based on logic variable so as to only include the mean and std values across all 
				other features present.
				Finally the merged_subject,join,merged_data are joined together and ordered.

#code block6:creating the subjectwise and activitywise mean values for all the variables

	Variable			Description
	data_melt		merged_data is melted with subject_id and activity as the id variable and all
				others as the measured variable.
	data			casted the melted data to find the subjectwise and activity mean across all variables
				Thereafter,proper names are assigned to each coloumn of data and finally is stored
				in file "run_analysis.txt"

	
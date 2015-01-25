
#read the test and training data


test<-read.table("test/x_test.txt")
subject_test<-read.table("test/subject_test.txt")
y_test<-read.table("test/y_test.txt")
train<-read.table("train/x_train.txt")
subject_train<-read.table("train/subject_train.txt")
y_train<-read.table("train/y_train.txt")

#to merge the training and test datasets

merged_data<-rbind(train,test)
merged_subject<-rbind(subject_train,subject_test)
merged_activity<-rbind(y_train,y_test)

# to identify the mean and standard deviation variables among others
features<-read.table("features.txt",stringsAsFactors = FALSE)
split<-strsplit(features[,2],"-")
logic<-c()
for(i in 1:length(split)){
  logic<-c(logic,split[[i]][2] %in%  c("mean()","std()")) 
}

#to assign proper activity names to the corresponding indicators
activity_names<-read.table("activity_labels.txt")
library(plyr)
join<-join(merged_activity,activity_names,by="V1")
join$V1<-NULL
colnames(join)<-"ACTIVITY"

# Organising the data into a tidy dataset
colnames(merged_data)<-features[,2]
merged_data<-merged_data[,logic]
colnames(merged_subject)<-"subject.id"
merged_data<-cbind(merged_subject,join,merged_data)
merged_data<-merged_data[order(merged_data[,1],merged_data[,2]),]

#creating the subjectwise and activitywise mean values for all the variables
names<-names(merged_data)
library(reshape2)
data_melt<-melt(merged_data,id.vars=names[1:2],measure.vars=names[3:length(names)])
data<-dcast(data_melt,subject.id + ACTIVITY~variable,mean)
a<-paste("Avg",colnames(data),sep = "-")
a[1]<-"subject_id"
a[2]<-"activity"
colnames(data)<-a
write.table(data,"run_analysis.txt",row.names = FALSE)



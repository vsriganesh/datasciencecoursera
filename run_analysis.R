testData<-read.table(".\\UCI HAR Dataset\\test\\X_test.txt")

testLabel<-read.table(".\\UCI HAR Dataset\\test\\y_test.txt")
testSubject<-read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")



trainingData<-read.table(".\\UCI HAR Dataset\\train\\X_train.txt")

trainingLabel<-read.table(".\\UCI HAR Dataset\\train\\y_train.txt")
trainingSubject<-read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")



actualLabel<- read.table(".\\UCI HAR Dataset\\activity_labels.txt")

Activity_label<-vector()
# Add the subject and activity label no , activity label  to each row 
testL<-testLabel[,1]
check<-1

activity_id<-vector()
for(i in testL){
  activity_id[check]<-i
  
  Activity_label[check]<-as.character(actualLabel[i,2])
   
  check<-check+1
  
}


subject_id<-vector()

check<-1
testS<-testSubject[,1]

for(j in testS)
{
  subject_id[check]<-j
  check=check+1
  
}



testData<-cbind(testData,"Activity_id"= activity_id ,"Subject_id"= subject_id,"Activity_Label"=Activity_label)

Activity_label<-vector()
trainingL<-trainingLabel[,1]
check<-1

activity_id<-vector()
for(i in trainingL){
  activity_id[check]<-i
  Activity_label[check]<-as.character(actualLabel[i,2])
  check<-check+1
  
}


subject_id<-vector()

check<-1
trainingS<-trainingSubject[,1]

for(j in trainingS)
{
  subject_id[check]<-j
  check=check+1
  
}

trainingData<-cbind(trainingData,"Activity_id"= activity_id ,"Subject_id"= subject_id,"Activity_Label"=Activity_label)






mergedData<-merge(testData,trainingData,all=TRUE)





features<- read.table(".\\UCI HAR Dataset\\features.txt")
features_v<-as.character(features[,2])
head(features_v)

extractedData <- mergedData[,c(1:6,41:46,81:86,121:126,161:167,201:202,227:228,240:241,
                              253:254,266:271,345:350,424:429,503:504,516:517,529:530,
                              542:543,562:564)]


names(extractedData)<-c(features_v[1:6],features_v[41:46],features_v[81:86],features_v[121:126]
                        ,features_v[161:167],features_v[201:202],features_v[227:228]
                        ,features_v[240:241],
                        features_v[253:254],features_v[266:271],features_v[345:350],
                        features_v[424:429],features_v[503:504],
                        features_v[516:517],features_v[529:530],features_v[542:543],"Activity_id",
                        "Subject_id","Activity_label")


names<- names(extractedData)
check<-1
namesList<-vector()
for ( i in names)
{
  if(check==66)
    break
  namesList[check]<-i
  check=check+1
  
}

# Calculate Mean



library(reshape2)
testMelt<- melt(extractedData,id=c("Subject_id","Activity_label"),measure.vars=namesList)


Subject_Id_df <- dcast(testMelt,Subject_id ~ variable  ,mean) 
Activity_Label_df <- dcast(testMelt,Activity_label ~ variable ,mean)



#Setting row names
c<-vector()
check<-1
for(i in seq_along(1:30))
{
  c[check]=paste("subject",as.character(check),sep="")
  check=check+1
}



row.names(Subject_Id_df)<- c

final_df<- merge(Subject_Id_df,Activity_Label_df,all=TRUE)

write.table(final_df,"run_analysis_output1.txt",row.name=FALSE)


# Subject_Id_df <- head(dcast(testMelt,Subject_id+Activity_label ~ variable  ,mean),n=10) 





## This is a markdown file - Analysis



 ==> Basically the scripts reads the following files and maintains a dataframe


1) X_test.txt

2) y_test.txt

3) subject_test.txt

4) X_train.txt

5) y_train.txt

6) subject_train.txt

7) activity_labels.txt

8) features.txt



 ==> Based on the Activity_id , Subject_id and Activity_label columns are appended (cbind) to both test and training datasets

 ==> The necessary mean and SD deviation columns are then extracted

 ==> melt and dcast function are used to present the final dataframe in wide form.


 




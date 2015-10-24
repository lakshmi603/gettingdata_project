#1.Download data from the server
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",dest="C:/Users/Lakshni/Documents/coursera_gettingandcleaningdata/projectdata.zip")
#2.Unzip data
unzip("C:/Users/Lakshni/Documents/coursera_gettingandcleaningdata/projectdata.zip",exdir="C:/Users/Lakshni/Documents/coursera_gettingandcleaningdata/projectdata")
#3. Read the training and testing datasets
#Training dataset
X<-read.table("C:/Users/Lakshni/Documents/coursera_gettingandcleaningdata/projectdata/UCI HAR Dataset/train/X_train.txt")
X[,562]<-read.table("C:/Users/Lakshni/Documents/coursera_gettingandcleaningdata/projectdata/UCI HAR Dataset/train/y_train.txt")#activity
X[,563]<-read.table("C:/Users/Lakshni/Documents/coursera_gettingandcleaningdata/projectdata/UCI HAR Dataset/train/subject_train.txt")#subject
#Testing dataset
Y<-read.table("C:/Users/Lakshni/Documents/coursera_gettingandcleaningdata/projectdata/UCI HAR Dataset/test/X_test.txt")
Y[,562]<-read.table("C:/Users/Lakshni/Documents/coursera_gettingandcleaningdata/projectdata/UCI HAR Dataset/test/y_test.txt")#activity
Y[,563]<-read.table("C:/Users/Lakshni/Documents/coursera_gettingandcleaningdata/projectdata/UCI HAR Dataset/test/subject_test.txt")
#4. Merge the training and testing datasets
merge<-rbind(X,Y)
#5. Read the dataset headers from features.txt
headers<-read.table("C:/Users/Lakshni/Documents/coursera_gettingandcleaningdata/projectdata/UCI HAR Dataset/features.txt")
#6.Name the merged dataset columns using the headers from headers table. Name the "Activity" and "Subject" in columns 562 and 563.
names(merge)<-headers[,2]#name the columns 1 through 561
names(merge)[562:563]<-c("Activity","Subject") #name columns 562 and 563
#7. Take only the column names with mean and standard deviation information in them
 pattern<-"mean|std|Activity|Subject" #variable set to choose either mean or standard deviation as a search string, in addition to retaining the last two columns
 merge1<-merge[,grepl(pattern,names(merge))] #output the dataset with mean or standard deviation information in it
 merge2<-merge1[,-grep("meanFreq",names(merge1))]#remove the "meanfreq()"values from the dataset
#8. Read the activity labels 
activity<-read.table("C:/Users/Lakshni/Documents/coursera_gettingandcleaningdata/projectdata/UCI HAR Dataset/activity_labels.txt")
#9. Convert the activity column as a factor column and read the activity labels from the activity table corresponding to each level
 merge2$Activity<-factor(merge2$Activity,levels=activity[,1],labels=activity[,2])
#10.Convert the subject column to a factor column for mean calculations
 as.factor(merge2$Subject)
#11.Calculate the mean for all columns by each activity and each subject
td<-ddply(merge2,c("Activity","Subject"),numcolwise(mean))
#12.Write td into a text file
write.table(td,"C:/Users/Lakshni/Documents/coursera_gettingandcleaningdata/tidy.txt",row.names=FALSE)

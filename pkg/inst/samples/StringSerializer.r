#initialize rhbase with "raw" serialization
library(rhbase)
hb.init(serialize="raw")

#make sure the table does not exist
if (names(hb.list.tables())=="mytable") {
   hb.delete.table("mytable")
}


#create new table with columns x,y and z
hb.new.table("mytable", "x","y","z",opts=list(y=list(compression='GZ')))
 
#insert some values into the table
hb.insert("mytable",list( list(1,c("x","y","z"),list("apple","berry","cherry"))))
hb.insert("mytable",list( list(2,c("x","y","z"),list(10001,14,575))))
hb.insert("mytable",list( list(3,c("x","y","z"),list("a string",1000.23,FALSE))))

#read all rows of the of the table
rows<-hb.scan("mytable",start=1,colspec=c("x","y","z"))
rows$get()

#read just the first row of the table
rows<-hb.scan("mytable",start=1,end=2,colspec=c("x","y","z"))
rows$get()

#read start at the second row of the table and then read the rest
rows<-hb.scan("mytable",start=2,colspec=c("x","y","z"))
rows$get()

dat<-data.frame(a=character(0), b=character(0), c=character(0), d=character(0), e=character(0), f=character(0),stringsAsFactors=FALSE)
for(i in 1:3){
a<-"sdfsaf"
 b<-"dfadasfsd"
c<-"fdsfsadf"
 d<-"dfads"
 e<-"sfdsfdsf"
 f<-"dfsfsdf"
 dat<-rbind(dat,setNames(as.list(c(a,b,c,d,e,f)),names(dat)),stringsAsFactors = FALSE)    
 }
dat


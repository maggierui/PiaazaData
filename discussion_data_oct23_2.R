library(dplyr)
usersJson <- fromJSON("users.json") 
class_contentJson<-fromJSON("class_content.json")
discussion_data<-data.frame(post_id=character(0), author=character(0), type=character(0), when=character(0),subject=character(0), content=character(0), stringsAsFactors=FALSE)

for(i in 1:nrow(class_contentJson)){
  paste("i=",i)
  post_record<-class_contentJson[i,]
  post_log<-post_record$change_log
  post_replies<-post_record$children
  post_id<-post_log[[1]][[1]][[1]]
  
  for(l in 1:length(post_record$history[[1]][[1]])){
  author<-ifelse(is.null(post_record$history[[1]][[1]][[l]]),NA,post_record$history[[1]][[1]][[l]])
  subject<-ifelse(is.null(post_record$history[[1]][[4]][[l]]),NA,post_record$history[[1]][[4]][[l]])
  content<-ifelse(is.null(post_record$history[[1]][[3]][[l]]),NA,post_record$history[[1]][[3]][[l]])
  type<-ifelse(is.null(post_record$type),NA,post_record$type)
  when<-ifelse(is.null(post_log[[1]][[5]][[1]]),NA,post_log[[1]][[5]][[1]])
  ob_list<-as.list(c(post_id,author,type,when,subject,content))
  discussion_data<-rbind(discussion_data,setNames(ob_list,names(discussion_data)))
  discussion_data[,1:6]<-apply(discussion_data[,1:6],2,as.character)
  }
  l<-1
  
  if(length(post_replies[[1]])!=0){
  for(j in 1:nrow(post_replies[[1]])){
    paste("j is", j)
    author<-ifelse(is.null(post_replies[[1]][[8]][[j]]),NA,post_replies[[1]][[8]][[j]])
    post_replies_children<-post_replies[[1]][[2]][[j]]
    content<-ifelse(is.null(post_replies[[1]]$subject[[j]]),NA,post_replies[[1]]$subject[[j]])
    when<-ifelse(is.null(post_replies[[1]]$updated[[j]]),NA,post_replies[[1]]$updated[[j]])
    type<-ifelse(is.null(post_replies[[1]]$type[[j]]),NA,post_replies[[1]]$type[[j]])
    ob_list<-as.list(c(post_id,author,type,when,subject,content))
    discussion_data<-rbind(discussion_data,setNames(ob_list,names(discussion_data)))    
    discussion_data[,1:6]<-apply(discussion_data[,1:6],2,as.character)
    
    if(length(post_replies_children)!=0){
      for (k in 1:nrow(post_replies_children)){
        author<-ifelse(is.null(post_replies_children$uid[[k]]),NA,post_replies_children$uid[[k]])
        content<-ifelse(is.null(post_replies_children$subject[[k]]),NA,post_replies_children$subject[[k]])
        when<-ifelse(is.null(post_replies_children$updated[[k]]),NA,post_replies_children$updated[[k]])
        type<-ifelse(is.null(post_replies_children$type[[k]]),NA,post_replies_children$type[[k]])
        ##discussion_data[nrow(discussion_data)+1]<-c(post_id,author,subject,content,type,when)
        ob_list<-as.list(c(post_id,author,type,when,subject,content))
        ob_list<-lapply(ob_list, function(x) ifelse(x == "NULL", NA, x))
        discussion_data<-rbind(discussion_data,setNames(ob_list,names(discussion_data)))        
        discussion_data[,1:6]<-apply(discussion_data[,1:6],2,as.character)
       
      }
      k<-1
    }
   
  }
    j<-1
}
  
}
write.csv(discussion_data, file = "Discussion_Data_Oct23.csv")

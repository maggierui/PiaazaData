library(dplyr)
usersJson <- fromJSON("users.json") 
class_contentJson<-fromJSON("class_content.json")
discussion_data<-data.frame(post_id=character(0), author=character(0), type=character(0), when=character(0),subject=character(0), content=character(0), stringsAsFactors=FALSE)
str(discussion_data)
discussion_data

for(i in 1:3){

  paste("i=",i)
  post_record<-class_contentJson[i,]
  post_log<-post_record$change_log
  post_replies<-post_record$children
  post_id<-post_log[[1]][[1]][[1]]
  paste("post_id is",post_id)
  class(post_record$history)
  author<-post_record$history[[1]][[1]]
  paste("author id is",author)
  subject<-post_record$history[[1]][[4]]
  paste("subject is",subject)
  content<-post_record$history[[1]][[3]]
  paste("content is", content)
  type<-post_record$type
  paste("class of type is", class(type))
  when<-post_log[[1]][[5]][[1]]
  paste("class of when is", class(when))
  paste("when is", when)
  paste("The structure of the new list is", str(c(post_id,author,subject,content,type,when)))
  discussion_data<-rbind(discussion_data,setNames(as.list(c(post_id,author,type,when,subject,content)),names(discussion_data)))
  discussion_data[,1:6]<-apply(discussion_data[,1:6],2,as.character)
  paste("The structure of discussion_data right now is", str(discussion_data))
  class(post_replies[[1]])
  post_replies[[1]]
  
  length(post_replies)
   paste(is.data.frame(post_replies))
   paste(nrow(post_replies))
   length(post_replies)
  if(length(post_replies[[1]])!=0){
  for(j in 1:length(post_replies)){
    paste("j is", j)
    author<-post_replies[[j]][[8]]
    post_replies_children<-post_replies[[j]][[2]]
    content<-post_replies[[j]][[16]]
    when<-post_replies[[j]][[13]]
    type<-post_replies[[j]][[7]]
    discussion_data<-rbind(discussion_data,setNames(as.list(c(post_id,author,type,when,subject,content)),names(discussion_data)))
    discussion_data[,1:6]<-apply(discussion_data[,1:6],2,as.character)
    print(discussion_data)
    class(post_replies_children)
    length(post_replies_children)
    post_replies_children[[1]]
    class(post_replies_children[[1]])
    nrow(post_replies_children[[1]])
    post_replies_children[[1]][[2]]
    class(post_replies_children[[1]][[2]])
    if(nrow(post_replies_children[[1]])!=0){
      for (k in 1:nrow(post_replies_children[[1]])){
        paste("k is", k)
        print(k)
       
        author<-post_replies_children[[1]][[7]][[k]]
        content<-post_replies_children[[1]][[14]][[k]]
        when<-post_replies_children[[1]][[11]][[k]]
        type<-post_replies_children[[1]][[6]][[k]]
        ##discussion_data[nrow(discussion_data)+1]<-c(post_id,author,subject,content,type,when)
        discussion_data<-rbind(discussion_data,setNames(as.list(c(post_id,author,type,when,subject,content)),names(discussion_data)))
        discussion_data[,1:6]<-apply(discussion_data[,1:6],2,as.character)
        paste("The structure of discussion_data right now is", str(discussion_data))
        print(discussion_data)
      }
    }
    
  }
}
  
}


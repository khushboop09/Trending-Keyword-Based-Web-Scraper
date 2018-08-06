#install.packages("twitterR")
#install.packages("ROAuth")
#install.packages("RCurl")
#install.packages("devtools")

library(twitteR)
library(ROAuth)
library(RCurl)
library(devtools)

#Provide your own keys
consumer_key = "*****************"  
consumer_secret = "*****************"
access_token = "******************"
access_secret = "*****************"

#-----Twitter authentication-----
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

#-----Getting Trends from India
trends_india<-getTrends(woeid=23424848) #India
View(trends_india)

trends_india=as.data.frame(trends_india)
write.csv(trends_india, file="/twitter_trends.csv")

#----------cleaning the extracted trends---------
result<- read.csv("/twitter_trends.csv")
terms<- sub(pattern = "\\#", replacement = "", result$name)
df<- data.frame(result$X,terms,result$url,result$query,result$woeid)
final<- subset(df, !grepl("[[:punct:]]", df$terms))
write.csv(final, file = "/cleaned_twitter_trends.csv")
#------------end cleaning-----------------------

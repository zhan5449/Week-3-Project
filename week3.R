# Data Import and Cleaning
library(rstudioapi)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

raw_df <- read.csv("Data/week3.csv",header=TRUE)
raw_df$timeStart <- as.POSIXct(raw_df$timeStart)
raw_df$timeEnd <- as.POSIXct(raw_df$timeEnd)
clean_df <- raw_df[!format(raw_df$timeStart,'%m')=="06"&format(raw_df$timeStart,'%Y')=="2017",]
clean_df <- clean_df[clean_df$q6==1,]

# Analysis
clean_df$timeSpent <- difftime(clean_df$timeEnd,clean_df$timeStart)
hist(as.numeric(clean_df$timeSpent))
frequency_tables_list <- lapply(clean_df[,5:14],table)
par(mfrow=c(2,5)); lapply(frequency_tables_list,barplot)
sum(clean_df$q1>=clean_df$q2&clean_df$q2!=clean_df$q3)
count <- 0
for(i in 1:nrow(clean_df)){if(clean_df[i,"q1"]>=clean_df[i,"q2"]&clean_df[i,"q2"]!=clean_df[i,"q3"]){count <- count+1}}



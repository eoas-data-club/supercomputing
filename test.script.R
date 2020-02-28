# We're going to run a simple script on Amarel that takes a CSV as an input, manipulates it, 
# and returns another CSV as a product. 

timer<-proc.time()

library(tidyverse)

data<-read_csv("input.data.csv")

summary<-data%>%
  summarize(mean=mean(count), sd=sd(count))

mod<-lm(count~day, data)

time.taken <- proc.time() - timer

sink("output.file.csv")

cat("summary stats\n")

summary

cat("================================\n")

cat("model output\n")
summary(mod)

cat("================================\n")

cat("length of analysis\n")

time.taken
sink()

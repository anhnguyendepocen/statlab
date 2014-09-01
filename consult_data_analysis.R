# May/June 2014 consult database analysis

setwd("~/statlab_data/consult_analysis/")
load("statlabData.Rda") # loads two data frames

# clients: unique clients
# statlab: all consults

# some summary stats
table(clients$School)
table(clients$Gender)
table(clients$Consultant..user.id)
summary(statlab$Computing.id)

# statlab[statlab$Computing.id=="",]
# statlab[62,]

library(ggplot2)

ggplot(clients, aes(x=School)) + 
  geom_bar(position="dodge") + coord_flip() +
  ggtitle("Unique Clients by School")

ggplot(clients, aes(x=School, fill=Gender)) + 
  geom_bar(position="dodge") + coord_flip() +
  ggtitle("Unique Clients by School by Gender") 

# updated 6/2/14 per MPC
# consults by month (April 2013 - May 2014)
ggplot(statlab[statlab$Consult.Date >= as.Date("2013-04-01") & 
                 statlab$Consult.Date <= as.Date("2014-05-31")  & 
                 !grepl("NA",statlab$MY),], aes(x=MY)) + 
  geom_bar(position="dodge") + 
  scale_x_discrete(limits=c("Apr13","May13","Jun13","Jul13","Aug13",
                            "Sep13","Oct13", "Nov13","Dec13",
                            "Jan14","Feb14","Mar14", "Apr14", "May14")) + 
  ylab("Number of Consults") + xlab("") +
  ggtitle("Consults by Month")


ggplot(statlab[statlab$Consult.Date >= as.Date("2013-04-01") & 
                 statlab$Consult.Date <= as.Date("2014-05-31") & 
                 !is.na(statlab$Consult.Date),], aes(x=Month)) + 
  geom_bar(position="dodge") + coord_flip() +
  scale_x_discrete(limits=c("April","May","June","July","August","September","October",
                            "November","December","January","February","March")) +
  ggtitle("Consults by Month")

ggplot(statlab[statlab$Consult.Date <= as.Date("2013-12-31"),], aes(x=Month, fill=Gender)) + 
  geom_bar(position="dodge") + coord_flip() +
  scale_x_discrete(limits=c("January","February","March","April","May","June","July",
                            "August","September","October","November","December")) +
  ggtitle("Consults by Month by Gender - 2013")

ggplot(statlab[statlab$Consult.Date > as.Date("2013-12-31"),], aes(x=Month)) + 
  geom_bar(position="dodge") + coord_flip() +
  scale_x_discrete(limits=c("January","February","March","April","May")) +
  ggtitle("Consults by Month - 2014")

ggplot(statlab[statlab$RConsult.Date > as.Date("2013-12-31"),], aes(x=Month, fill=Gender)) + 
  geom_bar(position="dodge") + coord_flip() +
  scale_x_discrete(limits=c("January","February","March","April","May")) +
  ggtitle("Consults by Month by Gender - 2014")


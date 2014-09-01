# Clay Ford
# read and prep in consult data

setwd("..//2014_May")

# consult <- read.csv("tblConsult.txt", header=TRUE)
# email <- read.csv("tblEmail.txt", header=TRUE)
# personal <- read.csv("tblPersonal.csv", header=TRUE)
# 
# # merge by RecordID
# tmp <- merge(consult, email, by="RecordID", all.x=TRUE, all.y=TRUE)
# statlab <- merge(tmp, personal, by="RecordID", all.x=TRUE, all.y=TRUE)

# # all records 
# # drop any empty record
# statlab <- subset(statlab, subset = statlab$Consultant..user.id..!="")

statlab <- read.csv("quAllInfo.csv", header=TRUE)

# any records with missing consultant?
any(is.na(statlab$Consultant..user.id..))

# format date
statlab$Request.Date <- as.Date(statlab$Request.Date, format="%m/%d/%Y")
statlab$Consult.Date.. <- as.Date(statlab$Consult.Date.., format="%m/%d/%Y")

# remove periods from end of names
names(statlab) <- gsub("\\.+$","",names(statlab))


# review dates; quite a few missing
# sum(is.na(statlab$Request.Date))
# sum(is.na(statlab$Consult.Date))
# sum(is.na(statlab$Consult.Date) & is.na(statlab$Request.Date))
# statlab[,c("Request.Date","Consult.Date")]

# let's use consult date; if consult date missing, use request date if available
statlab$Consult.Date <- as.Date(ifelse(is.na(statlab$Consult.Date),statlab$Request.Date, 
                               statlab$Consult.Date),  origin = "1970-01-01")

# var for month, year, month/year
statlab$Month <- months(statlab$Consult.Date)
statlab$Year <- format(statlab$Request.Date, format="%Y")
statlab$MY <- paste0(substr(statlab$Month,1,3),substr(statlab$Year,3,4))

# unique clients
clients <- statlab[!duplicated(statlab$Computing.id),]

# some clean up
clients$Consultant..user.id <- droplevels(clients$Consultant..user.id)
#clients$School.[which(clients$School.=="College of Arts and Sciences")]  <- "College of Arts and Sciences (CAS)"
clients$School <- droplevels(clients$School)

# rm(tmp, consult, email, personal)
setwd("~/statlab_data/consult_analysis/")
save(clients, statlab, file="statlabData.Rda")


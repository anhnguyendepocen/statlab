# Clay Ford
# UVa StatLab

# script to read in workshop registration forms

# read in spreadsheets from google docs
setwd("~/")

### windows users will need to get this certificate to authenticate
# download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")


library(RGoogleDocs)
if(exists("ps")) print("got password, keep going") else ps <-readline(prompt="get the password in ")  #conditional password asking
options(RCurlOptions = list(capath = system.file("CurlSSL", "cacert.pem", package = "RCurl"), 
                            ssl.verifypeer = FALSE))

sheets.con <- getGoogleDocsConnection(getGoogleAuth("uvastatlab@gmail.com", ps, service ="wise")) 
# get document names
Docs <- getDocs(sheets.con)
DocNames <- character(length(Docs)) 
for(i in 1:length(Docs)){
  DocNames[i] <- Docs[[i]]@title # get spreadsheet names
}

# need this to identify registration worksheets
test.names <- c("Instructions", "Registration", "Settings", "Templates", "Current Class Count",
                "Class Lists")

# "Template - Fall 2013" "StatLabTemplateBase2" screw things up, sigh...
reg.users <- c()
for(i in DocNames){
  ts2 <- getWorksheets(i,sheets.con)
  if(identical(test.names,names(ts2)) & i!="Template - Fall 2013" & i!="StatLabTemplateBase2"){
    #Get Registration info
    tmp <- sheetAsMatrix(ts2$"Registration",
                               header=TRUE, as.data.frame=TRUE, trim=TRUE)
    tmp$workshop <- i
    reg.users <-rbind(reg.users, tmp)
  }
}


write.csv(reg.users, "~/statlab_data/statlab_workshop_Fall13_Spring14.csv", row.names = FALSE)

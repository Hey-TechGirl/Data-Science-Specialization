# Question 1

if(!file.exists("USCommunities.csv")){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    download.file(fileUrl, destfile = "USCommunities.csv")
}

communities <- read.csv("USCommunities.csv")
max.worth <- sum(communities$VAL[!is.na(communities$VAL)] == 24)
max.worth


# Question 2
sum(is.na(communities$FES))
# answer: Tidy data has one variable per column.


# Question 3

if(!file.exists("Natural_Gas_Aquisition.xlsx")){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
    download.file(fileUrl, destfile = "Natural_Gas_Aquisition.xlsx", mode = 'wb')
}

install.packages("xlsx")
library(xlsx)

col <- 7:15
row <- 18:23

natural.gas <- read.xlsx("Natural_Gas_Aquisition.xlsx", sheetIndex = 1, colIndex = col, rowIndex = row)
natural.gas
total <- sum(natural.gas$Zip * natural.gas$Ext, na.rm = TRUE)
total

# Question 4

install.packages("XML")
library(XML)
library(RCurl)

restaurantsURL <- getURL("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml")
restaurants <- xmlParse(restaurantsURL)
class(restaurants)

zipcode <- xpathSApply(restaurants, "//zipcode", xmlValue)
sum(zipcode == 21231)


# Question 5

install.packages("data.table")
library("data.table")

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", "DT.csv")
DT <- fread("DT.csv")
file.info("DT.csv")$size

time1 <- system.time(tapply(DT$pwgtp15,DT$SEX,mean))
time2 <- system.time(DT[,mean(pwgtp15),by=SEX])
time3 <- system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
time4 <- system.time(mean(DT$pwgtp15,by=DT$SEX))
time5 <- system.time({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]})
time6 <- system.time(mean(DT$pwgtp15,by=DT$SEX))

# Instruction Quiz 1


## Question 1

The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

and load the data into R. The code book, describing the variable names is here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

How many properties are worth $1,000,000 or more?

```{r}
if(!file.exists("USCommunities.csv")){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    download.file(fileUrl, destfile = "USCommunities.csv")
}

communities <- read.csv("USCommunities.csv")
max.worth <- sum(communities$VAL[!is.na(communities$VAL)] == 24)
max.worth
```


## Question 2

Use the data you loaded from Question 1. Consider the variable FES in the code book. Which of the "tidy data" principles does this variable violate?

```{r}
sum(is.na(communities$FES))
```


## Question 3

Download the Excel spreadsheet on Natural Gas Aquisition Program here: 

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx

Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:

    dat
    
What is the value of:

    sum(dat$Zip*dat$Ext,na.rm=T)
    
(original data source: http://catalog.data.gov/dataset/natural-gas-acquisition-program)

```{r}
#install.packages("xlsx")
#library(xlsx)

col <- 7:15
row <- 18:23

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
#download.file(fileUrl, destfile = "Natural_Gas_Aquisition.xlsx", mode = 'wb')

natural.gas <- read.xlsx("Natural_Gas_Aquisition.xlsx", sheetIndex = 1, colIndex = col, rowIndex = row)
total <- sum(natural.gas$Zip * natural.gas$Ext, na.rm = TRUE)
total
```


## Question 4

Read the XML data on Baltimore restaurants from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml

How many restaurants have zipcode 21231?

```{r}
#install.packages("XML")
#library(XML)
#library(RCurl)

restaurantsURL <- getURL("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml")
restaurants <- xmlParse(restaurantsURL)
class(restaurants)

zipcode <- xpathSApply(restaurants, "//zipcode", xmlValue)
sum(zipcode == 21231)

```


## Question 5

The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv

using the fread() command load the data into an R object

    DT
Which of the following is the fastest way to calculate the average value of the variable
    
    pwgtp15
broken down by sex using the data.table package?

```{r}
#install.packages("data.table")
#library("data.table")

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", "DT.csv")
DT <- fread("DT.csv")
file.info("DT.csv")$size

time1 <- system.time(tapply(DT$pwgtp15,DT$SEX,mean))
time2 <- system.time(DT[,mean(pwgtp15),by=SEX])
time3 <- system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
time4 <- system.time(mean(DT$pwgtp15,by=DT$SEX))
time5 <- system.time({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]})
time6 <- system.time(mean(DT$pwgtp15,by=DT$SEX))
```


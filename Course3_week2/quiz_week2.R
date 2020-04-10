# Question 1
library(httr)
require(httpuv)
require(jsonlite)

oauth_endpoints("github")

myapp <- oauth_app("github", key = "yourkey", secret = "yoursecret")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

req <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
stop_for_status(req)
output <- content(req)

list(output[[17]]$name, output[[17]]$created_at)

# Question 2
install.packages("data.table")
install.packages("sqldf")
library(data.table)
library(sqldf)


if(!file.exists("USCommunities.csv")){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
    download.file(fileUrl, destfile = "USCommunities.csv")
}

acs <- read.csv("USCommunities.csv", header=T, sep=",")
query1 <- sqldf("select pwgtp1 from acs where AGEP < 50")

# Question 3
sample <- unique(acs$AGEP)
query1 <- sqldf("select distinct pwgtp1 from acs")
query2 <- sqldf("select unique * from acs")
query3 <- sqldf("select distinct AGEP from acs")
query4 <- sqldf("select AGEP where unique from acs")

identical(sample, query1$pwgtp1)
identical(sample, query3$AGEP)

# Question 4
data <- url("http://biostat.jhsph.edu/~jleek/contact.html")
html <- readLines(data)
close(data)
c(nchar(html[10]), nchar(html[20]), nchar(html[30]), nchar(html[100]))

# Question 5
if(!file.exists("data.csv")){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
    download.file(fileUrl, destfile = "data.csv")
}

colNames <- c("delete", "week", "delete", "sstNino12", "delete", "sstaNino12", 
              "delete", "sstNino3", "delete", "sstaNino3", "delete", "sstNino34", "delete", 
              "sstaNino34", "delete", "sstNino4", "delete", "sstaNino4")

w <- c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3)
data <- read.fwf("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", w, skip = 4, header = FALSE)
colnames(data) <- colNames

data <- data[, grep("^[^delete]", names(data))]
sum(data[, 4])

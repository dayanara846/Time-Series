
  # Create Time Series
  ### Generate time series from scratch.

setwd("C:/Users/ddaya/OneDrive/Data Science Portfolio/Quantitative Finance")


################### CREATE TIME SERIES  ###########################

### Generate a time series: Exampple 
## Example
StockPrice<-c(24.52,21.72,20.14,28.87,22.3,20,17.9,23.08,20,29,30,23.98) # data
StockPrice
StockPricets<- ts(StockPrice,start = c(2018,1),frequency = 12)	# set start dates of our data
StockPricets 
plot(StockPricets) # graph



# Example 1 - Convert .csv to Zoo 
### After importing the stock data, we analyze it.

### Convert data to time series: Example 1 --converting the dataset to Zoo after importing
#import data
library(readr)
StockData <- read_csv("GOOG.csv")
### Estimate the Net-Return
# let's suppose we invested $1358.18 on March 29 of 2020
Investment<-1358.18
StockData$Return<-StockData$`Adj Close`-Investment
# set as time series
# install.packages("zoo") # I already have it installed
library(zoo)
# select all dates after March 28, because, we invested on March 29.
StockData<-StockData[StockData$Date >= "2020-06-29" & StockData$Date <= "2020-12-30",]
dt = as.Date(StockData$Date, format="%Y-%m-%d")
Stockdataz = zoo(x=cbind(StockData$Volume,StockData$`Adj Close`), order.by=dt) 
colnames(Stockdataz) <- c("Volume","Adj Close")
head(Stockdataz)




summary(Stockdataz)



plot(Stockdataz$`Adj Close`)




#Example 2 - converting .csv to Zoo



#import data              
StockData <- read.zoo("GOOG.csv",header = TRUE, sep = ",",format="%Y-%m-%d")
StockData[length(StockData$Open),] # to identify last date
StockData <- window(StockData, start=as.Date("2020-06-29"), end=as.Date("2020-12-30")) ## select all dates after March 28, because, we invested on March 29.
StockData$Return<-StockData$`Adj.Close`-Investment
# Explotring the on our last 10 dates of the dataset, this also allows to verify our return at the end of the year.
tail(StockData, n=10)


summary(StockData)




plot(StockData$Adj.Close)


# Example 3 - Converting Each Variable to Zoo 



### Convert data to time series: Example 3 --converting each variable to Zoo       

StockData <- read.table("GOOG.csv",header = TRUE, sep = ",")
zVolume <-zoo(StockData[,2:2],as.Date(as.character(StockData[, 1]), format="%Y-%m-%d"))
zAdj.Close <-zoo(StockData[,3:3],as.Date(as.character(StockData[, 1]), format="%Y-%m-%d"))
zVars<-cbind(zVolume, zAdj.Close)


# We see the first dates of our dataset


head(StockData)


# Now, we explore the first dates of the variables that we changed to Zoo. 

head(zVars)


# Let us explore the variables.

summary(zVars)



plot(zVars$zAdj.Close)


#Example 4 - converting .csv to Xts


### Convert data to time series: Example 4 --converting the dataset to xts
StockData <- read.zoo("GOOG.csv",header = TRUE, sep = ",",format="%Y-%m-%d")
library(xts)
matrix_xts <- as.xts(StockData,dateFormat='POSIXct')
head(matrix_xts)




summary(matrix_xts)



plot(matrix_xts$Adj.Close)


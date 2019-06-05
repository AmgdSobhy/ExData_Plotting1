# plot1.R is a script for plotting the first plot data from the UC Irvine Machine Learning Repository

# First - Downlading Data File and Unzipping It

## Setting Working Directory to Where we need to download data

setwd("C:/Users/Amgds/Documents/Exploratory-Data-Analysis-Week-1-Project-Data")

## Downloading zip file and unzip it

if (!file.exists("Electric power consumption.zip")) {download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                                                                   file.path(getwd(),"Electric power consumption.zip"))
}

if (!file.exists("household_power_consumption.text")) {unzip("Electric power consumption.zip")}

# Second - Loading Data Files into R

##clearing Global Enviroment to Prevent any Errors

remove(list = ls())

## Loading data.table Package that Has Faster read.table Function

library(data.table)

## Reading Train Data

df <- read.table("household_power_consumption.txt",sep = ";", header = TRUE , stringsAsFactors = FALSE ,na.strings="?", as.is = TRUE)

## Converting Date into a Proper Class

df$Date <- as.Date(df$Date,"%d/%m/%Y")

## Subsetting the Data Frame

df <- subset(df,df$Date == as.Date("2007-02-01" ) | df$Date ==as.Date("2007-02-02"))

## Create a New Colume with date and time combined

DateTime <- paste(df$Date,df$Time)

## Converting DateTime into a Proper Class

DateTime <- strptime(DateTime,"%Y-%m-%d %H:%M:%S")

## Adding the New Data to the Data Set

df <- cbind(df,DateTime)

## Setting Working Directory to the local repository cloned from forked repository on GitHub

setwd("C:/Users/Amgds/Documents/ExData_Plotting1")

# Third _ Plotteing 

plot(df$Sub_metering_1~df$DateTime, type = "l", ylab = "Energy Sub Metering", xlab ="") 
lines(df$Sub_metering_2~df$DateTime, type = "l",col = "red") 
lines(df$Sub_metering_3~df$DateTime, type = "l", col ="blue")
legend("topright",lwd = c(1,1,1),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col =c("black","red","blue"))

# Fourth - Opening PNG Device

dev.copy(png,"Plot3.png", width = 480, height = 480)

# Fifth - Disconnect Plotting Device

dev.off()
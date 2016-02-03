## Store the data into variable if not already existed
if(!exists("NEI")){
  NEI <- readRDS("D:\\Exploratory Project 2\\mydoc\\summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("D:\\Exploratory Project 2\\mydoc\\Source_Classification_Code.rds")
}
##Aggregate of total value by year
agg <- aggregate(Emissions ~ year, NEI, sum)

## saves plot1 in png format
png('D:\\Exploratory Project 2\\mydoc\\plot1.png')
barplot(height=agg$Emissions, names.arg=agg$year, xlab="years", 
        ylab=expression('total PM'[2.5]*' emission'),
        main=expression('Total PM'[2.5]*' emissions from 1999-2008'))
dev.off()
## Store the data into variable if not already existed
if(!exists("NEI")){
  NEI <- readRDS("D:\\Exploratory Project 2\\mydoc\\summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("D:\\Exploratory Project 2\\mydoc\\Source_Classification_Code.rds")
}

## Taking data of only Baltimore City with fips='24510'
balNEI  <- NEI[NEI$fips=="24510", ]

##Aggregate of total value by year
agg <- aggregate(Emissions ~ year, balNEI, sum)

png('plot2.png')
barplot(height=agg$Emissions, names.arg=agg$year, xlab="years", 
        ylab=expression('total PM'[2.5]*' emission'),
        main=expression('Total PM'[2.5]*' in the Baltimore City, MD emissions from 1999-2008'))
dev.off()
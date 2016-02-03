setwd("D:\\Exploratory Project 2\\mydoc")

# Check if both data exist in the environment. If not, load the data.
if (!"neiData" %in% ls()) {
  neiData <- readRDS("D:\\Exploratory Project 2\\mydoc\\summarySCC_PM25.rds")
}
if (!"sccData" %in% ls()) {
  sccData <- readRDS("D:\\Exploratory Project 2\\mydoc\\Source_Classification_Code.rds")
}

subset <- neiData[neiData$fips == "24510"|neiData$fips == "06037", ]
library(ggplot2)

png(filename = "D:\\Exploratory Project 2\\mydoc\\plot6_1.png", 
    width = 480, height = 480, 
    units = "px", bg = "transparent")
motor <- grep("motor", sccData$Short.Name, ignore.case = T)
motor <- sccData[motor, ]
motor <- subset[subset$SCC %in% motor$SCC, ]

#motorEmission <- aggregate(motor$Emissions, list(motor$year), FUN = "sum")

aggregatedTotalByYearAndFips <- aggregate(Emissions ~ year + fips, motor, sum)
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="24510"] <- "Baltimore, MD"
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

g <- ggplot(aggregatedTotalByYearAndFips, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
print(g)
dev.off()
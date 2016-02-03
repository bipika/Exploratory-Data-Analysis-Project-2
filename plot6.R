setwd("D:\\Exploratory Project 2\\mydoc")

# Check if both data exist in the environment. If not, load the data.
if (!"neiData" %in% ls()) {
  neiData <- readRDS("D:\\Exploratory Project 2\\mydoc\\summarySCC_PM25.rds")
}
if (!"sccData" %in% ls()) {
  sccData <- readRDS("D:\\Exploratory Project 2\\mydoc\\Source_Classification_Code.rds")
}
# merge two data
subset <- neiData[neiData$fips == "24510"|neiData$fips == "06037", ]

#call library
library(ggplot2)

## set the graph in png format
png(filename = "D:\\Exploratory Project 2\\mydoc\\plot6.png", 
    width = 480, height = 480, 
    units = "px", bg = "transparent")
motor <- grep("motor", sccData$Short.Name, ignore.case = T)
motor <- sccData[motor, ]
motor <- subset[subset$SCC %in% motor$SCC, ]


# Aggregate of motor vehicle emission
motorEmission <- aggregate(Emissions ~ year + fips, motor, sum)
motorEmission$fips[motorEmission$fips=="24510"] <- "Baltimore, MD"
motorEmission$fips[motorEmission$fips=="06037"] <- "Los Angeles, CA"

#plot the data in graph
g <- ggplot(motorEmission, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
print(g)
dev.off()
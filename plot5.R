## Store the data into variable if not already existed
if(!exists("NEI")){
  NEI <- readRDS("D:\\Exploratory Project 2\\mydoc\\summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("D:\\Exploratory Project 2\\mydoc\\Source_Classification_Code.rds")
}
# Get the data of 24510 which is Baltimore.
subset <- NEI[NEI$fips == "24510", ] 

## fetch records with "motor" in Short.Name of SCC and merge
motor <- grep("motor", SCC$Short.Name, ignore.case = T)
motor <- SCC[motor, ]
motor <- subset[subset$SCC %in% motor$SCC, ]

# Aggregate of coal combustion-related sources emissions
motorEmission <- aggregate(motor$Emissions, list(motor$year), FUN = "sum")

## set the graph in png format
png(filename = "D:\\Exploratory Project 2\\mydoc\\plot5.png", 
    width = 480, height = 480, 
    units = "px")

#plot the data in graph
plot(motorEmission, type = "l", xlab = "Year", 
     ylab = expression('total PM'[2.5]*" emission"), 
     main = "Total Emissions From Motor Vehicle Sources\nfrom 1999-2008 in Baltimore City")

dev.off()
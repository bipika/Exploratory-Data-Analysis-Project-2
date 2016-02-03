## Store the data into variable if not already existed
if(!exists("NEI")){
  NEI <- readRDS("D:\\Exploratory Project 2\\mydoc\\summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("D:\\Exploratory Project 2\\mydoc\\Source_Classification_Code.rds")
}

## fetch records with "coal" in Short.Name of SCC and summarize
coal <- grep("coal", SCC$Short.Name, ignore.case = T)
coal <- SCC[coal, ]
coal <- NEI[NEI$SCC %in% coal$SCC, ]

## Aggregate of coal combustion-related sources emissions
coalEmission <- aggregate(coal$Emissions, list(coal$year), FUN = "sum")

## set the graph in png format
png(filename = "D:\\Exploratory Project 2\\mydoc\\plot4.png", 
    width = 480, height = 480, 
    units = "px")
## plot the graph
plot(coalEmission, type = "l", xlab = "Year", 
     ylab = expression('total PM'[2.5]*" emission"),
     main = "Total Emissions From Coal Combustion-related source\nfrom 1999-2008")

dev.off()
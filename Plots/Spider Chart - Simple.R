# Library
library(fmsb)
library(readxl)

# Create data: note in High school for Jonathan:
#data <- as.data.frame(matrix(sample(2:20 , 10, replace = T) , ncol = 10))
#colnames(data) <- c("math" , "english" , "biology" , "music" , "R-coding", "data-viz" , "french" , "physic", "statistic", "sport" )

Spider_Chart_Test <- read_excel("C:/Users/lucas/Desktop/Team Experience Manager/Scripts/Spider Chart Test.xlsx", 
                                range = "A1:G4")

# To use the fmsb package, I have to add 2 lines to the dataframe: the max and min of each topic to show on the plot!
#data <- rbind(rep(20, 10) , rep(0, 10) , data)

radarchart(Spider_Chart_Test, axistype = 1,
            
            #custom polygon
            pcol = rgb(0.2, 0.5, 0.5, 0.9) ,pfcol = rgb(0.2, 0.5, 0.5, 0.5) , plwd = 3 , 
            
            #custom the grid
            cglcol = "grey", cglty = 1, axislabcol = "grey", caxislabels = seq(1, 5, 1), cglwd = 0.8,
            
            #custom labels
            vlcex = 1.2
)

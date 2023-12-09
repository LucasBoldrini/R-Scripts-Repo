library(plotly)
library(viridis)
library(readxl)

# Replace 'Sheet1' with the correct sheet name from your Excel file if needed
data <- read_excel("2023 Teams by Country - Population and GDP per Capita - No CHN, IND and USA.xlsx")

# Create a 3D scatter plot
p <- plot_ly(data, x = ~Population, y = ~`GDP per Capita`, z = ~Teams, 
             type = "scatter3d", mode = "markers", marker = list(color = ~`GDP per Capita`, colorscale = "Viridis"))

# Set axis labels
p <- layout(p, scene = list(xaxis = list(title = "Population"),
                            yaxis = list(title = "GDP per Capita"),
                            zaxis = list(title = "Number of Teams")))

# Show the plot
p

library(maps)
library(readxl)

# Set up the plot parameters
par(mar = rep(0, 4))
ylim <- c(-80, 80)
xlim <- c(-180, 180)

# Create a blank plot
plot(1, type = "n", xlim = xlim, ylim = ylim, xlab = "", ylab = "")

# Add the world map with no borders and a custom land color
map('world', col = "#00C180", fill = TRUE, bg = "transparent", lwd = 0.000001, add = TRUE, border = "#00C180")

# Read the Excel file
cities <- read_excel("2024_igem_community_members_locations.xlsx")

# Add dots to all the specified cities with their respective colors
points(cities$Longitude, cities$Latitude, pch = 16, col = cities$Color, cex = 1.5)

# Define the labels and corresponding colors for the legend
legend_labels <- c("Ambassador", "Multiple Positions", "Project Head", "Project Member", "Staff Member")
legend_colors <- c("#F9B1FF", "#FFB346", "#F4FF16", "#28D5FF", "#F01212")

# Add the legend to the bottom left corner with adjustments
legend("bottomleft", 
       legend = legend_labels, 
       col = legend_colors, 
       pch = 16, 
       cex = 1.5,        # Increase the size of the legend text
       pt.cex = 2,       # Increase the size of the points in the legend
       bty = "n",        # Remove the box around the legend
       inset = c(0.1, 0.2),  # Move the legend slightly up and to the right
       x.intersp = 0.5,  # Increase spacing between legend text and dots
       y.intersp = 0.8)  # Increase spacing between rows in the legend

# Highlight the countries where cities are located
# highlighted_countries <- c("Brazil", "Italy", "Spain", "France")
# map('world', regions = highlighted_countries, fill = TRUE, col = "lightblue", border = "white", add = TRUE) #border = "transparent" for invisible borders

# Label the cities next to the dots
# text(cities$Lon, cities$Lat, cities$City, pos = 4, col = "#100b66", cex = 0.5)

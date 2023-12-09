library(maps)

# Set up the plot parameters
par(mar = rep(0, 4))
ylim <- c(-80, 80)
xlim <- c(-180, 180)

# Create a blank plot
plot(1, type = "n", xlim = xlim, ylim = ylim, xlab = "", ylab = "")

# Add the world map using the 'map()' function with matching border and background color
map('world', col = "grey", fill = TRUE, bg = "white", lwd = 0.05, add = TRUE, border = "transparent") # border = "transparent"

# Define the latitude and longitude coordinates of multiple cities
cities <- data.frame(
  City = c("Rome", "Barcelona", "Paris", "São Paulo", "São Carlos"),
  Lat = c(41.9028, 41.3851, 48.8566, -23.5505, -22.0056),
  Lon = c(12.4964, 2.1734, 2.3522, -46.6333, -47.2141)
)

# Highlight the countries where cities are located
highlighted_countries <- c("Brazil", "Italy", "Spain", "France")
map('world', regions = highlighted_countries, fill = TRUE, col = "lightblue", border = "white", add = TRUE) #border = "transparent" for invisible borders

# Add dots to all the specified cities
points(cities$Lon, cities$Lat, pch = 16, col = "#100b66", cex = 1)

# Label the cities next to the dots
text(cities$Lon, cities$Lat, cities$City, pos = 4, col = "#100b66", cex = 0.5)
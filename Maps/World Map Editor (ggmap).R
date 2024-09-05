library(ggplot2)
library(ggmap)
library(readxl)

# Register your Google API key if using ggmap (not necessary for basic plotting, but for enhanced maps)
# register_google(key = "your_google_api_key")

# Read the Excel file
cities <- read_excel("2024_igem_community_members_locations.xlsx")

# Set up a base map using ggmap (optional, for detailed maps) or you can use a simple world map
# world_map <- get_map(location = "world", zoom = 2, maptype = "terrain") 

# Plot using ggplot2
ggplot() +
  borders("world", colour = "#00C180", fill = "#00C180") +
  geom_point(data = cities, aes(x = Longitude, y = Latitude, color = Color), 
             size = 3) +  # Add city points with custom colors
  scale_color_identity() +  # Use the colors directly from the dataset
  theme_void() +  # Remove axis and labels for a clean look
  theme(legend.position = "bottomleft") +  # Set legend position
  guides(color = guide_legend(title = "Role", 
                              override.aes = list(size = 5)))  # Customize legend appearance

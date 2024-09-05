library(ggplot2)
library(ggmap)
library(readxl)

# Read the Excel file
cities <- read_excel("2024_igem_community_members_locations.xlsx")

# Define the labels and corresponding colors for the legend
legend_labels <- c("Ambassador/Promoter", "Project Head", "Project Member", "Staff Member")
legend_colors <- c("#050B4C", "#FFB346", "#28D5FF", "#F01212")

# Create a factor in the dataset for the roles, assuming the 'Color' column corresponds to roles
cities$Role <- factor(cities$Color, 
                      levels = legend_colors, 
                      labels = legend_labels)

# Plot using ggplot2
ggplot() +
  borders("world", colour = "#00C180", fill = "#00C180") +  # Base world map
  geom_point(data = cities, aes(x = Longitude, y = Latitude, color = Role), 
             size = 3) +  # Add city points with roles as colors
  scale_color_manual(values = setNames(legend_colors, legend_labels)) +  # Custom legend colors
  theme_void() +  # Remove axis and labels for a clean look
  theme(
    legend.position = c(0.2, 0.4),  # Move legend up and to the right (adjust as needed)
    legend.title = element_text(size = 14),  # Increase size of the legend title
    legend.text = element_text(size = 18),   # Increase size of the legend text
    legend.key.size = unit(1.5, 'lines'),    # Adjust size of legend points
    legend.spacing.y = unit(0.8, 'lines'),   # Adjust vertical spacing between legend items
    legend.box.background = element_blank()  # Remove box around the legend
  ) +
  guides(color = guide_legend(
    title = " ", 
    override.aes = list(size = 5),  # Adjust size of points in legend
    keyheight = unit(2, 'lines'),   # Adjust height of points in the legend
    keywidth = unit(0.5, 'lines'),  # Adjust width between legend items
    label.position = "right"        # Adjust label position relative to points
  ))

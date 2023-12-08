# Load required libraries
library(ggplot2)
library(viridis)
library(readxl)

# Read the data from the provided data frame
data <- data.frame(
  Region = c(
    "Africa", "Asia", "Europe", "Latin America", "North America",
    "Africa", "Asia", "Europe", "Latin America", "North America",
    "Africa", "Asia", "Europe", "Latin America", "North America"
  ),
  Count = c(2, 113, 77, 14, 60, 5, 117, 70, 12, 54, 3, 138, 72, 5, 59),
  Year = c(2019, 2019, 2019, 2019, 2019, 2022, 2022, 2022, 2022, 2022, 2023, 2023, 2023, 2023, 2023)
)

# Convert Region and Year to factors
data$Region <- factor(data$Region)
data$Year <- factor(data$Year)

# Set colors for the plot
region_colors <- viridis::viridis(5)

# Plot the barplot with two bars per region for each year
ggplot(data, aes(x = Region, y = Count, fill = Year)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.9), color = "black") +
  geom_text(aes(label = Count), vjust = -0.5, position = position_dodge(width = 0.9)) +
  scale_fill_manual(values = viridis::viridis(3)) +
  labs(title = "Collegiate Teams by Region and Year",
       x = "Region",
       y = "Count") +
  theme_bw() +
  theme(axis.text.x = element_text(size = 15),
        axis.text.y = element_text(size = 15),
        axis.title.y = element_text(size = 18),
        panel.grid.major.x = element_blank(),
        plot.title = element_text(size = 25)) +
  scale_x_discrete(drop = FALSE) +
  scale_y_continuous(breaks = seq(0, 250, by = 50), expand = expansion(mult = c(0, .1))) +
  guides(fill = guide_legend(title = "Year"))

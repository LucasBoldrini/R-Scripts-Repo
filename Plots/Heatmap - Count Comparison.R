library(ggplot2)
library(reshape2)
library(colorspace)
library(readxl)

# Read the data from an Excel file
data <- read_excel("Heatmap_keywords.xlsx")

# Reshape the data into a long format for ggplot2
data_melt <- melt(data, id.vars = "Keywords", variable.name = "URL_Type", value.name = "Hits")

# Create a custom color palette using colorspace
# custom_palette <- sequential_hcl(100, palette = "Rocket")
custom_palette <- rev(sequential_hcl(100, palette = "Rocket"))  # Invert the color palette

# Create the heatmap with the custom color palette and no borders
heatmap <- ggplot(data_melt, aes(x = Keywords, y = URL_Type, fill = Hits)) +
  geom_tile(color = "white") +
  scale_fill_gradientn(colors = custom_palette) +
  labs(title = "Heatmap of Keyword Hits by URL Type", x = NULL, y = NULL) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 9),
    axis.text.y = element_text(angle = 0, hjust = 1, size = 12),
    plot.title = element_text(hjust = 0.5),
    panel.background = element_rect(fill = "white"),
    plot.background = element_rect(fill = "white"),
    panel.grid = element_blank(),
    axis.ticks = element_blank(),
    panel.border = element_blank(),
    plot.margin = margin(30, 30, 5, 5) 
  ) +
  coord_fixed(ratio = 1)  # Ensure tiles are squares

heatmap

# ggsave("Heatmap_keywords_no_border.png", plot = heatmap, width = 10, height = 6, dpi = 300, units = "in", bg = "white")

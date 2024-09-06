library(readxl)
library(ggplot2)
library(viridis)
library(ggrepel)
library(scales)

data <- read_excel("2023 Teams GDP Per Capita by Country - No China and USA.xlsx")

format_gdp_per_capita <- function(x) {
  dollar_format(suffix = "K", prefix = "$")(x / 1000)
}

p <- ggplot(data, aes(x = GDP_Per_Capita, y = Teams, label = Country)) +
  geom_point(aes(color = GDP_Per_Capita), size = 4, alpha = 0.8) +
  scale_color_viridis(option = "viridis", trans = "reverse", labels = format_gdp_per_capita) +
  geom_text_repel(box.padding = 0.5, segment.color = "grey50", max.overlaps = 100, size = 3.2) +
  labs(title = "Number of 2023 iGEM Teams per Country vs. GDP per Capita (Nominal)",
       x = "Nominal GDP per Capita (USD)",
       y = "Teams",
       caption = "Data source: IMF",
       color = "GDP per Capita (USD)") +
  scale_x_continuous(labels = format_gdp_per_capita, breaks = seq(0, max(data$GDP_Per_Capita), by = 10000)) +
  scale_y_continuous(breaks = seq(0, max(30), by = 2)) +  # Add more y-axis ticks
  theme_minimal() +
  theme(legend.position = "bottom",
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 18),
        legend.title = element_text(size = 12),
        legend.text = element_text(size = 7),
        plot.title = element_text(size = 18))

p

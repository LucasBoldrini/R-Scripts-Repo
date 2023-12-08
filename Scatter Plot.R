library(readxl)
library(ggplot2)
library(viridis)
library(ggrepel)
library(scales)

data <- read_excel("2023 Teams HDI by Country - No CHN and USA.xlsx")

p <- ggplot(data, aes(x = HDI, y = Teams, label = Country)) +
  geom_point(aes(color = HDI), size = 4, alpha = 0.8) +
  scale_color_viridis(option = "viridis", trans = "reverse", labels = scales::number_format(accuracy = 0.001)) +
  geom_text_repel(box.padding = 0.5, segment.color = "grey50", max.overlaps = 100, size = 3.2) +
  labs(title = "Number of 2023 iGEM Teams per Country vs. Human Development Index",
       x = "Human Development Index",
       y = "Teams",
       caption = "Data source: UNDP",
       color = "HDI") +
  scale_x_continuous(breaks = seq(0, max(1), by = 0.05),
                     labels = scales::number_format(accuracy = 0.001)) +
  scale_y_continuous(breaks = seq(0, max(20), by = 2)) +
  theme_minimal() +
  theme(legend.position = "bottom",
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 18),
        legend.title = element_text(size = 12),
        legend.text = element_text(size = 7),
        plot.title = element_text(size = 18))

p

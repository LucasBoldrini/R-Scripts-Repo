library(readxl)
library(ggplot2)
library(colorspace)

# Load the data from the xlsx file
teams <- read_excel("2023_Jamboree_Attendees_Final_Title.xlsx")

# Reorder the levels of the Country variable by Count
teams$Region <- reorder(teams$Title, teams$Count)

# Calculate the percentage of each bar
teams$Percent <- teams$Count / sum(teams$Count) * 100

# Choose a different color palette from colorspace (e.g., "Purple-Green")
colorspace_palette <- sequential_hcl(7, "Plasma")

# Invert the color palette
colorspace_palette_inverted <- rev(colorspace_palette)

# Create the horizontal bar plot of space teams with ordered bars
space_teams_hist <- ggplot(teams, aes(x = Count, y = Region)) +
  geom_bar(stat = "identity", aes(fill = Region), color = "black", size = 0) +
  geom_text(aes(label = sprintf("%.1f%%", Percent)), hjust = -0.2, size = 3.5) +
  labs(title = "2023 Jamboree Tickets by Title",
       x = "Count",
       y = "") +
  theme_bw() +
  theme(axis.text.x = element_text(size = 10, angle = 30, hjust = 1),
        axis.text.y = element_text(size = 12),
        panel.grid.major.y = element_blank(),
        plot.title = element_text(size = 22),
        axis.title.x = element_text(size = 17)) +
  scale_x_continuous(breaks = seq(0, 2500, by = 50), expand = expansion(mult = c(0, .1))) +
  scale_fill_manual(values = colorspace_palette_inverted) +  # To use inverted color palette: colorspace_palette_inverted
  guides(fill = FALSE)

space_teams_hist

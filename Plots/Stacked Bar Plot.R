library(readxl)
library(tidyverse)
library(viridis)

# Read the data from the Excel file
teams <- read_excel("C:/Users/lucas/Desktop/Team Experience Manager/Scripts/In-Person - Collegiate UG-OG.xlsx")

# Calculate the total for each region
teams$Total <- teams$Undergrad + teams$Overgrad

# Calculate the percentage for each Section within each region
teams$Percent_Undergrad <- (teams$Undergrad / teams$Total) * 100
teams$Percent_Overgrad <- (teams$Overgrad / teams$Total) * 100

# Convert the data to a long format
teams_long <- teams %>%
  gather(key = "Section", value = "Count", Undergrad, Overgrad) %>%
  mutate(Percent = Count / sum(Count) * 100)

# Create the horizontal stacked bar plot
space_teams_stacked_horizontal <- ggplot(teams_long, aes(y = Region, x = Count, fill = Section)) +
  geom_bar(stat = "identity", position = "stack", width = 0.7) + 
  geom_text(aes(label = sprintf("%.1f%%", Percent), 
                hjust = ifelse(Region %in% c("Latin America", "Africa") & Section == "Undergrad", 0.2, 
                               ifelse(Region %in% c("Latin America", "Africa") & Section == "Overgrad", -0.5, 0.5))),
            position = position_stack(vjust = 0.5), size = 4) +
  labs(title = "Number of 2023 Collegiate In-Person iGEM Teams by Region",
       x = "Team Count",
       y = "") +
  theme_bw() +
  theme(axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 14),
        panel.grid.major.y = element_blank(),  # Remove horizontal grid lines
        panel.grid.minor = element_blank(),    # Remove minor grid lines
        plot.title = element_text(size = 25),
        axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 20)) +
  scale_fill_viridis_d() +
  scale_fill_manual(values = c("Undergrad" = "#078f9f", "Overgrad" = "#7f9f07")) +
  scale_x_continuous(breaks = seq(0, 4400, by = 10), expand = expansion(mult = c(0, .1)))

space_teams_stacked_horizontal

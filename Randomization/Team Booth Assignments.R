library(readxl)
library(writexl)
library(tidyverse)

excel_file <- "In-Person Teams.xlsx"
village_column <- "Village"
group_column <- "Group"

# Read the data from the Excel file
teams_data <- read_excel(excel_file)

# Get a list of unique village names
villages <- unique(teams_data[[village_column]])

# Define booth nomenclatures for each village
booth_nomenclatures <- list(
  Therapeutics = paste0("P", 1:29),
  Agriculture = paste0("A", 1:9),
  Food_Nutrition = paste0("B", 1:5),
  High_School = paste0("C", 1:49),
  Foundational_Advance = paste0("E", 1:11),
  Software_AI = paste0("F", 1:3),
  Biomanufacturing = paste0("H", 1:15),
  Climate_Crisis = paste0("K", 1:6),
  Environment = paste0("L", 1:11),
  Bioremediation = paste0("N", 1:17),
  Conservation = paste0("O", 1:4),
  Diagnostics = paste0("Q", 1:15)
)

# Create a mapping of village names to zones
village_zones <- list(
  Therapeutics = "P",
  Agriculture = "A",
  Food_Nutrition = "B",
  High_School = "C",
  Foundational_Advance = "E",
  Software_AI = "F",
  Biomanufacturing = "H",
  Climate_Crisis = "K",
  Environment = "L",
  Bioremediation = "N",
  Conservation = "O",
  Diagnostics = "Q"
)

# Create an empty data frame to store all teams, booths, and zones
combined_data <- data.frame()

# Loop through each village
for (village in villages) {
  # Subset data for the current village
  village_data <- teams_data %>%
    filter(.data[[village_column]] == village)
  
  # Get the booth nomenclature for the current village
  village_booth_nomenclature <- booth_nomenclatures[[village]]
  
  # Get the zone for the current village
  village_zone <- village_zones[[village]]
  
  # Shuffle booth labels randomly
  set.seed(789)
  
  # Create a data frame with teams, villages, groups, zones, and booths for the current village
  village_team_data <- village_data %>%
    select(Village, Group, TeamID, Team)
  
  # Separate booths for Group A and Group B
  group_A_teams <- village_team_data %>%
    filter(.data[[group_column]] == "A")
  
  group_B_teams <- village_team_data %>%
    filter(.data[[group_column]] == "B")
  
  shuffled_booths_A <- sample(village_booth_nomenclature, size = nrow(group_A_teams))
  shuffled_booths_B <- sample(village_booth_nomenclature, size = nrow(group_B_teams))
  
  group_A_teams$Booth <- shuffled_booths_A
  group_B_teams$Booth <- shuffled_booths_B
  
  # Combine Group A and Group B teams
  village_team_data <- rbind(group_A_teams, group_B_teams)
  
  # Add the "Zone" column
  village_team_data$Zone <- village_zone
  
  # Extract the booth number and add it as a new column
  village_team_data$BoothNumber <- as.integer(gsub("\\D", "", village_team_data$Booth))
  
  # Append the data for the current village to the combined data frame
  combined_data <- rbind(combined_data, village_team_data)
}

# Output a single Excel sheet with all teams, villages, groups, zones, booths, and booth numbers
write_xlsx(combined_data, "Team Booth Assignments.xlsx")

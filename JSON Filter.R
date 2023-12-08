library(jsonlite)
library(readxl)
library(writexl)

df <- read_excel("2023 Jamboree Attendees - Final Clean-Up.xlsx")

extract_title <- function(json_string) {
  tryCatch(
    {
      data <- fromJSON(json_string)
      title <- data$title
      return(title)
    },
    error = function(e) {
      return(NA)
    }
  )
}

df$title <- sapply(df$check_in_data, extract_title)

# Convert the list column to a character column
df$title <- sapply(df$title, function(x) ifelse(is.null(x), NA, x))

df <- df[, !names(df) %in% c("check_in_data")]

write_xlsx(df, "2023_Jamboree_Attendees_Final_Title.xlsx")

library(readxl)
library(wordcloud)
library(RColorBrewer)

# Load data
data <- read_excel("Wordcloud_keywords_team_info.xlsx")

# Extract keywords and their counts
keywords <- data$Keywords
counts <- data$`Team Info`

# Remove custom stopwords from the keywords
custom_stopwords <- c("will", "using", "can", "help", "work", "finally", "applications",
                      "tools", "goal", "however", "novel", "useful", "step", "test",
                      "rate", "enhance", "year", "provide", "several", "build", "since",
                      "major", "units", "based", "used", "aims", "one", "aim", "cost",
                      "create", "three", "key", "using", "make", "essential", "first", "ways", "due", "within", "like", "thus")

filtered_keywords <- keywords[!keywords %in% custom_stopwords]
filtered_counts <- counts[!keywords %in% custom_stopwords]

# Generate the word cloud with enhancements
wordcloud(words = filtered_keywords, freq = filtered_counts, random.order = FALSE, 
          colors = brewer.pal(13, "Set2"), scale = c(4, 0.5), rot.per = 0.3)

# title("Keyword Frequency Word Cloud")

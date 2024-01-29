library(readxl)
library(wordcloud)
library(RColorBrewer)
library(tm)

data <- read_excel("Space Teams Abstracts.xlsx")

text_data <- data$Project_Abstract

# Define custom stopwords
custom_stopwords <- c("will", "using", "can", "help", "work", "finally", "applications",
                      "tools", "goal", "however", "novel", "useful", "step", "test",
                      "rate", "enhance", "year", "provide", "several", "build", "since",
                      "major", "units", "based", "used", "aims", "one", "aim", "cost",
                      "create", "three", "key", "using", "make", "essential", "biology", "biological", "first", "ways", "due", "within", "like", "thus")

corpus <- Corpus(VectorSource(text_data))
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)

# Remove custom stopwords
corpus <- tm_map(corpus, removeWords, c(stopwords("english"), custom_stopwords))

corpus <- tm_map(corpus, stripWhitespace)
text_data_processed <- unlist(sapply(corpus, as.character))

wordcloud(text_data_processed, random.order = FALSE, colors = brewer.pal(8, "Dark2"))

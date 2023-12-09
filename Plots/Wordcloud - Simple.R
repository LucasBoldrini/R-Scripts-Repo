library(wordcloud)
library(RColorBrewer)
library(tm)

# Specify the path to your text file
text_file_path <- "igem__2023_titleandabstracts.txt"

# Read text from the text file
text_data <- tolower(readLines(text_file_path, warn = FALSE))

# Create a Corpus
corpus <- Corpus(VectorSource(text_data))
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stripWhitespace)
text_data_processed <- unlist(sapply(corpus, as.character))

# Create a word cloud
wordcloud(text_data_processed, random.order = FALSE, colors = brewer.pal(8, "Dark2"))

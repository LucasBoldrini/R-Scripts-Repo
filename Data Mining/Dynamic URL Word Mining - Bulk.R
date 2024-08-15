library(RSelenium)
library(rvest)
library(tm)
library(readxl)
library(writexl)

# Start RSelenium
rD <- rsDriver(browser = "firefox", port = 4545L)
remDr <- rD[["client"]]

# Define your target keywords
target_keywords <- c("autonomous food", "autonomous pharmaceutical", "autonomous food", "bioink", "biomarker monitoring", "biomining", "bioreactor", "biorefinery", "bioregenerative",
                     "cell expansion", "closed loop", "feedstock", "habitat pathogen", "health-indicative biomarkers", "health monitoring", "human-use items",
                     "human waste", "ISRU", "life support", "Lunar", "microbial electrolysis cell", "Mars", "Martian", "microbial fuel cell",
                     "microbiome", "mitigation", "Moon", "organic waste", "pathogen monitoring", "perchlorate", "plastic", "radiation", "radioprotection", "radioresistance", "refinery",
                     "source material", "space exploration", "storage", "terraforming", "waste", "waste repurposing", "water recovery", "water recycling", "employment", "practices", "increasingly", "aachen")

# Read URLs from Excel sheet
excel_file <- "team-info-pages-test.xlsx"
excel_sheet <- "teams-all"
url_column <- "Wiki"
data <- read_excel(excel_file, sheet = excel_sheet)

# Extract other sheet columns
team_column <- data$Team_Name
year_column <- data$Year

# Read URLs from the Excel sheet
url_data <- read_excel(excel_file, sheet = excel_sheet)
urls <- url_data[[url_column]]

# Function to scrape webpage content
scrape_webpage <- function(url) {
  tryCatch({
    remDr$navigate(url)
    Sys.sleep(5) # wait for JavaScript to load content
    page_source <- remDr$getPageSource()[[1]]
    text <- html_text(read_html(page_source))
    return(text)
  }, error = function(e) {
    cat("Error accessing URL:", url, "\n")
    return(NA)
  })
}

# Initialize corpus with scraped webpages
corpus <- Corpus(VectorSource(sapply(urls, scrape_webpage)))
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stripWhitespace)

# Create Document-Term Matrix
dtm <- DocumentTermMatrix(corpus)
word_freq <- rowSums(as.matrix(dtm))
word_freq_df <- data.frame(word = names(word_freq), freq = word_freq)
top_keywords <- head(word_freq_df[order(word_freq_df$freq, decreasing = TRUE), ], n = 10)

# Create a data frame to store the results
results_df <- data.frame(URL = character(length(urls)),
                         WordCount = integer(length(urls)))

# Loop through the URLs to count keyword hits and word counts
for (i in 1:length(urls)) {
  keyword_hits <- sapply(target_keywords, function(keyword) {
    hits <- sum(grepl(keyword, corpus[[i]]))
    return(ifelse(hits > 0, "Yes", "No"))
  })
  
  total_word_count <- sum(dtm[i, ])
  
  # Store the results in the data frame
  results_df[i, "URL"] <- urls[i]
  results_df[i, "Team Name"] <- team_column[i]
  results_df[i, "Year"] <- year_column[i]
  results_df[i, "WordCount"] <- total_word_count
  
  # Add columns for each keyword
  for (j in 1:length(target_keywords)) {
    keyword <- target_keywords[j]
    keyword_count <- sum(dtm[i, which(colnames(dtm) == keyword)])
    results_df[i, paste0(keyword, " hit")] <- keyword_hits[j]
    results_df[i, paste0(keyword, " count")] <- keyword_count
  }
}

# Write the results to an Excel file
write_xlsx(results_df, "zz-test.xlsx")

# Stop the RSelenium server
remDr$close()
rD$server$stop()

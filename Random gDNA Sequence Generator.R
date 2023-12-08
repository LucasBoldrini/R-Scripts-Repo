# Input DNA sequence
#input_sequence <- "GGNNNNNNNNNNNNNNWNNNNGG"
input_sequence <- "GGACTGACGNNNNNNNWNNNNGG"

# Function to generate all possible combinations for a given DNA sequence
generate_combinations <- function(dna_seq) {
  bases <- c("A", "C", "T", "G")
  new_seq <- list(dna_seq)
  
  # Find positions of N in the sequence and replace with all possible bases
  n_positions <- which(dna_seq == "N")
  for (pos in n_positions) {
    temp_seq <- lapply(new_seq, function(seq) {
      s <- vector("list", length(bases))
      for (i in seq_along(bases)) {
        temp_seq <- seq
        temp_seq[pos] <- bases[i]
        s[[i]] <- temp_seq
      }
      return(s)
    })
    new_seq <- unlist(temp_seq, recursive = FALSE)
  }
  
  # Find positions of W in the sequence and replace with A or T
  w_positions <- which(dna_seq == "W")
  for (pos in w_positions) {
    temp_seq <- lapply(new_seq, function(seq) {
      s <- vector("list", 2)
      for (i in 1:2) {
        temp_seq <- seq
        temp_seq[pos] <- c("A", "T")[i]
        s[[i]] <- temp_seq
      }
      return(s)
    })
    new_seq <- unlist(temp_seq, recursive = FALSE)
  }
  
  return(new_seq)
}

# Generate all possible combinations
all_combinations <- generate_combinations(strsplit(input_sequence, "")[[1]])

# Create a data frame with the sequences
df <- data.frame(Sequence = sapply(all_combinations, paste, collapse = ""))

# Specify the output CSV file path
output_file <- "output_sequences.csv"

# Write the data frame to a CSV file
write.csv(df, file = output_file, row.names = FALSE)

# Print a final message
cat("All possible combinations saved in:", output_file, "\n")

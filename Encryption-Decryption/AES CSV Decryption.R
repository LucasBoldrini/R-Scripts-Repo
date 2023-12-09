library(openssl)

# Read in the encrypted CSV file
encrypted_data <- read.csv("encrypted_file.csv", stringsAsFactors = FALSE)

# Define the encryption key and initialization vector
key <- "your_key"
iv <- "your_iv"

# Loop through each row of the data frame and decrypt the row
for(i in 1:nrow(encrypted_data)) {
  # Get the current row of data
  row_data <- encrypted_data[i,]
  
  # Decrypt the row using AES decryption
  decrypted_row <- openssl::aes_decrypt(row_data, key = key, iv = iv)
  
  # Split the decrypted row back into separate columns
  decrypted_row <- strsplit(decrypted_row, ",")[[1]]
  
  # Replace the encrypted row with the decrypted row
  encrypted_data[i,] <- decrypted_row
}

# Write the decrypted data to a new CSV file
write.csv(encrypted_data, "decrypted_file.csv", row.names = FALSE)

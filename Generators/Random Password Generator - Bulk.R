library("writexl")

# Number of passwords to generate
num_passwords <- 120

# Length of each password
password_length <- 10

# Character set to use for passwords
# charset <- c(letters, LETTERS, 0:9, "!@#$%^&*()_+-=")
charset <- c(0:9)

# Initialize list to store passwords
passwords <- vector("list", num_passwords)

# Generate passwords
for (i in 1:num_passwords) {
  password <- paste0(sample(charset, password_length, replace = TRUE), collapse = "")
  passwords[[i]] <- password
}

# Create a data frame from the passwords list
passwords_df <- data.frame(password = unlist(passwords))

# Write the data frame to an Excel file
write_xlsx(passwords_df, "passwords.xlsx")

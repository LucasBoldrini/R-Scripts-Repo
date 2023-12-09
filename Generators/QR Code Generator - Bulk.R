library(qrcode)
library(readxl)

# Read the Excel file
excel_file <- "C:/Users/lucas/Desktop/Links.xlsx"
sheet_name <- "Sheet1"

data <- read_xlsx(excel_file, sheet = sheet_name)

# Generate QR codes for each link in the Excel sheet
for (i in 1:nrow(data)) {
  link <- as.character(data[i, "Links"])
  file_name <- as.character(data[i, "Names"])
  
  # Generate the QR code
  qr_code <- qr_code(link)
  
  # Save the QR code as a PNG file
  png_file <- paste0(file_name, ".png")
  png(png_file)
  plot(qr_code)
  dev.off()
  
  cat("QR code", i, "generated and saved as", png_file, "\n")
}

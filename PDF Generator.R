library(qrcode)
library(png)

# Function to generate a QR Code and save it as an image
generate_qr_code <- function(data, filename) {
  qr <- qr_code(data)
  png(filename, width = 200, height = 200)
  plot(qr, type = "raw", bg = "white", fg = "black")
  dev.off()
}

# Function to create a styled PDF with personal information, QR Code, and company logo
create_checkin_pdf <- function(name, email, phone, filename, company_logo_filename) {
  # Create the QR Code with personal information
  checkin_info <- paste("Name: ", name, "\nEmail: ", email, "\nPhone: ", phone)
  qr_code_filename <- "qr_code.png"
  generate_qr_code(checkin_info, qr_code_filename)
  
  # Customize page size and margins
  pdf(filename, width = 8, height = 6)
  par(mar = c(2, 2, 2, 2))
  
  # Call plot.new() to initialize the graphics device
  plot.new()
  
  # Add your company logo
  company_logo <- readPNG(company_logo_filename)
  rasterImage(company_logo, xleft = 0, ybottom = 0.9, xright = 0.3, ytop = 1)
  
  # Add a border and background color to the QR Code image
  rect(xleft = 0.4, ybottom = 0.4, xright = 0.6, ytop = 0.6, col = "lightgray")
  
  # Add Check-In Information title
  text(x = 0.5, y = 0.95, labels = "Check-In Information:", font = 2, cex = 1.5, col = "blue", family = "Helvetica")
  
  # Display personal information
  text(x = 0.1, y = 0.8, labels = checkin_info, font = 1, cex = 1.2, col = "black", family = "Helvetica")
  
  # Display a message for scanning the QR Code
  text(x = 0.5, y = 0.65, labels = "Scan QR Code to Check In", font = 1, cex = 1.2, col = "black", family = "Helvetica")
  
  # Add the QR Code image
  img <- readPNG(qr_code_filename)
  rasterImage(img, xleft = 0.4, ybottom = 0.4, xright = 0.6, ytop = 0.6)
  
  dev.off()
  
  # Remove the temporary QR Code image file
  file.remove(qr_code_filename)
}

# Usage example
create_checkin_pdf("John Doe", "john.doe@example.com", "123-456-7890", "checkin.pdf", "company_logo.png")

library(blastula)
library(readxl)

recipient_data <- readxl::read_excel("Mail_Merge.xlsx") # must contain columns "email" and customizable texts (i.e. "name" and "institution")

send_emails <- function(recipient_data) {
  creds <- creds(
    user = "lucas@igem.org",  # For Gmail, turn on 2-step verification and add an app password, which should be used as the log in credentials
    host = "smtp.gmail.com",
    port = 587,
    use_ssl = TRUE
  )
  
  for (i in 1:nrow(recipient_data)) {
    recipient <- recipient_data[i, ]
    email <- compose_email(
      body = md(paste0("Dear ", recipient$name, ",\n\n",
                       "I hope you are well.\n\n",
                       "My name is Lucas. I'm currently working at iGEM, the largest Synthetic Biology competition in the world founded at MIT, and we've recently launched our official Space Initiative.\n\n",
                       "I'd like to know if ", recipient$institution, " would be interested in partnering up to develop the Space Village at our <a href='https://jamboree.igem.org/2023/home'>2024 Grand Jamboree</a> in Paris.\n\n",
                       "Last year, we had around 400 teams from 40+ countries participating and some of these teams worked on projects related to space exploration.\n\n",
                       "We believe Synthetic Biology is crucial for future space missions and without it, humans are unlikely to establish self-sustaining colonies in outer space. With that in mind, we aim at consolidating the Space Village at the Grand Jamboree by having a consistent number of iGEM teams working on space exploration every year. We are closely collaborating with ESA and we are actively looking for additional partners and contributors.\n\n",
                       "I'm looking forward to hearing from you soon!\n\n",
                       "Best wishes,\n\n")),
      footer = md('<div style="position: relative; text-align: left;"><img src="https://static.igem.org/websites/competition/2024/email-signature-nancy.png" alt="Signature" width="300" height="91"></div>')
    )
    
    # Add PDF attachment
     email <- add_attachment(
      email,
      file = "C:/Users/lucas/Desktop/Team Experience Manager/Scripts/2024_Villages_Outline.pdf"
      )
    
    # Send email
    email %>%
      smtp_send(
        from = "lucas@igem.org",
        to = recipient$email,
        subject = paste0(recipient$institution, " at the Space Village at the iGEM Grand Jamboree"),
        credentials = creds,
      )
  }
}

# Send emails to recipients
send_emails(recipient_data)

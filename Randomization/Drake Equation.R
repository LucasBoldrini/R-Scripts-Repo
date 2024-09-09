library(shiny)

# Define UI
ui <- fluidPage(
  titlePanel("Drake Equation Calculator"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("r_star", "Average rate of star formation (R*):", value = 7, min = 0),
      numericInput("f_p", "Fraction of stars with planetary systems (Fp):", value = 0.5, min = 0, max = 1),
      numericInput("n_e", "Average number of planets that could potentially support life (Ne):", value = 2, min = 0),
      numericInput("f_l", "Fraction of those planets that actually develop life (Fl):", value = 1, min = 0, max = 1),
      numericInput("f_i", "Fraction of planets with life that evolve intelligent life (Fi):", value = 0.01, min = 0, max = 1),
      numericInput("f_c", "Fraction of planets with intelligent life that are capable of interstellar communication (Fc):", value = 0.01, min = 0, max = 1),
      numericInput("l", "Number of years a civilization remains detectable (L):", value = 10000, min = 0),
      hr(),
      h4("Result:"),
      textOutput("result")
    ),
    
    mainPanel(
      plotOutput("drake_plot")
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  # Calculate the Drake equation
  drake_equation <- reactive({
    R_star <- input$r_star
    F_p <- input$f_p
    N_e <- input$n_e
    F_l <- input$f_l
    F_i <- input$f_i
    F_c <- input$f_c
    L <- input$l
    
    N <- R_star * F_p * N_e * F_l * F_i * F_c * L
    return(N)
  })
  
  # Render result
  output$result <- renderText({
    N <- drake_equation()
    paste("Estimated number of communicative extraterrestrial civilizations in the Milky Way galaxy:", round(N, 2))
  })
  
  # Plot distribution
  output$drake_plot <- renderPlot({
    invalidateLater(1000, session) # Update every second
    # Generating random data to ensure the plot updates
    data <- rnorm(1000, mean = drake_equation(), sd = 100)
    hist(data, main = "Distribution of N", xlab = "N", col = "skyblue", border = "white")
  })
}

# Run the application
shinyApp(ui = ui, server = server)

library(plotly)
library(readxl)

df <- readxl::read_excel("Total Teams by Year.xlsx")

# Add an ID column
df$ID <- seq.int(nrow(df))

accumulate_by <- function(dat, var) {
  var <- lazyeval::f_eval(var, dat)
  lvls <- plotly:::getLevels(var)
  dats <- lapply(seq_along(lvls), function(x) {
    cbind(dat[var %in% lvls[seq(1, x)], ], frame = lvls[[x]])
  })
  dplyr::bind_rows(dats)
}

df <- df %>% accumulate_by(~ID)

fig <- df %>% plot_ly(
  x = ~Years,  # Use the "Years" column for the x-axis
  y = ~Teams,  # Use the "Teams" column for the y-axis
  frame = ~frame,
  type = 'scatter',
  mode = 'lines',
  fill = 'tozeroy',
  fillcolor='rgba(114, 186, 59, 0.5)',
  line = list(color = 'rgb(114, 186, 59)'),
  text = ~paste("<br>Year: ", ID, "<br>Teams: ", Teams),
  hoverinfo = 'text'
)

fig <- fig %>% layout(
  title = "iGEM Teams Over The Years",
  yaxis = list(
    title = "Teams",
    zeroline = FALSE
  ),
  xaxis = list(
    title = "Years",
    zeroline = FALSE,
    tickmode = 'array',  # Display all years as ticks
    tickvals = ~Years,  # Specify the tick values (Years column)
    ticktext = ~Years,  # Specify the tick labels (Years column)
    tickangle = -45,    # Tilt the tick texts by -45 degrees
    showgrid = TRUE
  )
)

fig <- fig %>% animation_opts(
  frame = 100,
  redraw = FALSE
)

fig <- fig %>% animation_slider(
  currentvalue = list(
    prefix = "Year "
  )
)

fig

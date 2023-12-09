library(plotrix)
library(tidyverse)

#plot

data <- c(18, 36, 33)

pielabels <- c("                      High School (18 - 20.7%)", "Commercial (36 - 41.4%)                      ", "Collegiate (33 - 37.9%)                 ")

plot <- pie3D(data, mar = rep(1, 4),
      col = hcl.colors(length(data), "Blue-Red"),
      labels = pielabels,
      explode = 0.0,
      border = NA)


library(gplots) # needed for heatmap
library(viridis) # needed for heatmap colors

# choice of correlation heatmap. other option: 'pearson'
correlation.method <- 'spearman'

# for each mouse strain:
for (iGEM in c('Heatmap')) { 
  
  # read the CSV file
  data <- read.table(paste(iGEM, '_teams.csv', sep = ''), sep = ',', header = TRUE, check.names = FALSE)
  
  # calculates the pairwise Spearman correlation coefficient between the variables
  correlations <- cor(data, method = correlation.method)
  
  # calculate the p-values associated with the correlation coefficients
  
  # create an empty matrix of 1s, then loop through all combinations of variables to perform correlation test and extract p-values
  p.values <- matrix(1L, nrow = nrow(correlations), ncol = ncol(correlations), dimnames = list(colnames(data), colnames(data)))
  for (variable.1 in 1:ncol(data))
    for (variable.2 in 1:ncol(data))
      p.values[variable.1, variable.2] = cor.test(unlist(data[, variable.1]), unlist(data[, variable.2]), method = correlation.method)$p.value
  
  # replace p-values by corresponding significance level
  p.values <- ifelse(p.values < 0.0001, '****', ifelse(p.values < 0.001, '***', ifelse(p.values < 0.005, '**', ifelse(p.values < 0.05, '*', ''))))
  
  # obtain the labels for the heatmap cells. Combine rounded correlation values with p-value significance levels
  labels <- round(correlations, digits = 2)
  labels <- paste(p.values, labels, sep = '\n')
  labels <- matrix(labels, nrow = nrow(correlations), ncol = ncol(correlations), dimnames = list(rownames(correlations), colnames(correlations)))
  
  # need to remove values in the diagonal since they represent the correlation of each variable with itself. If the matrix becomes non-symmetrical, remove this line of code
  diag(labels) <- NA
  
  # create a PNG file and generate the heatmap with inverted color scale
  png(paste(iGEM, '_teams.png', sep = ''), width = 10, height = 10, res = 300, unit = 'in')
  heatmap.2(correlations, dendrogram = 'none', trace = 'none', col = viridis(100, direction = -1), cellnote = labels, notecex = 1.4, notecol = '#C2FFFF', srtCol = 45, offsetCol = -66, adjCol = c(0, 1), srtRow = 45, offsetRow = -58, adjRow = c(1, 0), key.title = 'Color Key', key.xlab = 'Spearman correlation', Rowv = F, Colv = F, main = paste(iGEM, 'Spearman Correlation'))
  dev.off()
}

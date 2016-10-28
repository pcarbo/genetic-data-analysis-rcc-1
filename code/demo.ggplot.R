# Short R script to check that R graphics and ggplot are working.

# Load the ggplot2 package.
library(ggplot2)

# Generate the data points.
n <- 500
x <- sort(20*runif(n) - 10)
y <- sin(x) + rnorm(n)/10

# Generate the plot using ggplot.
print(ggplot(data.frame(x,y),aes(x = x,y = y)) + 
      geom_point(col = "dodgerblue",cex = 1.5) +
      theme_minimal() +
      theme(panel.grid.major = element_blank(),
            axis.text        = element_text(size = 11)))

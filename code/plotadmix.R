# This function generates an ADMIXTURE plot.
#
# The first input argumnet, dat, must be a data frame with a "pop"
# column containing a factor, and columns K1", "K2", etc. containing
# the estimated admixture proportions.
#
# Input k specifies the ancestral population to plot.
#
plotadmix <- function (dat, k = 1) {

  # Select the columns of the data frame that we will use to generate 
  # the plot.
  dat        <- dat[c("id","pop",paste("K",k,sep=""))]
  names(dat) <- c("id","label","y")

  # Sort the labels by the mean estimated proportion for the selected
  # ancestral population.
  mean.y <- with(dat,tapply(y,label,mean))
  dat    <- transform(dat,label = factor(as.character(label),
              names(sort(mean.y,decreasing = TRUE))))
  
  # Create a box plot using ggplot.
  out <- ggplot(dat,aes(label,y)) +
         geom_boxplot() +
         theme_minimal() +
         scale_y_continuous(limits = c(0,1),breaks = seq(0,1,0.25)) +
         theme(panel.grid.major = element_blank(),
               panel.grid.minor = element_blank(),
               axis.text.x      = element_text(size = 10),
               axis.text.y      = element_text(size = 11),
               axis.title       = element_text(face = "bold",size = 12)) +
         labs(x = "expert-provided population label",
              y = paste("population",k,"admixture prop."))
  
  return(out)
}

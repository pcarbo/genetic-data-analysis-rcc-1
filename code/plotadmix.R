# TO DO: Explain here what this function does.
plotadmix <- function (dat, k = 1) {

  # TO DO: Add comments here.
  dat        <- dat[c("id","pop",paste("K",k,sep=""))]
  names(dat) <- c("id","label","y")
  mean.y     <- with(dat,tapply(y,label,mean))
  dat <- transform(dat,label = factor(as.character(label),
                                      names(sort(mean.y,decreasing = TRUE))))
  
  # TO DO: Add comments here.
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

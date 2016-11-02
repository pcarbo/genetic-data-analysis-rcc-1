# TO DO: Explain what this function does.
plotpca <- function (dat, i = 1, j = 2, dat.more = NULL) {

  # These vectors specify the colours and shapes used to plot the
  # samples on the PC axes.
  clrs   <- rep(c("darkorange","dodgerblue","red","lightskyblue","gold",
                  "yellowgreen","darkviolet","magenta","cyan"),
                each = 3)
  shapes <- rep(c(1,2,4),times = 9)
  
  dat        <- dat[c("id","pop",paste("PC",c(i,j),sep=""))]
  names(dat) <- c("id","label","x","y")

  # TO DO: Add comments here.
  out <- ggplot(dat,aes(x,y,col = label,shape = label)) +
           geom_point(cex = 1.5) +
           scale_color_manual(values = clrs) +
           scale_shape_manual(values = shapes) +
           theme_minimal() +
           theme(panel.grid.major = element_blank(),
                 panel.grid.minor = element_blank(),
                 axis.text        = element_text(size = 12),
                 legend.title     = element_text(face = "italic"),
                 axis.title       = element_text(face = "bold",size = 14)) +
           labs(x = paste("PC",i),y = paste("PC",j))

  # TO DO: Add comments here.
  if (!is.null(dat.more)) {
    dat.more        <- dat.more[c("id","pop",paste("PC",c(i,j),sep=""))]
    names(dat.more) <- c("id","label","x","y")
    out <- out + geom_point(aes(x,y),data = dat.more,col = "black",
                            shape = 20,cex = 2.5) +
                 geom_text(aes(label = label),col = "black",
                           data = dat.more,hjust = "left",nudge_x = 3,
                           size = 3.25)
  }

  return(out)
}

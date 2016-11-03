# This function generates a PCA plot.
#
# The first input argumnet, dat, must be a data frame with a "label"
# column containing a factor, and columns "PC1", "PC2", etc.
#
# Inputs i and j specify the PCs to plot.
#
# The last input argument, dat.more, is another data frame of the same
# form as dat. This is useful if you want to overlay the PCA plot with
# a smaller set of labeled points (set add.labels = TRUE to show the
# labels).
#
plotpca <- function (dat, i = 1, j = 2, dat.more = NULL,
                     add.labels = FALSE) {

  # These vectors specify the colours and shapes used in the plots.
  clrs   <- rep(c("darkorange","dodgerblue","red","lightskyblue","gold",
                  "yellowgreen","darkviolet","magenta","cyan"),
                each = 3)
  shapes <- rep(c(1,2,4),times = 9)

  # Select the columns of the data frame that we will use to generate
  # the plot.
  dat        <- dat[c("id","pop",paste("PC",c(i,j),sep=""))]
  names(dat) <- c("id","label","x","y")

  # Create the ggplot object.
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

  # If an additional data frame is provided, plot the points as
  # before, except that they are all plotted with the same shape and
  # in the same colour, and labels are added next to the points.
  if (!is.null(dat.more)) {

    # Select the columns of the data frame that we will use to generate
    # the plot.
    dat.more        <- dat.more[c("id","pop",paste("PC",c(i,j),sep=""))]
    names(dat.more) <- c("id","label","x","y")

    # Add the additional points to the ggplot.
    out <- out + geom_point(aes(x,y),data = dat.more,col = "black",
                            shape = 20,cex = 2.5)

    # Add the labels.
    if (!add.labels)
      out <- out + geom_text(aes(label = id),col = "black",
                             data = dat.more,hjust = "left",nudge_x = 3,
                             size = 2.5)
    else
      out <- out + geom_text(aes(label = paste(id," (",label,")",sep="")),
                             col = "black",data = dat.more,hjust = "left",
                             nudge_x = 3,size = 2.5)
  }

  return(out)
}

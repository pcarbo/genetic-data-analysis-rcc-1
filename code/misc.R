# Load the expert-provided population labels for the 1000 Genome Phase
# 3 samples from the text file downloaded from the FTP site.
read.1kg.labels <- function (filename) {
  out <- read.table(filename,header = TRUE,as.is = FALSE)
  names(out)[1] <- "id"
  return(out[c("id","pop")])
}

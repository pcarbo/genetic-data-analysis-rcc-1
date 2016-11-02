# Load the expert-provided population labels for the 1000 Genome Phase
# 3 samples from the text file downloaded from the FTP site.
read.1kg.labels <- function (filename) {
  out <- read.table(filename,header = TRUE,as.is = FALSE)
  names(out)[1] <- "id"
  return(out[c("id","pop")])
}

# Read an n x p genotype matrix from a .traw file, where n is the
# number of samples and p is the number of genetic markers (SNPs). See
# http://www.cog-genomics.org/plink2/formats#traw for more information
# about this file format.
#
# This function will be slow for data sets with large numbers of
# genotypes and samples, so use cautiously.
#
read.geno.traw <- function (fam.file, geno.file) {
  ids     <- read.table(fam.file,stringsAsFactors = FALSE)[[1]]
  geno    <- read.table(geno.file,sep = " ",header = TRUE,as.is = "SNP")
  markers <- geno$SNP
  geno    <- t(as.matrix(geno[-(1:6)]))
  rownames(geno) <- ids
  colnames(geno) <- markers
  mode(geno)     <- "double"
  return(geno)
}

# Read a matrix from a space-delimited text file created by
# write_rot_matrix.m.
read.rot.matrix <- function (filename) {
  out <- read.table(filename,sep = " ",header = TRUE,stringsAsFactors = FALSE)
  rownames(out) <- out$marker
  return(as.matrix(out[-1]))
}

# Read the mean genotypes from a space-delimited text file created by
# write_mean_genotypes.m.
read.mean.genotypes <- function (filename) {
  out      <- read.table(filename,sep = " ",header = TRUE,
                         stringsAsFactors = FALSE)
  y        <- out$mean
  names(y) <- out$marker
  return(y)
}

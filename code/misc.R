# Subtract x[i] from column X[,i] for each i. This has the
# interpretation of "centering" the columns of X when y is the vector
# of column means.
center.cols <- function (X, y) {
  n <- length(y)
  for (i in 1:n)
    X[,i] = X[,i] - y[i]
  return(X)
}

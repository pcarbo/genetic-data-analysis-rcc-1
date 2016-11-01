# Computing principal components from genetic data

Commands to compute first 10 PCs:

First we need to convert the genotype data (stored in a PLINK file) to
an n x p matrix, where n is the number of samples and p is the number
of SNPs. We convert the binary PLINK file to a text file ("TRAW"
format) that stores a matrix in which all the entries of the matrix
are 0, 1 or 2.

```bash
module load plink/1.90
plink --bfile 1kg_train --recode A-transpose spacex --out 1kg_train
```

Each line of text file `1kg.traw` stores a column of the matrix, and
each (space-delimited) column of the text file stores a row of the
matrix.

Next, save this text file in a binary format that is convenient for
loading into MATLAB.

```bash
module load matlab/2016a
cd ~/git/genetic-data-analysis-rcc-1/code
matlab -nosplash -nodesktop
```

And in the MATLAB console type the following:

```MATLAB
traw2mat
```

Now that we have the genotype data in a convenient format for MATLAB,
we can perform the computation. This is accomplished using the MATLAB
[geno_pca.m](../code/geno_pca.m) script. In MATLAB, simply enter:

```MATLAB
geno_pca
```

The output from this script should look something like this:

```
(1) Loading genotype matrix from .mat file.
Loaded a 2289 x 156923 matrix.
(2) Centering columns of genotype matrix.
(3) Calculating first 10 PCs.
Computation took 1.41 minutes.
(4) Saving rotation matrix to text file.
(5) Projecting samples onto the principal components.
(6) Saving PCs to text file.
```

*Describe here the two files that were created.*

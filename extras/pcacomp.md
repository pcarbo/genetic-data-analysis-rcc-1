# Computing principal components from genetic data

Commands to compute first 10 PCs:

First we need to convert the genotype data (stored in a PLINK file) to
an n x p matrix, where n is the number of samples and p is the number
of SNPs. We convert the binary PLINK file to a text file ("TRAW"
format) that stores a matrix in which all the entries of the matrix
are 0, 1 or 2.

```bash
module load plink/1.90
plink --bfile 1kg --recode A-transpose spacex --out 1kg
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

```
traw2mat
```

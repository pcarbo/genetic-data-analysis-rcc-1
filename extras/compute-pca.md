# Computing principal components from genetic data

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
(7) Saving mean genotypes to text file.
```

*Describe here the two files that were created.*

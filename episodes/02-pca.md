# Analysis of Genetic Data 1: Exploring structure of genetic data using PCA

This episode is divided into two parts. In the **first part**, we will
observe how genetic polymorphism data---specifically genotype samples
from human subjects---are commonly stored in computer files. We will
also see how these data can be represented as a **matrix**.

In the **second part**, we will explore **principal component analysis**
(PCA), a widely used statistical technique for exposing hidden
patterns of variation from genetic data. In these exercises, we will
discover that these hidden patterns have a close connection to human
history and geography.

For these explorations, we will use genotype data from Phase 3 of the
[1000 Genomes Project](http://dx.doi.org/10.1038/nature15393), an
international scientific effort to comprehensively study global human
genetic variation and create a commmunity resource for genetics
research. These data have been made available to the public
[here](http://www.1000genomes.org/data). To reproduce the steps taken
to retrieve and prepare the 1000 Genomes data for this workshop, see
[here](../extras/1kg.md).

Meaning of population labels: https://catalog.coriell.org/1/NHGRI/About/Guidelines-for-Referring-to-Populations

### Storing genetic data in computer files

Let's start by inspecting the file `1kg_test.ped` which you copied to
the data folder. This file contains the genotype data for 29 samples at
156,923 SNPs.

```bash
cd ~/git/gda1/data
less -S 1kg_test.ped
```

The program `less` is well suited for viewing very large text files
because the file can be viewed without having to read the entire
file. You can scroll up-down and left-right using the arrows.

A line of this file stores the genotype data for a single sample; each
a pair of letters (after the first 6 columns) specifies the genotype
at a given SNP (a nucleotide on each chromosome copy). Some entries
are "0", meaning that the genotype is unavailable.

This file is over 18 MB in size just to store the genotypes for 29
samples. Why is this text file an inefficient way to store genotype
data? How could you store the data more efficiently?

### Representing genetic data as a matrix

How to 

### Computing PCs from genetic data using MATLAB

### Visualizing PCs using R

Convert .bed file to .ped file and inspect the .ped file. How can we
represent this as a matrix?

Start up R:

```bash
cd ~/git/genetic-data-analysis-rcc-1/code
R --no-save
```

In R, these are the steps to plot PCs 1 and 2:

```R
# Load the "plotpca" function and other useful functions.
library(ggplot2)
source("read.data.R")
source("plotpca.R")

# Load the expert-provided population labels.
panel <- read.1kg.labels("../data/omni_samples.20141118.panel")

# Load the genotype samples projected onto the PCs.
pc <- read.pcs("../results/1kg_train_pcs.txt")

# Merge the two tables.
pc <- transform(merge(panel,pc),
                id = as.character(id))

# Optionally, create a new graphics device. (Note: this doesn't work
# in RStudio.)
dev.new(height = 6,width = 8)

# Plot the samples according to their projection onto PCs 1 and 2; the
# colour and shape of the samples are chosen according to the
# expert-provided population labels.
print(plotpca(pc,1,2))
```

Next, try different combinations of PCs (e.g., `print(plotpca(panel,3,4))`).

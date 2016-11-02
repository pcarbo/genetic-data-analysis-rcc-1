# Analysis of Genetic Data 1: Exploring structure of genetic data using PCA

This episode is divided into two parts. In the first part, we will
observe how genetic polymorphism data---specifically genotype samples
from human subjects---are commonly stored in computer files. We will
also see how these data can be represented as a **matrix**.

For these explorations, we will use genotype data from Phase 3 of the
[1000 Genomes Project](http://dx.doi.org/10.1038/nature15393), a
wide-ranging scientific effort to comprehensively study global human
genetic variation and provide a commmunity resource for genetics
research. These data have been made available to the public
[here](http://www.1000genomes.org/data). See [here](../extras/1kg.md)
for the steps taken to retrieve and prepare the 1000 Genomes data for
this workshop.

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

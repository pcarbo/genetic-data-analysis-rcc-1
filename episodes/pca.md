# Analysis of Genetic Data 1: Exploring structure of genetic data using PCA

*Brief introduction to PCA goes here.*

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
source("misc.R")
source("plotpca.R")

# Load the expert-provided population labels.
panel <- read.1kg.labels("../data/omni_samples.20141118.panel")

# Load the genotype samples projected onto the PCs.
pc <- read.pcs("../results/1kg_train_pcs.txt")

# Merge the two tables.
pc <- transform(merge(panel,pc),
                id = as.character(id))


```

Try different combinations of PCs.

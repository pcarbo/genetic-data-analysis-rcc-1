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
library(ggplot2)
source("misc.R")
source("plotpca.R")

# Load the expert-provided population labels.
panel <- read.1kg.labels("../data/omni_samples.20141118.panel")

# Load the genotype samples projected onto the PCs.
pc <- read.pcs("../results/1kg_train_pcs.txt")

# Merge the two tables.
panel <- transform(merge(panel,pc),
                   id = as.character(id))

# Optionally, create a new graphics device. (Note: this doesn't work
# in RStudio.)
dev.new(height = 7.5,width = 9.5)

# Plot the samples according to their projection onto PCs 1 and 2; the
# colour and shape of the samples are chosen according to the
# expert-provided population labels.
print(plotpca(panel,1,2))
```

Next, try different combinations of PCs (e.g., `print(plotpca(panel,3,4))`).

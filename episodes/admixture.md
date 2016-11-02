# Analysis of Genetic Data 1: Exploring genetic data structure using ADMIXTURE

*Brief introduction to ADMIXTURE goes here.*

Commands to run ADMIXTURE on the 1000 Genomes genotype data with K=7
populations (here we use 8 CPUs and set the seed to ensure
reproducibility):

```bash
module load admixture
admixture --seed=1 -j8 1kg_train.bed 7
```

Next replace 7 with 11 to compute structure with K=11 populations.

Since this command takes over 2 hours, we have provided the output in
a local directory (see [Setup](setup.md) for how to obtain these
results on *midway*).

Like we did for the principal components analysis, here we will load
the results from running ADMIXTURE into R, and visualize them in order
to understand and interpret the results.

First, go to the code directory and startup R if you aren't in the R
environment already:

```bash
cd ~/git/genetic-data-analysis-rcc-1
R --no-save
```

In R, these are the steps to show the distribution of admixture
components for a given population (in this example, we examine
population k=1).

```R
# Load the "plotadmix" function and other useful functions.
library(ggplot2)
source("code/read.data.R")
source("code/plotadmix.R")

# Load the expert-provided population labels.
panel <- read.1kg.labels("data/omni_samples.20141118.panel")

# Load the estimated admixture proportions.
admix <- read.admix("data/1kg_train.fam","results/1kg_train.7.Q")

# Merge the two tables.
admix <- transform(merge(panel,admix),
                   id = as.character(id))

# Optionally, create a new graphics device. (Note: this doesn't work
# in RStudio.)
dev.new(height = 4,width = 8)

# TO DO: Add comments here.
print(plotadmix(admix,k = 1))
```

Next, try different ancestral populations (k=2, *etc.*).

*Optional:* Revisit the admnixture results with K=7 populations.

*If I have time, explain how we can predict admixture proportions in
 unseen samples using the -P option in admixture.* This will give the
 users some opportunity to run admixture.

```bash
cd ~/git/gda1/data
cp ../results/1kg_train.7.P 1kg_test.7.P.in
plink --file 1kg_test --make-bed --out 1kg_test
admixture -P 1kg_test.bed 7
cut -d " " -f 1 1kg_test.fam | paste - 1kg_test.7.Q > 1kg_test+ids.7.Q
```

Next, inspect the results by eye.

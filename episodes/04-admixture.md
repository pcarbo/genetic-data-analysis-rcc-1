# Analysis of Genetic Data 1:<br>Exploring genetic data structure using ADMIXTURE

[ADMIXTURE](https://www.genetics.ucla.edu/software/admixture) is a
method, like PCA, that is commonly used to discover latent structure
from a genotype matrix. **However, unlike PCA, ADMIXTURE is based on a
model**: it proposes a (simple) model of genetic transmission, then
adjusts the model parameters to best fit the data. Although the
ADMIXTURE model is most likely too simple to capture the many
complexities of natural populations, an important advantage is that
the ADMIXTURE results are easier to interpret. By contrast, PCA
provides a more flexible statistical analysis that can capture a wide
range of hidden patters, but this flexibility comes at the cost of
making the interpretation more challenging, and therefore
[increases the potential for misinterpretation](http://dx.doi.org/10.1038/ng.139).

### A. Fitting the ADMIXTURE model to genotype data

We start by running ADMIXTURE on the 1000 Genomes genotype data with
K=7 ancestral populations. Here, we use 8 CPUs, and we set the seed to
ensure that the results are reproducible:

```bash
module load admixture
admixture --seed=1 -j8 1kg_train.bed 7
```

In the standard invocation, ADMIXTURE outputs two files: a text file
that ends with .P, and another that ends with .Q. The first text file
gives the allele frequency estimates for each population. These allele
frequency estimates are represented as a p x k matrix, where p is the
number of SNPs, and k is the number of ancestral populations.

The second text file gives the estimated admixture proportions for
each sample. The admixture estimates are represented as an n x k
matrix, where n is the number of samples, and k is the number of
ancestral populations. The numbers in each line (or, equivalently, row
of the matrix) should add up to 1.

:pencil2: Try replacing 7 with 11 to fit the model with K=11 populations.

:pushpin: Since this command takes over 2 hours, we have provided the
output in a local directory (see [Setup](setup.md) for how to obtain
these results on *midway*).

### B. Visualizing estimating admixture proportions in R

Like we did for the PCA results, here we will use R to visualize the
parameters of the ADMIXTURE model that were fit to these data. Note
that while specialized software toolkits (e.g.,
[DISTRUCT](http://web.stanford.edu/group/rosenberglab/index.html))
have been developed for the specific purpose of visualizing population
structure from programs such as
[STRUCTURE](http://pritchardlab.stanford.edu/structure.html) and
ADMIXTURE, we will see that only a few lines of R code are necessary
to develop effective visualizations of these data.

First, startup R if you aren't in the R environment already:

```bash
cd ~/git/gda1
R --no-save
```

In this next code block, we load the ADMIXTURE results into R, similar
to how we loaded the PCA results.

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
admix <- merge(panel,admix)
admix <- transform(admix,id = as.character(id))
```

In R, these are the steps to show the distribution of admixture
components for a given ancestral population (in this example, we
examine population k=1):

```R
# Optionally, create a new graphics device. Note this doesn't work
# in RStudio.
dev.new(height = 4,width = 8)

# Generate a box plot showing the distribution of estimated admixture
# peoportions for population k=1, in which the samples are stratified
# by the expert-provided population labels.
print(plotadmix(admix,k = 1))
```

Try this with different ancestral populations (k=2, *etc.*).

:ledger: How would you characterize each of the 7 ancestral
populations based on these visual summaries of the admixture
proportions?

:ledger: Based on these characterizations, what do the admixture
proportions for specific groups of samples with the same label suggest
about the history of these groups?

:orange_book: How would you explain, broadly speaking, the differences
in the population patterns captured by ADMIXTURE and the patterns
captured by PCA?

:pencil2: Revisit the admixture results with K=11 populations.

### C. Predicting ancestral admixture proportions from genotypes using a global variation reference panel

*Note: This section is a work-in-progress.*

In this exercise, we will use the ADMIXTURE results we generated from
the 1000 Genomes training set to estimate admixture for new genotype
samples (the "test set"). Specifically, we will use the previously
computed allele frequencies stored in the .P file. We will see that
once the hard work of fitting the ADMIXTURE model has already been
accomplished, estimating admixture proportions for new samples is very
fast. This illustrates how we can leverage large genetic data sets to
quickly estimate admixture proportions for any number of new samples.

```bash
cd ~/git/gda1/data
cp ../results/1kg_train.7.P 1kg_test.7.P.in
plink --file 1kg_test --make-bed --out 1kg_test
admixture -P 1kg_test.bed 7
cut -d " " -f 1 1kg_test.fam | paste - 1kg_test.7.Q > 1kg_test+ids.7.Q
```

Although the model fitting, as we mentioned previously, is
computationally intensive, this step should complete in the order of
several seconds or minutes on your laptop.

*Next, inspect the results by eye, perhaps using R.*

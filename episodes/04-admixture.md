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
K=7 populations. Here, we use 8 CPUs, and we set the seed to ensure
that the results are reproducible:

```bash
module load admixture
admixture --seed=1 -j8 1kg_train.bed 7
```

:pencil2: Try replacing 7 with 11 to fit the model with K=11 populations.

**Note:** Since this command takes over 2 hours, we have provided the
output in a local directory (see [Setup](setup.md) for how to obtain
these results on *midway*).

Like we did for PCA, here we will load the results from running
ADMIXTURE into R, and visualize them in order to understand and
interpret the results.

### B. Visualizing estimating admixture proportions in R

Here we will use R to visualize the parameters of the ADMIXTURE model
that were fit to these data. Note that while specialized software
toolkits (e.g.,
[DISTRUCT](http://web.stanford.edu/group/rosenberglab/index.html))
have been developed for the specific purpose of visualizing population
structure from programs such as STRUCTURE and ADMIXTURE, we will see
that only a few lines of R code are necessary to develop effective
visualizations of these data.

First, go to the code directory and startup R if you aren't in the R
environment already:

```bash
cd ~/git/gda1
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

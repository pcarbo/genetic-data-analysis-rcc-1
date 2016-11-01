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

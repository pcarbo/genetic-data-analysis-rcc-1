# Background on the 1000 Genomes genotype data

*Give, very briefly, some background on the 1000 Genomes Project and
the genotype data.*

These are the steps I took to generate the 1000 Genomes data set. Note
that all the data processing was accomplished using PLINK, or using
UNIX command-line tools such as **cut** and **paste** so all these
processing steps were completed very quickly despite the fact that we
are working with very large data sets.

### Retrieving the genotype data.

Download OmniExpress genotype data. This file contains genotypes for
2,401,408 SNPs and 2,318 samples.

```bash
wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/supporting/hd_genotype_chip/ALL.chip.omni_broad_sanger_combined.20140818.snps.genotypes.vcf.gz
mv ALL.chip.omni_broad_sanger_combined.20140818.snps.genotypes.vcf.gz 1kg.vcf.gz
```

Convert from [VCF](http://www.cog-genomics.org/plink2/formats#vcf) to
[binary PLINK](http://www.cog-genomics.org/plink2/input)
(`.bed/.bim/.bam`) format, retaining only SNPs on autosomal
chromosomes 1-22. I also remove any SNPs in which the proportion of
missing genotypes is unusually high (>5%) or the frequency of the minor
allele is less than 1%. *Explain why these filtering steps are taken.*

```bash
module load plink/1.90
plink --vcf 1kg.vcf.gz --make-bed --chr 1-22 --allow-extra-chr \
  --geno 0.05 --maf 0.01 --out 1kg
```

This step removed 315,046 SNPs with too many missing genotypes, and an
additional 281593 SNPs removed with minor allele frequencies less than
1%. *Explain very briefly what the output files are, and point to
PLINK docs for more details.*

Next, retain genotype data only for variants in the dbSNP reference
database (these are SNPs with ids starting with "rs").

```bash
grep rs 1kg.bim | grep -v SNP 1kg.bim | cut -f 2 > markers.txt
plink --bfile 1kg --make-bed --extract markers.txt --out 1kg_new
```

At this point, we have genotype data for 655,388 SNPs and 2,318
samples. Many of the SNPs contain somewhat redundant information
because they are in "linkage disequilibrium" with each other; that is,
they are strongly correlated with each other due to being close to
each other on the same chromosome, and therefore it is rare to have a
recombination event between these two SNPs. In this next step, we
greedily prune out a large fraction of the SNPs to improve computation
time for subsequent analyses while retaining as much information as
possible.

```bash
plink --bfile 1kg --indep-pairwise 1000 500 0.25
plink --bfile 1kg --make-bed --extract plink.prune.in --out 1kg_pruned
```

After this pruning step, we are have genotype data for 156,923 SNPs.

Finally, since closely related samples can have affect our subsequent
analyses in strange ways, for our computations we remove the 29 out of
the 31 genotyped samples that are known to be closely related based on
previous work (see
[here](ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/20140625_related_individuals.txt)).

```bash
tail -n +2 20140625_related_individuals.txt | cut -f 1 > temp.txt
paste temp.txt temp.txt > samples.txt
plink --bfile 1kg_pruned --make-bed --remove samples.txt --out 1kg_train
plink --bfile 1kg_pruned --make-bed --keep samples.txt --out 1kg_test
```

In the end, we have genotype data at 156,923 SNPs on chromosomes 1-22
for 2,289 samples. We add the suffix "train" to the data file to
indicate that is the data set we will use to learn or "train" the
population models. We also save the 29 samples in a separate file with
suffix "test", since we will use these 29 samples later to take a
second look at the models we learned.

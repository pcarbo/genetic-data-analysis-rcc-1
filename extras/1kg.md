# Background on the 1000 Genomes genotype data

These are the steps I took to prepare the 1000 Genomes data for this
workshop. If you do not have access to the data on *midway*, you should
be able to regenerate the data set yourself by following these
steps. (Note the exact steps may be slightly different depending on
your computing setup.)

Since all the data preparation was done using PLINK and UNIX shell
commands, all these steps were completed very quickly despite the fact
that we are working with large amounts of data (hundreds of thousands
of SNPs and thousands of samples).

### Retrieving the genotype data

First, download the 1000 Genomes OmniExpress genotype data. This file
contains genotypes for 2,401,408 single nucleotide polymorphisms
(SNPs) and 2,318 samples.

```bash
wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/supporting/hd_genotype_chip/ALL.chip.omni_broad_sanger_combined.20140818.snps.genotypes.vcf.gz
mv ALL.chip.omni_broad_sanger_combined.20140818.snps.genotypes.vcf.gz 1kg.vcf.gz
```

Next, convert the from
[VCF](http://www.cog-genomics.org/plink2/formats#vcf) to
[binary PLINK](http://www.cog-genomics.org/plink2/input)
(`.bed/.bim/.bam`) format, retaining only SNPs on autosomal
chromosomes 1-22. Also, remove any SNPs in which the proportion of
missing genotypes is unusually high (>5%), or in which the frequency
of the minor allele is less than 1%. These steps are taken to simplify
the analyses of these data, perhaps at the expense of removing some
genetic markers that might expose more subtle patterns in the data.

```bash
module load plink/1.90
plink --vcf 1kg.vcf.gz --make-bed --chr 1-22 --allow-extra-chr \
  --geno 0.05 --maf 0.01 --out 1kg
```

This command removes 315,046 SNPs with too many missing genotypes, and
an additional 281,593 SNPs with minor allele frequencies less than
1%. 

Next, retain genotype data only for the variants in the dbSNP
reference database (these are SNPs with ids starting with "rs"). This
step is mainly taken to make the size of the data set more manageable
for our statistical analyses.

```bash
grep rs 1kg.bim | grep -v SNP 1kg.bim | cut -f 2 > markers.txt
plink --bfile 1kg --make-bed --extract markers.txt --out 1kg_new
```

At this point, we have genotype data for 655,388 SNPs and 2,318
samples. Many of these >600,000 SNPs still contain somewhat redundant
information because they are in "linkage disequilibrium" with each
other; that is, they are correlated due to having experienced
recombination less frequently since they are close to each other on
the same chromosome. In this next step, we greedily prune out a large
portion of the SNPs, again mainly done to improve computation time for
subsequent analyses, while retaining as much information as possible
about the patterns of variation in the sample.

```bash
plink --bfile 1kg_new --indep-pairwise 1000 500 0.25
plink --bfile 1kg_new --make-bed --extract plink.prune.in --out 1kg_pruned
```

After this pruning step, we are left with genotypes for 156,923 SNPs.

Finally, since closely related samples can have affect our subsequent
analyses in strange ways, for our computations we remove the 29 out of
the 31 genotyped samples that are known to be closely related based on
previous work (see
[here](ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/20140625_related_individuals.txt)).

```bash
tail -n +2 20140625_related_individuals.txt | cut -f 1 > temp.txt
paste temp.txt temp.txt > samples.txt
plink --bfile 1kg_pruned --make-bed --remove samples.txt --out 1kg_train
plink --bfile 1kg_pruned --recode --keep samples.txt --out 1kg_test
```

In the end, we have genotype data at 156,923 SNPs on chromosomes 1-22
for 2,289 samples. We add the suffix "train" to the data file to
indicate that is the data set we will use to learn or "train" the
population models. We also save the 29 samples in a separate file with
suffix "test", since we will use these 29 samples later to take a
second look at the models we learned. We have saved the remaining
"test" samples in PLINK's text-based format so we that we can inspect
these files by eye.

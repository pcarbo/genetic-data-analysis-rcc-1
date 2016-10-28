# Background on the 1000 Genomes genotype data

*Give some background here on the 1000 Genomes Project and the data
set.*

These are the steps I took to generate the 1000 Genomes data set.

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
load module plink/1.9beta
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
mv 1kg_new.bed 1kg.bed
mv 1kg_new.bim 1kg.bim
mv 1kg_new.fam 1kg.fam
```

In the end, we have genotype data at 655,388 SNPs for 2,318 samples.

NEXT:
- Remove related samples?
- Remove samples with no population label?

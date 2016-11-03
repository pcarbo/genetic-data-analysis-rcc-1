# Analysis of Genetic Data, Part 1
**Research Computing Center, University of Chicago**<br>
November 2, 2016<br>
2:00 pm - 4:00 pm<br>
**Instructor:** Peter Carbonetto<br>
**Helper:** Will Graybeal

Register [here](http://training.uchicago.edu/course_detail.cfm?course_id=1714).

## General Information

In this 2-hour workshop, participants will apply simple approaches to
investigate and visualize large-scale genetic data sets, with an
emphasis on practical skills that can be applied to genetics
research. This is intended to be a more informal, hands-on workshop,
and no background in genetics is required; anyone with intermediate
computing skills (see "Prerequisites") who is curious about human
genetics and the "genomics revolution" is encouraged to register. Over
the course of the 2 hours, interesting insights will be generated
directly from "raw" genetic data, and participants can continue to
explore the data independently using the techniques introduced in
class.

**Level:** Intermediate

**Prerequistes:** This workshop assumes some experience performing
simple tasks in a UNIX-like shell environment, as well as basic
familiarity with R. Participants must be able to log in to the RCC
compute cluster, although experience using the RCC cluster is not
required. *All participants must bring a laptop with a Mac, Linux, or
Windows operating sytem that they have administrative privileges on.*

**Where:** Kathleen A. Zar Room, John Crerar Library, University of
  Chicago ([OpenStreetMap](https://www.openstreetmap.org/search?query=john%20crerar%20library#map=18/41.79053/-87.60282)).

**Additional info:** This workshop is an attempt to apply elements of
the
[Software Carpentry approach](http://software-carpentry.org/lessons)
(see also
[this article](http://dx.doi.org/10.12688/f1000research.3-62.v2)) to
interactive instruction for computing/quantitative sciences. Some of
the materials contained within are adapted from a
[Stanford workshop](https://github.com/Ancestry/cehg16-workshop) given
in March 2016. For a more in-depth exploration of the concepts and
techniques introduced, see [John Novembre's](http://jnpopgen.org)
[PopGen workshop](https://github.com/NovembreLab/HGDP_PopStruct_Exercise).

Please also take a look at the [Code of Conduct](conduct.md), and the
[Software License](LICENSE) which applies to all the scripts and code
examples in this repository. All instructional material contained in
this repository is made available under the Creative Commons
Attribution license
([CC BY 4.0](https://creativecommons.org/licenses/by/4.0)).

## Aims

1. Explore the application of numeric techniques for investigating
genetic diversity and population structure from large-scale genotype
data.

2. Understand how large genetic data sets are commonly represented in
computer files.

3. Use command-line tools to manipulate genetic data, and use R to
summarize and visualize the results of a genetic data analysis.

4. Practice using the RCC shell environment (*midway*) for large-scale
computation.

## Episodes

| Episode | Concepts |
| --- | --- |
| 1. [Setup](episodes/01-setup.md) | How do I set up my shell environment on *midway* for an analysis of genetic data? |
| 2. [Principal component analysis of genetic data](episodes/02-pca.md) | How do I encode genetic polymorphism data?<br>How do I represent genetic polymorphism data as a matrix?<br>How can I visualie the results of PCA to gain insight into structure of genetic data? |
| 3. [Making predictions using PCA](episodes/03-pca-project.md) | How do I ensure a consistent encoding of the genotype data?<br>How do I map another genetic data set onto an existing PCA result?<br>What does this mapping tell us (and not tell us) about a sample's ancestral origins? |
| 4. [ADMIXTURE analysis of genetic data](episodes/04-admixture.md) | *Add concept 1 here.*<br>*Add concept 2 here.* |

## Extras

[Preparation of the 1000 Genomes genotype data](extras/1kg.md)

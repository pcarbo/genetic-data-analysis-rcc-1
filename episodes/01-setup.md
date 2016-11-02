# Analysis of Genetic Data 1: Setup

This description assumes that you already have a
[user account on midway](http://rcc.uchicago.edu/getting-started/request-account). If
you do not have a *midway* account, please ask the instructor for
access. If you plan to use a different computing resource (e.g.,
another compute cluster, your own laptop), the exact steps described
here, and in subsequent episodes, will be slightly different for you.

We will use
[pair programming](http://dx.doi.org/10.1145/2492007.2492020) in this
workshop. Introduce yourself to your partner and decide between you
who will be the **driver** and who will be the **observer/navigator**.
(Of course, you may alternate these roles throughout the workshop.)

We will use the University of Chicago
[Google Docs](http://gdocs.uchicago.edu) to help make this workshop
more interactive, and encourage discussion. Open up the
[Workshop Google doc](http://tinyurl.com/h8y6p9p) in your Web browser,
and **introduce yourself**.

Log on to midway using ssh with X forwarding:

```bash
ssh -X username@midway.rcc.uchicago.edu
```

+ Request interactive session using reservation for this workshop. I
  suggest using screen in case you lose your connection.

*Add note here about requesting more memory to compute PCs in MATLAB.*

```bash
screen -S workshop-gda1
sinteractive --time=02:45:00 --mem=4G --reservation=workshop-3-nov-2016
```

+ Load the required modules.
  
```bash
module load R/3.2
module load plink/1.90
module load admixture
```
  
+ Optionally, load R Studio. (Rest of workshop will assume that you
  are running R from console, but all the steps should work using R
  Studio as well.)

+ Clone the git repository (note you don't need a github account to do
this):

```bash
mkdir -p ~/git
cd ~/git
git clone https://github.com/pcarbo/genetic-data-analysis-rcc-1.git gda1
```

If you have a github account, please bookmark this repository by
clicking the "Star" button.

+ Copy the data files into the data folder in the github
repo. *Explain how much space these files will take up. Make sure you
have enough storage space in your home directory for these files (use
the `quota` command to check).*

```bash
cd ~/git/gda1/data
cp /project/rcc/workshops/genetic-data-analysis-1/data/* .
```

+ Copy the results files into the results folder in the github repo.

```bash
cd ~/git/genetic-data-analysis-rcc-1/results
cp /project/rcc/workshops/genetic-data-analysis-1/results/* .
```

+ Make sure that you can generate and view graphics in R using
[ggplot](http://ggplot2.org). 

```bash
cd ~/git/genetic-data-analysis-rcc-1/code
R --no-save
```

and then in R enter

```R
source("demo.ggplot.R")
```

If this is not working on your computer, and alternative (for midway
cluster only) is [ThinLinc](add-url-here).


# Analysis of Genetic Data 1: Setup

This description assumes that you have already registered for a
[user account on
midway](http://rcc.uchicago.edu/getting-started/request-account). If
you do not have an account, or if you plan to use a different
computing resource (e.g., your own computer), these steps will be
slightly different for you.

+ We will use
  [pair programming](http://dx.doi.org/10.1145/2492007.2492020) in
  this workshop. Introduce yourself to your partner and decide between
  you who will be the **driver** and who will be the
  **observer/navigator**.

+ We will use the University of Chicago
  [Google Docs](http://gdocs.uchicago.edu) to help make this workshop
  more interactive, and encourage discussion. Open up the
  [Google doc](http://tinyurl.com/h8y6p9p) in your Web browser, and
  introduce yourself.

+ Log on to midway using ssh with X forwarding:
  `ssh -X username@midway.rcc.uchicago.edu`.

+ Request interactive session using reservation for this workshop. I
  suggest using screen in case you lose your connection.

+ Load the required modules.
  
```bash
module load R/3.2
```
  
+ Optionally, load R Studio.

+ Clone the git repository (note you don't need a github account to do
  this).

+ Copy the data files into the data folder in the github repo.

+ Make sure that you can generate and view graphics in R using
  [ggplot](http://ggplot2.org).

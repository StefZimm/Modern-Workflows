# **Modern Workflow in Data Science**

**Description of the project:** 

This repository will be used for the IPSDS course Modern Workflow in Data Science. 
In the project assignment 1 the infection rate worldwide will be examined with the help of 
corona data from [github](https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data). 
Three different illustrations will be created and presented in the project: 

1. Overall change in time of log number of cases
2. Change in time of log number of cases by country 
3. Change in time by country of rate of infection per 100,000 cases

**Organization of the project:** 

The project (assignment 1) is divided into the three main folders input, output and scripts. 

- input: The input folder in the subfolder raw contains the stored raw data with current timestamp. 
These raw data do not have to be downloaded manually but are automatically stored there when using 
the scripts. The raw data (.csv) is not pushed by the gitignore file on the top level, 
but the different time stamps are kept locally and can be reconstructed. 
- scripts: The scripts folder contains the two R-files PREP.R and ANALYZE.R. 
´PREP.R downloads the current data from: [github](https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data), 
merges datasets, cleans and harmonize, reshapes and saves it. ANALYZE.R uses the generated datasets from PREP.R 
and creates three graphics for the project report.
- output: The output folder contains the two subfolders data and png. The output/data directory contains the clean 
data at the time of running the data preparation script (PREP.R). The output/data is provided with a time stamp 
to document possible changes/updates and to retrieve old versions of the data but cannot be pushed to github because
.csv format is not allowed. The files without a timestamp is the current data and is then used in the ANALYZE.R script.

**Steps to start the project:**  

1. Create the folder environment explained in "Organization of the project" 
or clone the git repo using git with the command:
    - git clone https://github.com/StefZimm/Modern-Workflows.git
2. Go to "assignment_1/scripts subfolder".
3. Open the PREP.R file and set your paths:
    - rawdir <- "C:/clone/Modern Workflows/assignment_1/input/raw/"
    - outdir <- "C:/clone/Modern Workflows/assignment_1/output/data/"
4. Run the PREP.R file and you should get some local datasets in "assignment_1/output/data/"
5. Open the ANALYZE.R file and set your paths:
    - datadir <- "C:/clone/Modern Workflows/assignment_1/output/data/"
    - graphdir <- "C:/clone/Modern Workflows/assignment_1/output/png/"
6. Run the ANALYZE.R file and you should get three graphics in "assignment_1/output/png/"
7. Now you can write your report. 

**Main findings of the project:** 

![](assignment_1/output/png/total_global.png)
The graph shows the log total number of corona cases worldwide. We see an increase in the number of cases over the time period until June. The increase in the log total number of corona cases is becoming progressively smaller and flattens out. 

![](assignment_1/output/png/total_country.png)
In this graph we again see the log total number of corona cases by country. Certain countries are highlighted in colour. In Italy, for example, we see how much the numbers increased at the end of February, while South Africa and Russia increased much later. 

![](assignment_1/output/png/total_country_rate.png)
The last graph shows the rate of infection per 100,000 cases. Here we can see, for example, that South Africa has felt little impact of the corona crisis compared to the other countries. Germany seems to have coped well with the corona crisis compared to many other countries. The rate of infection per 100,000 cases is significantly lower than in the other countries highlighted. 

---------------------------------------------------------------------------------------------------------
**Session infos**

| setting  | value                        |
|----------|------------------------------|
| version  | R version 3.6.3 (2020-02-29) |
| os       | Windows 10 x64               |
| system   | x86_64, mingw32              |
| ui       | RStudio                      |
| language | EN                           |
| collate  | German_Germany.1252          |
| ctype    | German_Germany.1252          |
| tz       | Europe/Berlin                |
| date     | 2020-06-10                   |               

-------------------------------------------------------------------------------------------------------------
**Package Infos** 

| package    | version | date and lib source           |   
|------------|---------|-------------------------------|
| assertthat | 0.2.1   | 2019-03-21 [1] CRAN (R 3.6.3) |
| cli        | 2.0.2   | 2020-02-28 [1] CRAN (R 3.6.3) |
| crayon     | 1.3.4   | 2017-09-16 [1] CRAN (R 3.6.3) |
| dplyr      | 0.8.5   | 2020-03-07 [1] CRAN (R 3.6.3) |
| ellipsis   | 0.3.0   | 2019-09-20 [1] CRAN (R 3.6.3) |
| fansi      | 0.4.1   | 2020-01-08 [1] CRAN (R 3.6.3) |
| glue       | 1.3.2   | 2020-03-12 [1] CRAN (R 3.6.3) |
| hms        | 0.5.3   | 2020-01-08 [1] CRAN (R 3.6.3) |
| knitr      | 1.28    | 2020-02-06 [1] CRAN (R 3.6.3) |
| lifecycle  | 0.2.0   | 2020-03-06 [1] CRAN (R 3.6.3) |
| magrittr   | 1.5     | 2014-11-22 [1] CRAN (R 3.6.3) |
| pillar     | 1.4.3   | 2019-12-20 [1] CRAN (R 3.6.3) |
| pkgconfig  | 2.0.3   | 2019-09-22 [1] CRAN (R 3.6.3) |
| purrr      | 0.3.3   | 2019-10-18 [1] CRAN (R 3.6.3) |
| R6         | 2.4.1   | 2019-11-12 [1] CRAN (R 3.6.3) |
| Rcpp       | 1.0.4   | 2020-03-17 [1] CRAN (R 3.6.3) |
| readr      | 1.3.1   | 2018-12-21 [1] CRAN (R 3.6.3) |
| rlang      | 0.4.5   | 2020-03-01 [1] CRAN (R 3.6.3) |
| rstudioapi | 0.11    | 2020-02-07 [1] CRAN (R 3.6.3) | 
| tibble     | 3.0.0   | 2020-03-30 [1] CRAN (R 3.6.3) |
| tidyr      | 1.0.2   | 2020-01-24 [1] CRAN (R 3.6.3) |
| tidyselect | 1.0.0   | 2020-01-27 [1] CRAN (R 3.6.3) |
| vctrs      | 0.2.4   | 2020-03-10 [1] CRAN (R 3.6.3) |
| withr      | 2.1.2   | 2018-03-15 [1] CRAN (R 3.6.3) |
| xfun       | 0.12    | 2020-01-13 [1] CRAN (R 3.6.3) |

[1] C:/Users/Stefan/Documents/R/R-3.6.3/library



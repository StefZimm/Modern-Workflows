# **Modern Workflow in Data Science**

**Description of Project Assignment 1:** 

This repository will be used for the IPSDS course Modern Workflow in Data Science. 
In the project assignment 1 the infection rate worldwide will be examined with the help of 
corona data from [github](https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data). 
Three different illustrations will be created and presented in the project: 

1. Overall change in time of log number of cases
2. Change in time of log number of cases by country 
3. Change in time by country of rate of infection per 100,000 cases

- Introduction
- Data Preparation
- Summary Statistics
- Descriptive Statistics
- Two Regression models

**Organization of Project Assignment 1:** 

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


**Steps to start the Project Assignment 1:**   

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

**Description of Project Assignment 2:** 

This project uses data from the [European Value Study (EVS)](https://search.gesis.org/research_data/ZA7500) and 
aims to examine attitudes towards gender roles and immigration for European countries. In the project report 
two variables on gender role and migration are descriptively examined and a first OLS regression is created. 
The project report will not only provide first results for Europe, but also additional individual reports for 
each country of the EVS, which will help to identify possible differences within the EU. The reports of this 
project include:

- Introduction
- Data Preparation
- Summary Statistics
- Descriptive Statistics
- Two Regression models

**Organization of the project Assignment 2:** 

The project (assignment 2) is divided into the three main folders input, output and scripts. 

- input: The input folder in the subfolder unzip contains the SPSS datasets in .zip format from the
[European Value Study (EVS)](https://search.gesis.org/research_data/ZA7500). Raw contains the stored 
raw data in .sav format. These raw data do not have to be unziped manually but will be automatically 
unziped and stored there when using the scripts. The raw data is not pushed by the gitignore file on the top level. 
- scripts: The scripts folder contains the R-file EVS_country_report and three rmarkdown files. 
ESS_country_report.R unzip the SPSS data from [European Value Study (EVS)](https://search.gesis.org/research_data/ZA7500), 
cleans it and saves it. Moreover the script starts the three markdown scripts to create the reports as html files.
The rmarkdown Files create the analysis for Europe for policy makers and statisticians. And the EVS_report_Stefan_Zimmermann.Rmd
File is the main File to generate an report for each country. 
- output: The output folder contains the one subfolders country_reports. The output/country_reports directory contains the 
individual country reports. On the top-level are the reports for policy makers and statisticians.

**Steps to start the project Assignment 2:**  

1. Create the folder environment explained in "Organization of the project" 
or clone the git repo using git with the command:
    - git clone https://github.com/StefZimm/Modern-Workflows.git
2. Download the SPSS Data from [European Value Study (EVS)](https://search.gesis.org/research_data/ZA7500)
3. Go to "assignment_2/scripts subfolder".
4. Open the EVS_country_report.R file and set your paths
5. Run the EVS_country_report.R file and you should get your reports in the output folder

**Description of Project Assignment 3:** 

This project is an analytical notebook for the IPSDS course Modern Workflow in Data Science. 
In the project assignment 3 the number of Corona cases and the infection rate of specific will be examined and explained with the help of 
corona data from [github](https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data). 
The analyitical notebook should create two illustrations and one linear model: 

1. Overall change of number of Corona Cases
2. Overall change of infection rate in percent 
3. A ml_linear_regression explaining the log of number of Corona cases

To write this report we have to set-up RStudio server on Amazon Web Services (AWS) and use Spark there. 
Instructions for setting up a Rstudio server with AWS can be found [here](https://towardsdatascience.com/how-to-run-rstudio-on-aws-in-under-3-minutes-for-free-65f8d0b6ccda). 

**Organization of the project Assignment 3:** 

The project (assignment 3) is divided into the three main folders input, output and scripts. 

- input: The input folder contains the prepared and saved data of [github](https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data)  The raw data is not pushed by the gitignore file on the top level. 
- scripts: The scripts folder contains the R-file Analytical_Notbook_Stefan_Zimmermann.r and the rmarkdown file Analytical_Notbook_Stefan_Zimmermann.rmd.
The R-Script installs, sets up the spark connection and renders the R-Markdown report. 
- output: The output folder contains the analytical report as latex and pdf file. Moreover the folder contains 
the two graphics. 

**Steps to start the project Assignment 3:**  

1. Create the folder environment explained in "Organization of the project" 
or clone the git repo using git with the command:
    - git clone https://github.com/StefZimm/Modern-Workflows.git
2. Go to "assignment_3/scripts subfolder".
3. Open the Analytical_Notbook_Stefan_Zimmermann.r and start the script.
4. You should get your analytical notebook in the output folder.

**Description of Project Assignment 4:** 

The Assignment 4 folder contains the code for a Shiny App, which is intended to provide small descriptive 
analyses of the [WVS (World Value Study data)](http://www.worldvaluessurvey.org/WVSDocumentationWV6.jsp) on 
the topics of democracy in the country, news consumption and attitudes towards science. 

**Organization of the project Assignment 4:** 

The project (assignment 4) is divided into the two main folders input and scripts. 

- input: The input/raw folder contains the downloaded spss data from [WVS](http://www.worldvaluessurvey.org/WVSDocumentationWV6.jsp) as a zip file.
The raw data in input/unzip is unpacked and not pushed by the gitignore file on the top level.
- scripts: The scripts folder contains the R-file PREP.r and the R-file Dashboard.R.
The R-Script unzips and prepares the datasets. The Dashboard.R builds the shiny app. 

**Steps to start the project Assignment 3:**  

1. Create the folder environment explained in "Organization of the project" 
or clone the git repo using git with the command:
    - git clone https://github.com/StefZimm/Modern-Workflows.git
2. Go to "assignment_4/scripts subfolder".
3. Open the PREP.r, set your working directory and start the script.
4. Open the Dashboard.r and start the script to create the app.



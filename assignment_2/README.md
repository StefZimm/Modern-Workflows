# **Modern Workflow in Data Science**

**Description of the project:** 

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

**Organization of the project:** 

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

**Steps to start the project:**  

1. Create the folder environment explained in "Organization of the project" 
or clone the git repo using git with the command:
    - git clone https://github.com/StefZimm/Modern-Workflows.git
2. Download the SPSS Data from (EVS)](https://search.gesis.org/research_data/ZA7500)
3. Go to "assignment_2/scripts subfolder".
4. Open the EVS_country_report.R file and set your paths
5. Run the EVS_country_report.R file and you should get your reports in the output folder



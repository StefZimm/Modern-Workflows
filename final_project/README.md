**Description of Project Final Assignment:** 

The Assignment 4 folder contains the code for a Shiny App, which is intended to provide small descriptive 
analyses and a regression of the [European Value Study (EVS) dataset](https://search.gesis.org/research_data/ZA7500). 
Additionally the Shiny App creates a downloadable dynamic report.

**Organization of the project Final Assignment:** 

The project (assignment 4) is divided into the three main folders input, output and scripts. 

- input: The input/raw folder contains the downloaded spss data from [European Value Study (EVS)](https://search.gesis.org/research_data/ZA7500) as a zip file.
The raw data in input/unzip is unpacked and not pushed by the gitignore file on the top level.
- scripts: The scripts folder contains the R-file PREP.r and the R-file Dashboard.R.
The R-Script unzips and prepares the datasets. The Dashboard.R builds the shiny app. 
- output: The output folder contains the report.Rmd which creates a downloadable document. 

**Steps to start the project Final Assignment:**  

1. Create the folder environment explained in "Organization of the project" 
or clone the git repo using git with the command:
    - git clone https://github.com/StefZimm/Modern-Workflows.git
2. Download the zipped SPSS Data from [European Value Study (EVS)](https://search.gesis.org/research_data/ZA7500) and save it in final_project/input/raw
3. Go to "final_project/scripts subfolder".
4. Open the PREP.r, set your working directory and start the script.
5. Open the Dashboard.r and start the script to create the app.
6. Click the Download Button in the shiny app to create a dynamic report. 


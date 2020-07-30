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
2. Download the zipped SPSS Data from [WVS (World Value Study data)](http://www.worldvaluessurvey.org/WVSDocumentationWV6.jsp) and save it in assignment_4/input/raw
3. Go to "assignment_4/scripts subfolder".
4. Open the PREP.r, set your working directory and start the script.
5. Open the Dashboard.r and start the script to create the app.


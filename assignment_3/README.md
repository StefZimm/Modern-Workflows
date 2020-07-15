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


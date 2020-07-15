install.packages("sparklyr")
library(sparklyr)
spark_install()

rmarkdown::render('assignment_3/scripts/Analytical_Notebook_Stefan_Zimmermann.Rmd', 
                  output_file = '../output/Analytical_Notebook_Stefan_Zimmermann.pdf')

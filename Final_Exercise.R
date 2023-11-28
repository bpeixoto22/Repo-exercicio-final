###############################################
#                                             #
# FINAL EXERCISE                              #
# Putting it all together                     #
#                                             #
###############################################

# 0. Create an Project with version control

feito: 
  ir ao github, criar repo, ir buscar o link
  abrir RStudio, novo projeto > track changes > colar o link (clonou)
  
  
  
# 1. Get data from INE with ineptR (Check the shared files, already cleaned somewhat)
  
dois datasets rds partilhados no discord, guardei na pasta


# 2. Make additional processing to the dataset

library("tidyverse")
view(mort_pt)
distinct(mort_pt, sex)  #HM
distinct(pop_pt, sex)   #H, M e HM

summary(mort_pt)



# 3. Join datasets as needed
# 4. Make calculations you think are relevant (e.g. Death rates, % of deaths, ...)
# 5. Make 2 or more summary tables with your main results
# 6. Make 2 or more plots with your main results
# 7. Make 1 or more statistical models with your main results
# 8. Create a Quarto report with your results
# 9. Publish to GitHub using GitHub Pages



# 1. Data importation, after an initial processing
## Files will be shared and your path may be different. Adjust as needed.
mortality <- rio::import("data/mort_pt.rds")
population <- rio::import("data/pop_pt.rds")


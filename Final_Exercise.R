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
library("dplyr")
library("crosstable")
view(mort_pt)
view(pop_pt)

#primeiro, vamos ver se as variáveis são do tipo que faz sentido:
glimpse(mort_pt)
glimpse(pop_pt)

colnames(pop_pt) #variaveis/colunas que tem
colnames(mort_pt)

#para termos uma ideia melhor dos valores de sex:
distinct(mort_pt, sex)  #HM
distinct(pop_pt, sex)   #H, M e HM

#para termos uma ideia de todas as variáveis
crosstable(mort_pt,
           cols=-"deaths") %>% 
  as_flextable()


#por uma questão de NUTS vou s

###Vamos tratar da pop_pt:

#primeiro, vamos ver se as variáveis são do tipo que faz sentido:
glimpse(pop_pt)
#concluimos que o ano e a população, que deviam ser números, são char. vamos mudar:
pop_limpa <- pop_pt %>%  
  mutate(year = as.integer(year), 
         pop = as.integer(pop))

glimpse(pop_limpa) #yey direitinho

#agora vamos ver os valores tomados pelas variáveis
#maneira fixe de fazer isto é com crosstables (as_flextables para ser mais facil ver)
#agora a crosstable lista os distincts, e no caso dos integers faz resumo é fixe:
crosstable(pop_limpa) %>% 
  as_flextable()

#por causa da confusão dos NUTS, só quero anos a partir de 2015 (tem 91-22) 
#também só quero observações com sexo HM 
#(temos dados H, M, HM, mas não temos mortalidade para H e para M, portanto só quero HM)
#e só quero dados das REGIOUES, portanto vou optar por geocode de lenght = 3
#se quisesse freguesias, optava por geocode lenght = 7

pop_limpa <- pop_limpa %>%   
  filter(year >2014) %>% 
  filter(sex=="HM") %>% 
  filter(str_length(geo_cod)==3)

#Ok, agora limpar o mesmo mas para mort_pt
glimpse(mort_pt) #para ver tipo de variaveis
mort_limpa <-  mort_pt %>% 
  mutate(year = as.integer(year),
         deaths = as.integer(deaths))

crosstable(mort_limpa) %>% as_flextable()

mort_limpa <- mort_limpa %>%   
  filter(year >2014) %>% 
  filter(str_length(geo_cod)==3)

# 3. Join datasets as needed

unir <- left_join(pop_limpa,
          mort_limpa,
          by=c("year","geo_cod","sex","geo_name")) #isto é tudo o que têm em comum, manter numa unica coluna

unir <- unir %>% 
  select(-c(sex, death_cause, na_reason)) #vamos tirar as colunas que não interessam

# 4. Make calculations you think are relevant (e.g. Death rates, % of deaths, ...)

unir <- 
  unir %>% 
  mutate(TBM = deaths / pop *10E5) #criar variavel taxa bruta mortalidade

# 5. Make 2 or more summary tables with your main results
  
crosstable(unir) %>% as_flextable()
  
# 6. Make 2 or more plots with your main results
# 7. Make 1 or more statistical models with your main results
# 8. Create a Quarto report with your results
# 9. Publish to GitHub using GitHub Pages



# 1. Data importation, after an initial processing
## Files will be shared and your path may be different. Adjust as needed.
mortality <- rio::import("data/mort_pt.rds")
population <- rio::import("data/pop_pt.rds")


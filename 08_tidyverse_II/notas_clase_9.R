library(dbplyr)

# con <- DBI::dbConnect(RSQ::)

# Convierto iris en tiblle:

iris <- tibble(iris)

# Agrupo por "Species"

iris_2 <- iris %>% group_by(Species)

# Conteo de observaciones por grupo

iris_2 %>% summarise(Conteo = n())

# Distintos por grupo:
tibble(mtcars) %>% 
  group_by(cyl) %>% 
  summarise(Distintos = n_distinct(carb))

# Conteo de casos por grupo:
tibble(mtcars) %>% 
  group_by(cyl) %>% 
  summarise(Distintos = n()) 



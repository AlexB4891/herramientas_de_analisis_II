# Libreria:
library(tidyverse)

# Lectura de la tabla:

tabla <- read_csv("07_tidyverse/saiku-export.csv") %>% 
  as_tibble

glimpse(tabla)

names(tabla) <- c("activ","provin","tipo_c","grupo_e",
                  "gran_c","clase","anio","mes","estado",
                  "compras_t","ventas_t","impuesto_c")


# Extraigo varaibles deseadas:

select(.data = tabla,activ,anio,mes,ventas_t)

select(.data = tabla,activ,"anio","mes","ventas_t")

select(.data = tabla,activ,c(1,2,3))

# Saco variables:

select(.data = tabla,-compras_t)

# pipe: %>% 

temporal <- tabla %>% 
  select(.,activ,anio,mes,estado,ventas_t) %>% 
  group_by(activ,anio,estado) %>% 
  summarise(ventas_t = sum(ventas_t)) %>% 
  ungroup %>% 
  mutate(var = str_c(anio,estado,sep="_")) %>% 
  spread(var,ventas_t) 


# Auxiliares

select(tabla,provin:anio)

select(tabla,-c(provin,anio))

  
# Comienza con:
select(temporal,starts_with("2015"))


# Termina con:
select(temporal,ends_with("ACTIVO"))

# Contiene:
select(tabla,contains("ru"))

# Expresión: Sacar las columnas cuyo nombre tenga 4 digitos
select(tabla,matches("^.{5}$"))

# Una de:
select(tabla,one_of(c("Anio","año","anio")))


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

ind <- sample(1:nrow(tabla),30)

tabla$ventas_t[ind] <- NA_real_

filter(tabla,is.na(ventas_t))
# Negación:
filter(tabla,!is.na(ventas_t))


# Con textos:
# ^S siginifa "comienza con"

ind <- grepl(x = tabla$provin,pattern = "^S")

f_tabla <- filter(tabla,ind) 

table(f_tabla$provin)


# Varias condiciones:

filter(tabla, 
       activ == "A", 
       anio == 2016) 

# Uso del "o |"
filter(tabla, 
       provin == "CHIMBORAZO",
       mes == 4 | mes == 5, 
       anio == 2016,
       ventas_t >= 20e6) 

# Uso del "%in%"
filter(tabla, provin == "CHIMBORAZO",
       mes %in% c(4, 5),
       anio == 2016,
       ventas_t >= 20e6)

# Prueba 2: ---------------------------------------------------------------

prueba_2 <- tabla %>% filter(estado == "ACTIVO",
                 grupo_e == "SI",
                 mes %in% c(1:6),
                 anio == 2015)



min(prueba_2$ventas_t)

max(prueba_2$ventas_t)

# Orden 
prueba_2 %>% 
  arrange(ventas_t)

prueba_2 %>% 
  arrange(desc(compras_t))


# Yo quiero un ranking de ventas de aquellos provincias que tengan compras
# mayores a 5e6 en el 2016

tabla %>% 
  select(anio,mes,provin,ventas_t,compras_t) %>% 
  filter(compras_t > 500e6,
         anio == 2016) %>% 
  arrange(desc(ventas_t))


# Justificacion del uso de la pipe:

# select(filter(arrange(tabla,desc(ventas_t)),compras_t > 500e6,
#        anio == 2016))

tabla1 <- select(tabla,anio,mes,provin,ventas_t,compras_t)

tabla2 <- filter(tabla1,compras_t > 500e6,
                 anio == 2016)

tabla3 <- arrange(tabla2,desc(ventas_t))


# librerias ---------------------------------------------------------------

library(tidyverse)
library(lubridate)


# modificacion del aspecto del grasfico -----------------------------------

datos_sim <- tibble(
  id = sample(str_c("ID-",1:100),1000,replace = T),
  anio = sample(1936:1970,1000,replace = T),
  mes = sample(1:12,1000,replace = T),
  dia = sample(1:31,1000,replace = T),
  sexo = sample(c("Mujer","Hombre"),1000,replace = T),
  g_edad = sample(c("Joven","Adulto","Anciano"),1000,replace = T),
  valor = rpois(1000,300),
  ahorro = rpois(1000,100)
)


datos_sim %>% 
  ggplot() + 
  geom_point(aes(x = valor, 
                 y = ahorro,
                 color = "blue"),
             size = 1,
             shape = 1,
             alpha = 0.7,
             show.legend = T) 

# Creamos el modelo:

modelo <- loess(data = datos_sim,formula = ahorro ~ valor)

# Prediccion para nuevas observaciones

predict(modelo, newdata = data.frame(valor = c(256,300)), se = TRUE)

# generar una variable de ahorro que siga una curva ajusta: ---------------

# El eror de estimacion:

error  <- rnorm(nrow(datos_sim),5,2)

datos_sim <- datos_sim %>% 
  mutate(ahorro_2 = 150 + 0.1*valor + error)

# El valor de150  es el promedio de ahorro `fijo` + 10% del ahorro respecto a las compras
# más un error de medicion

modelo_lm <- lm(data = datos_sim,formula = ahorro_2 ~ valor)

resumen_modelo <- summary(modelo_lm)



# Quiero predecir cual va a ser el ahorro de una persona cuyo valor de compras sea:
# 600 dolares y otra que tenga 10

 predicho <- predict(modelo_lm,newdata = data.frame(valor = c(600,10,250,300,450)))

 tabla_pred <- tibble(valor = c(600,10,250,300,450),
                      ahorro_2 = predicho,
                      tipo = "prediccion"
                      )
 
 tabla_grafico0 <- datos_sim %>% 
   select(valor,ahorro_2) %>% 
   mutate(tipo = "original")
 
 # Juntar dos tablas:
 
 tabla_grafico <- bind_rows(tabla_grafico0,tabla_pred)
 
 
 tabla_grafico %>% 
group_by(tipo) %>% 
   summarise(n = n())
 
 # Grafico con la curva de ajuste
 
  datos_sim %>% 
    ggplot() + 
    geom_point(aes(x = valor, 
                   y = ahorro_2,
                   color = "blue"),
               size = 1,
               shape = 1,
               alpha = 0.7,
               show.legend = T)  +
  geom_smooth(
    aes(x = valor,
        y = ahorro_2),
    color = "blue",
    show.legend = T,formula = y~x,method = "lm")
  
  
  # Grafico con las predicciones
  
  # elementos para los titulos:
  coeficientes <- coefficients(resumen_modelo)[,1]
  
  coeficientes <- round(coeficientes,2)
  
  r2 <- round(resumen_modelo$r.squared,2)
  
  # creacion de la formula para el grafico
  
  formula <- str_c("ahorro = ",coeficientes[1]," + ",coeficientes[2],"*valor ; R^2: ",r2)
  
  tabla_grafico %>% 
    ggplot() + 
    geom_point(aes(x = valor, 
                   y = ahorro_2,
                   color = tipo),
               size = 2,
               show.legend = T) +
    geom_smooth(
      data = tabla_grafico0,
      aes(x = valor,
          y = ahorro_2),
      color = "blue",
      show.legend = F,formula = y~x,method = "lm") +
    labs(title  = "Relación del Ahorro vs Valor de Compras",
         subtitle = formula,
         y = "Ahorro",
         x = "Compras",
         color = "Tipo")
  
  

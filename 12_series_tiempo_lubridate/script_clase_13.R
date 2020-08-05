
# librerias ---------------------------------------------------------------

library(tidyverse)
library(lubridate)


# Datos simulados ---------------------------------------------------------


set.seed(1984)
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


# Generacion de fechas ----------------------------------------------------



datos_sim <- datos_sim %>% 
  mutate(fecha_1 = str_c(anio,mes,dia),
         fecha_2 = str_c(anio,"-",mes,"-",dia ),
         fecha_3 = str_c(mes,"/",dia,"/",anio ),
         fecha_4 = str_c(dia,"/",mes,"/",anio ),
         fecha_definitiva = ymd(fecha_2)
         )


ymd(datos_sim$fecha_2)

# Fecha que noe existe:
datos_sim$fecha_2[132]


mdy(datos_sim$fecha_3)

dmy(datos_sim$fecha_4)


# grafico de series de tiempo:
# la función summarise_at, me permite pasar los nombres de las columnas
# que quiero resumir, en este caso sumar

resumen_series <- datos_sim %>% 
  group_by(fecha_definitiva) %>% 
  summarise_at(.vars = c("valor","ahorro"),         # nombres de las columnas
               .funs = list(~sum(.,na.rm = T)))  %>%    #operacion por grupos
  ungroup  
  

# la series tienen valores atipicos, por ende vamos a reemplazar con la media, a aquellos
# qeu esten por encima del percentil 90

quantile(rnorm(100),probs = 0.9) # Hasta que numero esta acumulado el 90% de los datos

q_val <- quantile(resumen_series$valor,probs = 0.9)

q_aho <- quantile(resumen_series$ahorro,probs = 0.9)

resumen_series_2 <- resumen_series %>% 
  mutate(
    valor = as.numeric(valor),
    ahorro = as.numeric(ahorro),
    valor_2 = if_else(valor > q_val, mean(valor), valor),
    ahorro_2 = if_else(ahorro > q_aho, mean(ahorro), ahorro))


resumen_series_3 <- resumen_series %>% 
  mutate_at(.vars = c("valor","ahorro"),
            .funs = list(~as.numeric(.))) %>% 
  mutate_at(.vars = c("valor","ahorro"),
            .funs = list(~if_else(. > quantile(.,probs = 0.9), mean(.), .)))


# cuando uso funciones que tienen el sugfijo at,all o if, la operacion siempre
# debe ir dentro de un list(), la oepracion comienza con ~ y el . significa
# que debe cada usar cada columna en vars.

  resumen_series %>% 
  ggplot()+
  geom_line(aes(x = fecha_definitiva,y=valor)) +
    ylim(225,375) + # definir limites delimites del eje y
    labs(title = "Serie de compras")

  # Quiero ver en conjunto, las compras y el ahorro

# error con los ejes por atipicos: ----------------------------------------

  
  
  resumen_series %>% 
    gather("variable","valores",-fecha_definitiva) %>% 
    ggplot() +
    geom_line(aes(x = fecha_definitiva,y=valores,color = variable)) +
    ylim(0,375) 
    
  # Sepárados:
  resumen_series %>% 
    gather("variable","valores",-fecha_definitiva) %>% 
    ggplot() +
    geom_line(aes(x = fecha_definitiva,y=valores,color = variable))  +
    ylim(0,375) +
    facet_grid(variable~., scales = "free") 
  
  

# correccion de los atipicos ----------------------------------------------

  
  
  resumen_series_2 %>% 
    select(-valor,-ahorro) %>% 
    gather("variable","valores",-fecha_definitiva) %>% 
    ggplot() +
    geom_line(aes(x = fecha_definitiva,y=valores,color = variable))
  
  # Sepárados:
  
  resumen_series_2 %>% 
    select(-valor,-ahorro) %>% 
    gather("variable","valores",-fecha_definitiva) %>% 
    ggplot() +
    geom_line(aes(x = fecha_definitiva,y=valores,color = variable))  +
    facet_grid(variable~., scales = "free") 
  

# con el resultado de mutate_at -------------------------------------------

  
  resumen_series_3 %>% 
    gather("variable","valores",-fecha_definitiva) %>% 
    ggplot() +
    geom_line(aes(x = fecha_definitiva,y=valores,color = variable))
  
  # Sepárados:
  
  resumen_series_3 %>%
    gather("variable","valores",-fecha_definitiva) %>% 
    ggplot() +
    geom_line(aes(x = fecha_definitiva,y=valores,color = variable))  +
    facet_grid(variable~., scales = "free")  
  
  
?auto.arima

# Prediccion --------------------------------------------------------------

library(forecast)
  
  ?auto.arima
  
  
?ts

  summary(resumen_series_3$fecha_definitiva)
  
  

  # Series mensuales:
  
  resumen_series_3 %>% 
    mutate(fecha_mensual = floor_date(fecha_definitiva,unit = "month")) %>% 
    group_by(fecha_mensual) %>% 
    summarise_at(.vars = c("valor","ahorro"),         # nombres de las columnas
                 .funs = list(~sum(.,na.rm = T)))  %>%    #operacion por grupos
    ungroup  
  
  # pero en meses aun hay huecos
  
  # Series mensuales:
  
  semestrales <- resumen_series_3 %>% 
    mutate(fecha_semestral = floor_date(fecha_definitiva,unit = "halfyear")) %>% 
    group_by(fecha_semestral) %>% 
    summarise_at(.vars = c("valor","ahorro"),         # nombres de las columnas
                 .funs = list(~sum(.,na.rm = T)))  %>%    #operacion por grupos
    ungroup 
  
  
  semestrales <- semestrales %>% 
    mutate(ahorro_2 = ahorro + 0.1*lag(ahorro))
  
  semestrales %>% 
    ggplot()+
    geom_line(aes(x = fecha_semestral, y= ahorro_2))
  
  valores <- semestrales$ahorro_2
  
  # serie de tiempo semestral de las compras:
  
  valor_ts <- ts(valores,start = 1936,end = 1970,frequency = 2)
  
  
  auto.arima(valor_ts)

  
    
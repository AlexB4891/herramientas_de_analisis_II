# Primero tengo la siguientye expresion:

# Librerias:
library(tidyverse)
library(rlang)


# Consumo electrico por tipo:

barras_data <- read.table(
  text = '"Year"	"Residencial"	"Comercial"	"Industrial"	"Alum_Publico"	"Otros"	"Total"	"PIB"
1999	2960304.10032	1263990.201535	2072556.317377	593209.077133	840630.458316	7730690.154681	37318.961
2000	2754376.536226	1340596.946627	2193883.730571	608315.778822	892165.035113	7789338.027359	37726.41
2001	2915740.957621	1411664.732147	2139392.832765	634090.725733	888609.843636	7989499.091902	39241.363
2002	2806151.064327	1371347.90274	2426899.530174	623708.591302	883457.067934	8111564.156477	40848.994
2003	3161384.445246	1670604.579659	2497741.599647	639645.329194	782747.018026	8752122.971772	41961.262
2004	3101252.015002	1732679.321517	2535568.448954	631408.973711	899392.755598	8900301.514782	45406.71
2005	3247987.111009	1819669.748557	2883989.111589	635884.433337	890430.727586	9477961.132078	47809.319
2006	3525687.26949	2039201.734226	3136147.024558	683315.919535	990465.767275	10374817.715084	49914.615
2007	3726120.488361	2081225.111711	3319661.348945	713187.586289	1129376.93429	10969571.469596	51007.777
2008	3942948.598279	2152699.754519	2989730.482448	720944.766436	1358335.462967	11164659.064649	54250.408
2009	4225759.675627	2297635.136859	3545404.268636	787267.989596	972913.17591	11828980.246628	54557.732
2010	4750913.85968	2449708.010119	4264212.117044	775056.180783	968968.383498	13208858.551124	56481.055
2011	4814025.906743	2760607.110628	4409466.401476	815434.827859	1174336.54497	13973870.791676	60925.064
2012	5277439.394383	3053383.736677	4715147.056582	850243.24684	1363082.682288	15259296.11677	64362.433
2013	5726839.633464	3336888.790533	4960458.004916	933025.849029	1684323.633689	16641535.911631	67546.128
2014	6364000.961558	3785720.5819	5353434.598867	1023341.737025	1810676.280142	18337174.159492	70105.362
2015	6927706.602879	3981733.456981	5360437.619105	1081317.747618	1979834.995281	19331030.421864	70174.677
2016	7104846.536734	3839123.588635	5231381.543307	1127096.823243	2049140.834711	19351589.32663	69314.066
2017	7268729.910058	3832363.339025	5698316.624193	1206765.261801	2142005.709584	20148180.844661	70955.691
2018	NA NA NA NA NA 21051744.74	71932.84',
  header = TRUE
) %>% filter(complete.cases(.))


# Con esto construyo una tabla long:

gather(barras_data,
       variable, #<< [1]
       valor,    #<< [2]
       -Year     #<< [3]
)

# mi objetivo es crewar una función que por default me cree una columna que se llame variables
#  y otra que almacene los valores y que solo tome el nombre de la(s) variable(s) que deseo excluir


var_2 <- "Year"

str_c(
  'gather(barras_data,"variable","valor",-',
  var_2,
  ')'
) %>%   # Hasta aqui creo el texto de la expresión:
  parse_expr(.) %>%  # Con esto creo el codigo de R con ese texto
  eval(.)  # Con esto evaluo la expresión
  


# `str_c` concatena textos de forma vectorial:

letters %>% str_c("1") # A cada elemento le pega un "1"

# Pegar eleemntos de varios vectors:

letters %>% str_c("1",sep = "-") # 
# Equivale a 
letters %>% str_c("-1")

str_c(letters,"-",LETTERS,"-",letters)
# Equivale a:
str_c(letters,LETTERS,letters,sep ="-")

# Pegar todos los elementos de un vector usando un separador
letters %>% str_c(collapse = ",")

"texto" %>% str_c(collapse = ",")

gather_mod <- function(data,var){
  
  # Armo el vector de nombres:
  var_2 <- var %>% 
    str_c("-",.) %>% 
    str_c(collapse = ",")
  
  # Defino a "variable" y "valor" como fijas para [1] y [2]
  str_c(
    'gather(data,"variable","valor",',
    var_2,
    ')'
  ) %>% 
    rlang::parse_expr(.) %>%  
    eval                      #<< [**]
}

# Ejemplo con la base barras data:
gather_mod(data = barras_data,
           var = "Year")

# Con iris:

gather_mod(data = iris,"Species")


mtcars %>% 
  rownames_to_column(var = "marca") %>%  # Como esta tabla tiene nombres de filas lo que quiero es que esos nombres sean una columna
  gather_mod(data = .,var = c("marca","cyl","mpg"))


# ¿Como volver a una tabla wide 

tabla_long <- 
  gather(barras_data,
         variable, #<< [1]
         valor,    #<< [2]
         -Year     #<< [3]
  )


# La función spread, toma una variable y constyuye nombres de columnas y asigna valores:

spread(data = tabla_long, # tabla a lo largo
       key = "variable",   # columna que almacena los nombres de las columnas
       value = "valor"     # columna que almacena los valores de las columnas
       )


mtcars %>% 
  rownames_to_column(var = "marca") %>%  # Como esta tabla tiene nombres de filas lo que quiero es que esos nombres sean una columna
  gather_mod(data = .,var = c("marca","cyl","mpg"))

# Equivale a :

cars_long <- mtcars %>% 
  rownames_to_column(var = "marca") %>% 
  gather("variable","valor",-marca,-cyl,-mpg)


spread(cars_long,variable,valor)



# graficos ----------------------------------------------------------------

# Grafico de barras simple:

data_bar <- gather_mod(barras_data, "Year") %>% 
  filter(variable != "Total")
 
data_bar %>% 
  ggplot()+
  geom_col(aes(x = Year,                #<< La función "aes" va a tomar los  
               y = valor,               #<< argumentos dependiendo del   
               fill = variable          #<< gráfico  
  ))  



# grafico de dispérsión: Total vs PIB


barras_data %>% 
  ggplot() +
  geom_point(aes(x = Total, y = PIB))



iris %>% 
  ggplot() +
  geom_point(aes(x = Sepal.Length , y = Sepal.Width,color = Species))

# Mapa de calor:

tabla <- read_csv("10_tidyverse_III//saiku-export.csv")

nuevos <- c("activ","provin","tipo_c","grupo_e",
            "gran_c","clase","anio","mes","estado",
            "compras_t","ventas_t","impuesto_c")

originales <- names(tabla)

tabla <- tabla %>% 
  rename_all(~nuevos)


tabla <- tabla %>%
  mutate_at(.vars = c("provin",
                      "tipo_c",
                      "grupo_e",
                      "gran_c",
                      "clase",
                      "estado"),
            .funs = list(~factor(.)) 
  )



# Quiero crear un mapa de calor entre el tipo de contribuyente y el estado, considerando las ventas


tabla %>% 
  group_by(tipo_c,estado) %>% 
  summarise(ventas_prom = mean(ventas_t,na.rm = T)) %>% 
  ggplot() +
  geom_tile(aes(x = estado,y = tipo_c ,
                fill = log(ventas_prom))) # el log suaviza las diferencias



tabla <- tabla  %>% 
  mutate(fecha = str_c(anio,"-",mes,"-01"), 
         fecha = as.Date(fecha)               
         )
# Por fecha quiero las ventas de cada provincia:

guayas_ventas <- tabla %>% 
  group_by(fecha,provin) %>% 
  summarise(ventas_tot = sum(ventas_t,na.rm = T)) %>% 
  ungroup %>% 
  filter(provin == "GUAYAS") 

# Para una sola provincia: 

guayas_ventas%>% 
  ggplot() +
  geom_line(aes(x = fecha,y = ventas_tot))



guayas_ventas%>% 
  ggplot() +
    geom_area(aes(x = fecha,y = ventas_tot))


# Totas las provincias:

ventas_nacional <- tabla %>% 
  group_by(fecha,provin) %>% 
  summarise(ventas_tot = sum(ventas_t,na.rm = T)) %>% 
  ungroup 


# Por si pertenece a un grupo economico:

ventas_grupo <- tabla %>% 
  group_by(fecha,grupo_e) %>% 
  summarise(ventas_tot = sum(ventas_t,na.rm = T)) %>% 
  ungroup 

ventas_grupo %>% 
  ggplot() +
  geom_line(aes(x = fecha,y = ventas_tot,color = grupo_e)) + 
  facet_grid(grupo_e~.,scales = "free") # filas ~ columnas

# Creando apneles con varais variables categoricas:

ventas_grupo_gran <- tabla %>% 
  group_by(fecha,grupo_e,gran_c) %>% 
  summarise(ventas_tot = sum(ventas_t,na.rm = T)) %>% 
  ungroup 

ventas_grupo_gran %>% 
  ggplot() +
  geom_line(aes(x = fecha,y = ventas_tot,color = grupo_e)) + 
  facet_grid(grupo_e~gran_c,scales = "free") +# filas ~ columnas
  theme()

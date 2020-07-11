

# Clase 2: listas y atributos ---------------------------------------------

########################
#   REPRODUCIBILIDAD   #
########################

# vectores de letras
letters

LETTERS

#  aleatorización:

sample(letters)

sample()

# Evalucieones:

is.numeric(letters)

# NA:

mean(c(NA,1),na.rm = T)

# El principio de reproducibilidad indica que todo programa que tu generes 
# debe poder ser replicado bajo las mismas circunstacias


letras <- sample(letters)

paste()

paste()

# Secuencias:

1:20

?seq

seq(from = 1,to = 200,by =5)


sample(x = letters,size = 1000,replace = T)

# Semilla: 

z <- sample(LETTERS,10)


set.seed(1984)

z <- sample(LETTERS,10)

# Listas

usuarios <- sample(x = c("Iván","Alex","María","Juan"),
                   size = 100,replace = T)

meses <- sample(1L:12L,100,replace = T)

# Declaración explicita de parametros
ventas <- rnorm(n = 100,mean = 1000,sd = 459)

# Declaración implicita de parametros
egresos <- rnorm(100,750,10)

# Una lista es una colección de elementos de distinto tipo:


caja <- list(
  usuarios,
  meses,
  ventas,
  egresos
)

# Subsetting (por posición)

# Primer elemento:
usuarios[1]

# Los primeros 10:

usuarios[1:10]

# Por posición:

ventas[c(1,5,27)]

# en listas:

caja[[2]]

# Esto me devuelve un vector o lo que haya.
# Aca subseteo el vector en el segundo elemento de la lista:

caja[[2]][1:20]

# Objetos nombrados:

attributes(ventas)

class(ventas)

# Asignar nombres a los elementos del vector:
names(ventas) <- usuarios

attributes(ventas)

# Crear un vector nombrado:

ventas_0 <- c("Pedro" = 60,"Martin" = 10)

names(iris)

names(iris) <- c("AnchoS","LargoS","AnchoP","LargoP","Especie")

names(iris)

# Con listas:

names(caja)

names(caja) <- c("usuarios",
                 "meses",
                 "ventas",
                 "egresos")


caja$usuarios

caja$usuarios[1:10]

# Unsolo [] te devuelve lista:
r <- caja["usuarios"]

class(r)

# Unsolo [[]] te devuelve el elemento que hay dentro:
s <- caja[["usuarios"]]

caja_2 <- transpose(caja)

caja_2[1]

caja_2[[100]]


# Dataframe:

inicial_df <- as.data.frame(caja)

inicial_df <- data.frame(
  usuarios,
  meses,
  ventas,
  egresos
)


class(inicial_df)

attributes(inicial_df)

dim(inicial_df)

# Primero filas, luego columnas:

# todas las columnas:

inicial_df[100, ]

inicial_df[100, "ventas"]

inicial_df[100, 1]
# tercera columna:

inicial_df[,3]

# Varias columnas:

inicial_df[,c(1,4)]

# Spoiler:

library(tidyverse)

iris %>% 
  group_by(Species) %>% 
  summarise_if(is.numeric,mean,na.rm = T) %>% 
  gather(name,value,-Species) %>% 
  ggplot(aes(x = name,y=value,fill = Species)) +
  geom_bar(position = position_dodge(),
           stat = "identity")

# Crear carpetas:

dir.create("02_clase_listas")

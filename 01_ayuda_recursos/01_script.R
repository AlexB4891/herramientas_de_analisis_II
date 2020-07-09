
# Clase 1: Busqueda de ayuda ----------------------------------------------

# Añadir sección; ctrl + shift + R
# Comentarios: numeral (#)
# Comentar una linea de código; ctrl + shift + C
# Ejecutar; ctrl + enter
# Guardar: ctrl + S

# Buscar ayuda:

## Abrir ventana de ayuda:

help.start()

## Buscar ayuda por tema:

help.search("normal distribution")

## Buscar ayuda sobre una función:

help(fitted)

# Clase 1: Environments ---------------------------------------------------


.packages()
    
## Viñetas
# Buscar disponibles:

vignete()

# Y cuadno encuentras una del que tema que buscas:

vignette("dplyr")

# Elementos del global environment:

ls()

# Instalación de librerias/paquetes:

install.packages("dplyr",dependencies = T)

# Versión en desarrollo:

devtools::install_github("https://github.com/tidyverse/dplyr")


#  Cargar librerias:
library(dplyr)
require(dplyr)



# Elementos del environment: ----------------------------------------------
# Elementos disponibles:

ls()


# Borrar:
# 1 solo elemento:

rm("x")

# todo:

rm(list = ls())

# Valores atómicos:

class(1L)

class("a")

class(TRUE)

class(2.4)


# Vectores: colección de atómicos del mismo tipo/clase

x <- c(1L,2L,3L)

y <- c("a","g")

z <- c(TRUE,FALSE)

a <- c(1.4,5.6)

# Los vectores tienen propiedaddes:

# Tamaño:

length(y)

# clase:

class(a)


# Reglas de coherción:

# 1. Concatenar vectores:

# 1.1. Numerico vs character: character

c(x,y)

# 1.2. Numerico vs integer: numeric

c(z,y)

# Nombre sintacticos:

# Solo contine . o _ no puede tener caracteres especiales, admite 
# tilde pero no recomendable

# Pero si es poble crear un nombre no sintactico: usando ``


`new?vector` <- c(z,x)

# Nombres reservados como TRUE, if, while, for no deben ser usados pero si se puede como nombre
# no sintactico

TRUE <- c(x,y,z)

# No recomendado

`TRUE` <- c(x,y,z)

# Ejemplo de sobreescritura de función homonima: 

y <- ts(x,start = 1000)

stats::filter(y,filter = c(1,1))

dplyr::filter(y)






# notas de clase 5

asistentes <- c("Melody","Fausto","Daniela")

saludos <- list()

for(nombre in asistentes){
  
  saludos[[nombre]] <- paste("Hola!",nombre)
  
}

str(saludos)

names(saludos)

saludos$Melody

# Numeros primos

for(num in 5:25 ){
  flag <-  0
  # Sí el valor es mayor 1:
  if(num > 1) {
    # Reviso la división:
    flag <-  1
    for(i in 2:(num-1)) {
      if ((num %% i) == 0) {
        
        # Aqui rompemos el loop si al menos un numero antes de 
        # num hace una división entera
        flag <-  0
        break
      } 
    }
  }
  
  if(num == 2)    flag <-  1
  if(flag == 1) {
    print(paste(num,"Es un número primo"))
  } else {
    # Si no se cumple la condición paso a la siguiente iteración con:
    next
  }
}

# Matriz aleatoria con una distribución de poisson

set.seed(1984)

my.mat <- matrix(NA, nrow = 100, ncol = 20)

for (i in 1:ncol(my.mat)) {  
  
  my.mat[, i] <- rpois(100, lambda = i)
  
}

# Resumen de vectores:

summary(my.mat[,1])

summary(my.mat[,20])

sum <- summary(my.mat[,20])

class(sum)

sum[["Mean"]]

# Cuando tenemos distintas magnitudes lo que debemos hacer es normalizar:

medias <- c()

sd <- c()

cent.mat <- my.mat

# Normalizar la matriz:
for(i in 1:ncol(my.mat)){
  
  medias[i] <- mean(my.mat[ ,i])
  
  sd[i] <- sd(my.mat[ ,i])
  
  cent.mat[,i] <- (cent.mat[,i] - medias[i]) / sd[i]
  
  
}

# Resumen base centrada :
for(i in 1:ncol(cent.mat)){
  
  print(summary(cent.mat[ ,i]))
  
}


# Más rápido:

# Dos argumentos:
# 1. Tabla o matriz
# 2. La dimensión sobre la que aplicare una función
#      1: para filas
#      2: para columnas

centrada_2 <- apply(X = my.mat,
                    MARGIN = 1,
                    FUN = function(x){
                      (x - mean(x,na.rm = T))/sd(x)
})

# Declarar elementos elementos temporales dentro de una función

centrada_2 <- apply(X = my.mat,
                    MARGIN = 1,
                    FUN = function(x){
                      
                      mm <- mean(x,na.rm = T)
                      ss <- sd(x,na.rm = T)
                      
                      cc <- (x - mm)/ss
                      
                      return(cc)
                      
                    })

# Declarar una función anonima


# Scoping rules: ----------------------------------------------------------

# Quiero centralizar la base pero multiplicar por 100  a cada columna:

constante <- 100

centralizar <- function(x){
  
  mm <- mean(x,na.rm = T)
  ss <- sd(x,na.rm = T)
  
  cc <- (x - mm)/ss
  
  cc2 <- cc*constante
  
  return(cc2)
  
}


centralizar(my.mat[,1])

# Eliminar elementos:

rm(constante)

# Con una funcon declarada en el global envorinment

apply(X = my.mat,
      MARGIN = 1,
      FUN = centralizar)


centralizar_2 <- function(x,constante){
  
  mm <- mean(x,na.rm = T)
  ss <- sd(x,na.rm = T)
  
  cc <- (x - mm)/ss
  
  cc2 <- cc*constante
  
  return(cc2)
  
}

centralizar_2(x = my.mat[,1],constante = 500)

# El argumento ... hereda argumentos a las funciones que dentro de otra 
# función

apply(X = my.mat,
      MARGIN = 1,
      FUN = centralizar_2,
      constante = 500)



centralizar_3 <- function(x,constante,constante_2){
  
  mm <- mean(x,na.rm = T)
  ss <- sd(x,na.rm = T)
  
  cc <- (x - mm)/ss
  
  cc2 <- (cc*constante)/constante_2
  
  return(cc2)
  
}

apply(X = my.mat,
      MARGIN = 1,
      FUN = centralizar_3,
      constante = 500, # ...
      constante_2 = 800 # ...
      )

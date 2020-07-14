
# Clase 2: data.frames y primeras oepraciones -----------------------------

# Vectorización

x <- sample(1:10,5,replace = T)

help.search("uniform distribution")

y <- runif(n = 5,min = 5,max = 50)


# Suma:

z <- c(x,y)

sum(x,y)

# Suma de eleemtnos de un vector:
sum(z)

# Suma de vectores:

x + y

# Agregar un nuevo elemento al vector x 

x <- c(x,1,4,5)

# Missign value:

y <- c(y,NA,2,NA)


sum(y,na.rm = T)


is.na(y)

# Extraigo elementos de un vector usando un vector de posiciones:

y[c(6,8)]

y[is.na(y)]

# Inverso

y[-c(6,8)]

y[!is.na(y)]

# Subset con condicionales:


y <= 30

x >= 6

# Dos condiciones:

# %% division entera:

x[x %% 4 == 0]

# Valores de x que son divisibles para 4
 
y[y<= 30]

x[x >= 6]

# Función paste:

nombres <- c("Mario","Luigi","José")

expresion <- c("Hola","chao","Que tal")

# Vector concatenado con un mismo string, separado por dos puntos y espacio: 
paste("Hola",nombres,sep = " : ")

# Dos vectores pegados uno a uno, y unidos por coma:
paste(expresion,nombres,collapse = ", ")

# Union sin espacios:

paste0(expresion,nombres)


# Expresiones regulares parte I -------------------------------------------


# cadena de texto que se busca extraer, o modificar, está cadena usualmente ocupa una sintaxis
# que nos permite ubicar textos por su contenido

df <- datasets::mtcars

# Clase del objeto:

class(df)

# dimensiones del data frame
dim(df)

# Attributes:

attributes(df)

# Nombres de filas:

carros <- row.names(df)

# Nombres de columnas:

colnames(df)

# busco textos:

# Posicones:
pos_mazda <- grep(x = carros,pattern = "Mazda")

# Valor:

txt_mazda <- grep(x = carros,pattern = "Mazda",value = T)

# Logicos:
lgl_mazda <- grepl(x = carros,pattern = "Mazda")


carros[pos_mazda]

carros[lgl_mazda]

grep(x = carros,pattern = "^C.*a",value = T)

carros

# Instalación del paquete readxl:

install.packages("readxl")


CIIU <- read_excel("03_clase_dataframes/CIIU.xls",  skip = 1)

# Class

# Dimensiones

# Nombres de columna

# Extraer la pimera y segunda columna



nombres_df <- colnames(CIIU)

# tamaño del vector:

length(nombres_df)

nuevos_nombres <- c("codigo","descripcion","nivel","codigo_2","descripcion_2","nivel_2")

length(nuevos_nombres)

colnames(CIIU) <- nuevos_nombres

colnames(CIIU)
# Ver la tabla:

View(CIIU)


# Modificacion por posicion:

colnames(CIIU)[c(3,6)]

colnames(CIIU)[c(3,6)] <- c("nivel_a","nivel_b")


y[c(6,8)] <- 0

y[y == 0]

y[c(6,8)] <- c(99,00)


y[y >10] <- y[y >10] -5



# Subset de un data frame:

# Extraigo columna como vector:

CIIU$codigo


# Extraigo columna como tabla:
CIIU[,1]

CIIU[,"codigo"]


posiciones <- grep(x = CIIU$descripcion,pattern = "chocolate")


CIIU[ posiciones , ]

logica <- grepl(x = CIIU$descripcion,pattern = "llantas")

sum(logica)

View(CIIU[ logica , ])

# Vector con distribución normal con media 500000 y desviación 800 con el tamaño 
# del numero de filas de ciiu

ventas_agregadas <- rnorm(n = nrow(CIIU),mean = 500000,sd = 8000)

# Crear columnas en el dataframe:

CIIU$ventas_agregadas <- ventas_agregadas

mayores_5 <- CIIU$ventas_agregadas >= 500000

CIIU[mayores_5,]


# A la vez:

CIIU[mayores_5, c("descripcion","nivel_a")]


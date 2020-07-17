# Caso de estudio 1:

# Paso 0: Directorios

# Datos:
if(!dir.exists("06_caso_estudio_I/datos/")){
  dir.create("06_caso_estudio_I/datos/")
}

# Diccionarios:
if(!dir.exists("06_caso_estudio_I/diccionarios/")){
  dir.create("06_caso_estudio_I/diccionarios/")
}

# Paso 1: 
# Descarga, creación de directorios y descompresión de archivos

# Descarga: 

if(!file.exists("06_caso_estudio_I/enemdu_2019_12.zip")){
  
download.file(url = "https://www.ecuadorencifras.gob.ec/documentos/web-inec/EMPLEO/2019/Diciembre/BDD_ENEMDU_2019_12_CSV%20%28DATOS%20ABIERTOS%29.zip",
              destfile = "06_caso_estudio_I/enemdu_2019_12.zip")
  
}

# Descompresión:
# Chequeo que tengo dentro del zip:

enemdu_file <- "06_caso_estudio_I/enemdu_2019_12.zip"

unzip(zipfile = enemdu_file,list = T)

# Ahora ya conozco el contenido y necesito:
#    Diccionarios
#    Base de personas

unzip(zipfile = enemdu_file,
      files = c("enemdu_persona_201912.csv",
                "DICCIONARIO_VARIABLES.zip"),
      exdir = "06_caso_estudio_I" )

# Pasar mis datos a la carpeta respectiva:

file.copy(from = "06_caso_estudio_I/enemdu_persona_201912.csv",
          to = "06_caso_estudio_I/datos/enemdu_persona_201912.csv")

# Quiero extraer los diccionarios:

unzip(zipfile = "06_caso_estudio_I/DICCIONARIO_VARIABLES.zip",list = T)


unzip(zipfile = "06_caso_estudio_I/DICCIONARIO_VARIABLES.zip",
      files = "enemdu_personas_2019_12.xlsx",
      exdir = "06_caso_estudio_I/diccionarios")

# elimnar archivos:

file.remove(c("06_caso_estudio_I/enemdu_persona_201912.csv",
              "06_caso_estudio_I/DICCIONARIO_VARIABLES.zip",
              "06_caso_estudio_I/enemdu_2019_12.zip"))

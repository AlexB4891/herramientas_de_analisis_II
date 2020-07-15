# Ejemplo factores:

sample_letras <- sample(letters,5000,replace = T)

typeof(sample_letras)

resumen <- table(sample_letras)

plot(resumen)

# Un objeto S3 cambia el comportamoento de las funciones

sample_factor <- factor(sample_letras)

plot(sample_factor)


# Ejemplo de reordenamiento

educacion <- c("kinder","primaria","secundaria","tercer nivel","postgrado","phd")

sample_ed <- sample(educacion,5000,replace = T)

plot(table(sample_ed))

sample_ed <- factor(sample_ed)

sample_ed_2 <- factor(sample_ed,levels = educacion)

plot(sample_ed_2)

# Por que es un integer?

sum(sample_ed)
# Error

sum(sample_ed_2)
# Error

as.integer(sample_ed_2)


# Ejemplo de edades -------------------------------------------------------

edades <- sample(0:100,5000,replace = T)

cortes <- cut(edades,breaks = c(0,10,30,60,100))

plot(cortes)

# Con una escala de likert


score <- c("Malo","Indiferente","Bueno","Excelente")

score_vector <- sample(score,5000,replace = T)

plot(factor(score_vector))

likert <- factor(score_vector,levels = score)

plot(likert)

mean(as.integer(likert))

unclass(likert)



# Fechas ------------------------------------------------------------------

today <- Sys.Date()

typeof(today)

fechas <- c("2012-09-01","2013-04-01",
            "2018-17-50","5 mayo 2019",
            "6/4/2020","08-05-20")


fechas_form <- as.Date(fechas,format = "%Y-%m-%d")

as.Date(fechas,format = "%d %B %Y")

as.Date(fechas,format = "%d/%m/%Y")

as.Date(fechas,format = "%m-%d-%y")

fechas_form[1] -fechas_form[2]


fechas[1] -fechas[2]

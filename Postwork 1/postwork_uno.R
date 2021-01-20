# Sesión 1. Introducción a R y Software

# 1. Importando los datos de la temporada 2019-2020...

url <- "https://www.football-data.co.uk/mmz4281/2021/SP1.csv"

download.file(url = url, destfile = "Season19_20_SP.csv", mode = "wb")

datos_fut <- read.csv("Season19_20_SP.csv") # Leyendo el archivo dentro del directorio de trabajo

str(datos_fut)

# 2. Extrayendo goles de equipos que jugaron en casa (FTHG) y goles de equipos que jugaron como visitante (FTAG)

library(dplyr) #select no sirve sin dplyr

datos_fut <- select(datos_fut, FTHG, FTAG)

head(datos_fut)

# 3. Consultando table en consola

?table

# a. La probabilidad (marginal) de que el equipo que juega en casa anote x goles

as.data.frame(table(datos_fut$FTHG)/nrow(datos_fut))

# b. La probabilidad (marginal) de que el equipo que juega como visitante anote y goles

as.data.frame(table(datos_fut$FTAG)/nrow(datos_fut))

# c. La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles

as.data.frame(table(datos_fut)/nrow(datos_fut))

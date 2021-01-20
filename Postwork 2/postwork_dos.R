# Sesión 2. Manipulación de datos en R

# 1. Importando datos de las temporadas 2017-2018, 2018-2019 y 2019-2020

url1 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv" #2017-2018
url2 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv" #2018-2019
url3 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv" #2019-2020

#Descargando todos los archivos
download.file(url = url1, destfile = "Season17_18_SP.csv", mode = "wb")
download.file(url = url2, destfile = "Season18_19_SP.csv", mode = "wb")
download.file(url = url3, destfile = "Season19_20_SP.csv", mode = "wb")

#Convirtiendo en df
datos_1 <- read.csv("Season17_18_SP.csv")
datos_2 <- read.csv("Season18_19_SP.csv")
datos_3 <- read.csv("Season19_20_SP.csv")

#2. Obteniendo una mejor idea de las características

#Explorando df con str()
str(datos_1)
str(datos_2)
str(datos_3)

#Explorando df con head()
head(datos_1)
head(datos_2)
head(datos_3)

#Explorando df con View()
View(datos_1)
View(datos_2)
View(datos_3)

#Explorando df con summary()
summary(datos_1)
summary(datos_2)
summary(datos_3)

#3. Extrayendo Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR

# A. Con select

library(dplyr) #select no sirve sin dplyr

datos_1 <- select(datos_1, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
head(datos_1)

datos_2 <- select(datos_2, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
head(datos_2)

datos_3 <- select(datos_3, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
head(datos_3)

# Pendiente. Con lapply

# 4. Asegurando que tenga los mismos tipos y cambiando formato de fechas

str(datos_1)

# Problema: Al convertir a fecha, la fecha 19/07/17 se ve 0017-07-19, así que hay que agregar el "20"

# Traté de extraer para después concatenar, pero es más laborioso
# datos_1 <- mutate(datos_1, Fec1 = substr(datos_1$Date, start = 1, stop = 6))

# Mejor concatené los elementos dentro de la fecha para posteriormente volverlos a almacenar
datos_1 <- mutate(datos_1, Date = paste(substr(datos_1$Date, 1, 6), "20", sep = "", substr(datos_1$Date, 7, nchar(datos_1$Date))))
head(datos_1)

# Doy formato de fecha a los datos obtenidos

datos_1 <- mutate(datos_1, Date = as.Date(Date, "%d/%m/%Y"))
head(datos_1)

datos_2 <- mutate(datos_2, Date = as.Date(Date, "%d/%m/%Y"))
head(datos_2)

datos_3 <- mutate(datos_3, Date = as.Date(Date, "%d/%m/%Y"))
head(datos_3)

# Termino con rbind para acumular los registros.

datos_gral <- rbind(datos_1, datos_2, datos_3)
summary(datos_gral)
View(datos_gral)

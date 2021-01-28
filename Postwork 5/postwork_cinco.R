# Postwork 5

# 1. Importando datos de soccer de la temporadas 17-18, 18-19 y 19-20

#Almacenando como df

datos_1 <- read.csv("Goals17_20.csv")
View(datos_1)

# Seleccionando columnas de los df

library(dplyr)

SmallData <- select(datos_1, Date, HomeTeam, FTHG, AwayTeam, FTAG)
colnames(SmallData) <- c("date", "home.team", "home.score", "away.team", "away.score")
View(SmallData)

setwd("~/BEDU/Postwork")

# Almacenando en archivo .csv

write.csv(SmallData, "soccer.csv", row.names = FALSE)

# Utilizando create.fbRanks.dataframes para importar soccer.csv

install.packages("fbRanks")
library(fbRanks)

listasoccer <- create.fbRanks.dataframes(scores.file = "soccer.csv")

View(listasoccer)

anotaciones <- listasoccer$scores
View(anotaciones)

equipos <- listasoccer$teams
View(equipos)

# 3. Creación de vector de fechas y creando ranking

n <- unique(anotaciones$date)
View(n)

ranking <- rank.teams(scores = anotaciones, teams = equipos, max.date = n[length(n) - 1], min.date = n[1])

# 4. Estimación de posibilidades de los

?predict()
predict(ranking, date = as.Date(fecha[n]))

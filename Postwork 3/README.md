# Postwork de la sesion 3. Análisis Exploratorio de Datos (AED o EDA) con R

**Contexto:** Nuevamente se toman los datos referentes a equipos de la liga española de futbol.

Recordemos que dicha información se encuentra almacenada en un csv, así que procederemos a abrirlo:
```r
datos_gral <- read.csv("Goals17_20.csv")
```
Depuramos la columna adicional que generó, además de visualizar el resultado
```r
datos_gral <- datos_gral[, 2:7]
View(datos_gral)
class(datos_gral)
```
Calculamos las probabilidades marginales obtenidas de los goles que anota un equipo en casa:
```r
marginal_casa <- as.data.frame(table(datos_gral$FTHG))
total <- sum(marginal_casa$Freq)
marginal_casa$Freq <- marginal_casa$Freq/total
marginal_casa
```
Calculamos las probabilidades marginales obtenidas de los goles que anota un equipo como visitante:
```r
marginal_visita <- as.data.frame(table(datos_gral$FTAG))
total <- sum(marginal_visita$Freq)
marginal_visita$Freq <- marginal_visita$Freq/total
marginal_visita
```
Ahora calculamos la probabilidad conjunta de goles marcados:
```r
# Tomamos una tabla formada con las frecuencias, para posteriormente convertirlo en una matriz de una columna y agregar las frecuencias correspondiente

probas <- matrix(as.vector(table(datos_gral$FTHG, datos_gral$FTAG)))
probas <- as.integer(probas)

# Generamos columnas con goles anotados

gol_a <- matrix(nrow = 64, ncol = 1)
gol_b <- matrix(nrow = 64, ncol = 1)

contador <- as.integer(1)
for(i in 0:8){
  for(j in 0:6){
    gol_a[contador, ] <- as.character(j)
    gol_b[contador, ] <- as.character(i)
    contador <- contador + 1
  }
}

# Depuramos dichas columnas

gol_a <- gol_a [1:63,]
gol_b <- gol_b [1:63,]

#Almacenamos como data frame

goles <- as.data.frame(cbind(gol_a, gol_b, probas))
summary(goles)

# Calculamos la probablidad conjunta:

goles <- mutate(goles, probas = as.integer(probas))
goles <- mutate(goles, probas = probas/nrow(datos_gral))
```

[Postwork Anterior](https://github.com/CrisTafRos/BEDU_R/tree/main/Postwork%202) | [Postwork Siguiente](#) 

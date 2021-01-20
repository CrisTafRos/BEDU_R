# Postwork de la sesion 2. Manipulación de datos en R

**Contexto:** Nuevamente se toman los datos referentes a equipos de la liga española de futbol.

**Nota:** Me ahorraré algunos de los detalles que estuvimos visualizando en el postwork anterior. Sigamos :smile:

1. Importamos los datos de soccer de las temporadas 2017/2018, 2018/2019, 2019/2020 de la primera división de la liga española a R. Disponibles en: https://www.football-data.co.uk/spainm.php
```r
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
```
2. Obteniendo una mejor idea de las características de cada dataframe:
- Con str()
```r
str(datos_1)
str(datos_2)
str(datos_3)
```
Para obtener algo parecido a esto, obviamente más extenso y por cada dataframe:
```r
> str(datos_1)
'data.frame':	380 obs. of  64 variables:
 $ Div       : chr  "SP1" "SP1" "SP1" "SP1" ...
 $ Date      : chr  "18/08/17" "18/08/17" "19/08/17" "19/08/17" ...
 $ HomeTeam  : chr  "Leganes" "Valencia" "Celta" "Girona" ...
 $ AwayTeam  : chr  "Alaves" "Las Palmas" "Sociedad" "Ath Madrid" ...
 $ FTHG      : int  1 1 2 2 1 0 2 0 1 0 ...
 ...
```
- Con head()
```r
head(datos_1)
head(datos_2)
head(datos_3)
```
Para obtener algo parecido a esto, obviamente más extenso y por cada dataframe:
```r
> head(datos_1)
  Div     Date   HomeTeam   AwayTeam FTHG FTAG FTR HTHG HTAG HTR HS AS HST
1 SP1 18/08/17    Leganes     Alaves    1    0   H    1    0   H 16  6   9
2 SP1 18/08/17   Valencia Las Palmas    1    0   H    1    0   H 22  5   6
3 SP1 19/08/17      Celta   Sociedad    2    3   A    1    1   D 16 13   5
4 SP1 19/08/17     Girona Ath Madrid    2    2   D    2    0   H 13  9   6
5 SP1 19/08/17    Sevilla    Espanol    1    1   D    1    1   D  9  9   4
6 SP1 20/08/17 Ath Bilbao     Getafe    0    0   D    0    0   D 12  8   2
 ...
```
- Con view()
```r
View(datos_1)
View(datos_2)
View(datos_3)
```
Para obtener algo parecido a esto, obviamente más extenso y por cada dataframe:
```r
 # Agregar aquí la imagen D:
```
- Con summary()
```r
summary(datos_1)
summary(datos_2)
summary(datos_3)
```
Para obtener algo parecido a esto, obviamente más extenso y por cada dataframe:
```r
> summary(datos_1)
     Div                Date             HomeTeam        
 Length:380         Length:380         Length:380        
 Class :character   Class :character   Class :character  
 Mode  :character   Mode  :character   Mode  :character  
 ...
```

3. Extrayendo Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR
```r
library(dplyr) #select no sirve sin dplyr

datos_1 <- select(datos_1, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
head(datos_1) # agregado para comprobar que lo haga bien

datos_2 <- select(datos_2, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
head(datos_2)

datos_3 <- select(datos_3, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
head(datos_3)
```
Aplicando head() para poder visualizar la extracción
```r
      Date   HomeTeam   AwayTeam FTHG FTAG FTR
1 18/08/17    Leganes     Alaves    1    0   H
2 18/08/17   Valencia Las Palmas    1    0   H
3 19/08/17      Celta   Sociedad    2    3   A
4 19/08/17     Girona Ath Madrid    2    2   D
5 19/08/17    Sevilla    Espanol    1    1   D
6 20/08/17 Ath Bilbao     Getafe    0    0   D
```
4. Asegurando que tenga los mismos tipos y cambiando formato de fechas
Al nuevamente aplicar head(), nos podemos percatar de un problema:
```r
head(datos_1)
head(datos_2)
head(datos_3)
```
Con la siguiente vizualización:
```r
> head(datos_1)
      Date   HomeTeam   AwayTeam FTHG FTAG FTR
1 18/08/17    Leganes     Alaves    1    0   H
2 18/08/17   Valencia Las Palmas    1    0   H
3 19/08/17      Celta   Sociedad    2    3   A
4 19/08/17     Girona Ath Madrid    2    2   D
5 19/08/17    Sevilla    Espanol    1    1   D
6 20/08/17 Ath Bilbao     Getafe    0    0   D
> head(datos_2)
        Date   HomeTeam   AwayTeam FTHG FTAG FTR
1 17/08/2018      Betis    Levante    0    3   A
2 17/08/2018     Girona Valladolid    0    0   D
3 18/08/2018  Barcelona     Alaves    3    0   H
4 18/08/2018      Celta    Espanol    1    1   D
5 18/08/2018 Villarreal   Sociedad    1    2   A
6 19/08/2018      Eibar     Huesca    1    2   A
```
Donde se percibe que difieren los formatos de las hechas, dando pie al siguiente dilema:
> La fecha se visualiza: 19/07/17 y al aplicar el formato de fecha se almacena: 0017-07-19, así que hay que adaptar dicho dato.
```r
datos_1 <- mutate(datos_1, Date = paste(substr(datos_1$Date, 1, 6), "20", sep = "", substr(datos_1$Date, 7, nchar(datos_1$Date))))
head(datos_1)
```
Solucionado como se visualiza en el extracto anterior, para terminar con este resultado:
```r
> head(datos_1)
        Date   HomeTeam   AwayTeam FTHG FTAG FTR
1 18/08/2017    Leganes     Alaves    1    0   H
2 18/08/2017   Valencia Las Palmas    1    0   H
3 19/08/2017      Celta   Sociedad    2    3   A
4 19/08/2017     Girona Ath Madrid    2    2   D
5 19/08/2017    Sevilla    Espanol    1    1   D
6 20/08/2017 Ath Bilbao     Getafe    0    0   D
```
Terminemos actulizando el formato de fecha dentro de los dataframes:
```r
datos_1 <- mutate(datos_1, Date = as.Date(Date, "%d/%m/%Y"))
head(datos_1)

datos_2 <- mutate(datos_2, Date = as.Date(Date, "%d/%m/%Y"))
head(datos_2)

datos_3 <- mutate(datos_3, Date = as.Date(Date, "%d/%m/%Y"))
head(datos_3)
```
Y tener el siguiente resultado:
```r
> head(datos_1)
        Date   HomeTeam   AwayTeam FTHG FTAG FTR
1 2017-08-18    Leganes     Alaves    1    0   H
2 2017-08-18   Valencia Las Palmas    1    0   H
3 2017-08-19      Celta   Sociedad    2    3   A
4 2017-08-19     Girona Ath Madrid    2    2   D
5 2017-08-19    Sevilla    Espanol    1    1   D
6 2017-08-20 Ath Bilbao     Getafe    0    0   D
```
Únicamente falta que apliquenos rbind para acumular todos los dataframes.
```r
datos_gral <- rbind(datos_1, datos_2, datos_3)
View(datos_gral)
```
Aplicaremos summary para verificar que se haya aplicado el cambio
```r
> summary(datos_gral)
      Date              HomeTeam           AwayTeam              FTHG            FTAG           FTR           
 Min.   :0001-02-20   Length:1140        Length:1140        Min.   :0.000   Min.   :0.000   Length:1140       
 1st Qu.:0013-01-20   Class :character   Class :character   1st Qu.:1.000   1st Qu.:0.000   Class :character  
 Median :0024-02-04   Mode  :character   Mode  :character   Median :1.000   Median :1.000   Mode  :character  
 Mean   :0683-08-06                                         Mean   :1.479   Mean   :1.108                     
 3rd Qu.:2017-10-29                                         3rd Qu.:2.000   3rd Qu.:2.000                     
 Max.   :2018-05-20                                         Max.   :8.000   Max.   :6.000                     
```
[Postwork Anterior](https://github.com/CrisTafRos/BEDU_R/tree/main/Postwork%201) | [Postwork Siguiente](#) 

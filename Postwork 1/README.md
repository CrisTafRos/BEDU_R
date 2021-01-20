# Postwork de la sesion 1. Introducción a R y Software

**Contexto:** Se toman los datos referentes a equipos de la liga española de futbol.

1. Importamos los datos de soccer de la temporada 2019/2020 de la primera división de la liga española a R. Disponibles en: https://www.football-data.co.uk/spainm.php
```r
url <- "https://www.football-data.co.uk/mmz4281/2021/SP1.csv"
download.file(url = url, destfile = "Season19_20_SP.csv", mode = "wb")

datos_fut <- read.csv("Season19_20_SP.csv") # Leyendo el archivo dentro del directorio de trabajo
str(datos_fut) #Describiendo df
```

Se obtiene un resultado como el siguiente:
```r
> str(datos_fut)
'data.frame':	177 obs. of  2 variables:
 $ FTHG: int  0 2 0 0 1 1 4 2 1 2 ...
 $ FTAG: int  0 0 2 1 1 1 2 1 0 1 ...
```

2. Extrae las columnas que contienen los anotados por los equipos que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG)

```r
library(dplyr) #select no sirve sin dplyr
datos_fut <- select(datos_fut, FTHG, FTAG)
head(datos_fut) #Sólo para comprobar que se extrageron
```

Para obtener:
```r
> head(datos_fut)
  FTHG FTAG
1    0    0
2    2    0
3    0    2
4    0    1
5    1    1
6    1    1
```

3. Consultar cómo funciona la función table en R al ejecutar en la consola:
```r
?table
```
Posteriormente se obtuvieron:
- La probabilidad (marginal) de que el equipo que juega en casa anote x goles
```r
as.data.frame(table(datos_fut$FTHG)/nrow(datos_fut))
```
Resultado:
```r
> as.data.frame(table(datos_fut$FTHG)/nrow(datos_fut))
  Var1        Freq
1    0 0.293785311
2    1 0.333333333
3    2 0.231638418
4    3 0.067796610
5    4 0.062146893
6    5 0.005649718
7    6 0.005649718
```
- La probabilidad (marginal) de que el equipo que juega como visitante anote y goles
```r
as.data.frame(table(datos_fut$FTAG)/nrow(datos_fut))
```
Resultado:
```r
> as.data.frame(table(datos_fut$FTAG)/nrow(datos_fut))
  Var1       Freq
1    0 0.30508475
2    1 0.41807910
3    2 0.16384181
4    3 0.09604520
5    4 0.01694915
```
- La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles
```r
as.data.frame(table(datos_fut)/nrow(datos_fut))
```
Resultado:
```r
   FTHG FTAG        Freq
1     0    0 0.079096045
2     1    0 0.079096045
3     2    0 0.101694915
4     3    0 0.016949153
5     4    0 0.028248588
6     5    0 0.000000000
7     6    0 0.000000000
8     0    1 0.101694915
9     1    1 0.175141243
10    2    1 0.084745763
11    3    1 0.033898305
12    4    1 0.016949153
13    5    1 0.000000000
14    6    1 0.005649718
15    0    2 0.079096045
16    1    2 0.022598870
17    2    2 0.033898305
18    3    2 0.011299435
19    4    2 0.011299435
20    5    2 0.005649718
21    6    2 0.000000000
22    0    3 0.022598870
23    1    3 0.050847458
24    2    3 0.011299435
25    3    3 0.005649718
26    4    3 0.005649718
27    5    3 0.000000000
28    6    3 0.000000000
29    0    4 0.011299435
30    1    4 0.005649718
31    2    4 0.000000000
32    3    4 0.000000000
33    4    4 0.000000000
34    5    4 0.000000000
35    6    4 0.000000000
```

[Descripción de preworks](https://github.com/CrisTafRos/BEDU_R) | [Postwork Siguiente](https://github.com/CrisTafRos/BEDU_R/tree/main/Postwork%202) 

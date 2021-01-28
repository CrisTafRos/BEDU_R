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
Y por resultado nos da lo siguiente:
```r
> marginal_casa
  Var1        Freq
1    0 0.232456140
2    1 0.327192982
3    2 0.266666667
4    3 0.112280702
5    4 0.035087719
6    5 0.019298246
7    6 0.005263158
8    7 0.000877193
9    8 0.000877193
```
Calculamos las probabilidades marginales obtenidas de los goles que anota un equipo como visitante:
```r
marginal_visita <- as.data.frame(table(datos_gral$FTAG))
total <- sum(marginal_visita$Freq)
marginal_visita$Freq <- marginal_visita$Freq/total
marginal_visita
```
Y por resultado nos da lo siguiente:
```r
  Var1        Freq
1    0 0.351754386
2    1 0.340350877
3    2 0.212280702
4    3 0.054385965
5    4 0.028947368
6    5 0.009649123
7    6 0.002631579
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
goles
```
Y por resultado nos da lo siguiente:
```r
> goles
   gol_a gol_b      probas
1      0     0 0.078070175
2      1     0 0.115789474
3      2     0 0.087719298
4      3     0 0.044736842
5      4     0 0.014035088
6      5     0 0.008771930
7      6     0 0.002631579
8      0     1 0.000000000
9      1     1 0.000000000
10     2     1 0.080701754
11     3     1 0.114912281
12     4     1 0.093859649
13     5     1 0.032456140
14     6     1 0.010526316
15     0     2 0.005263158
16     1     2 0.001754386
17     2     2 0.000877193
18     3     2 0.000000000
19     4     2 0.045614035
20     5     2 0.068421053
21     6     2 0.061403509
22     0     3 0.024561404
23     1     3 0.007017544
24     2     3 0.004385965
25     3     3 0.000000000
26     4     3 0.000000000
27     5     3 0.000877193
28     6     3 0.018421053
29     0     4 0.017543860
30     1     4 0.011403509
31     2     4 0.006140351
32     3     4 0.000000000
33     4     4 0.000000000
34     5     4 0.000877193
35     6     4 0.000000000
36     0     5 0.000000000
37     1     5 0.005263158
38     2     5 0.008771930
39     3     5 0.008771930
40     4     5 0.001754386
41     5     5 0.003508772
42     6     5 0.000877193
43     0     6 0.000000000
44     1     6 0.000000000
45     2     6 0.000000000
46     3     6 0.004385965
47     4     6 0.001754386
48     5     6 0.001754386
49     6     6 0.001754386
50     0     7 0.000000000
51     1     7 0.000000000
52     2     7 0.000000000
53     3     7 0.000000000
54     4     7 0.000000000
55     5     7 0.000000000
56     6     7 0.000000000
57     0     8 0.001754386
58     1     8 0.000877193
59     2     8 0.000000000
60     3     8 0.000000000
61     4     8 0.000000000
62     5     8 0.000000000
63     6     8 0.000000000
```
**Primer heatmap**
```r
heatmap(table(datos_gral$FTHG, datos_gral$FTAG), col = terrain.colors(256), xlab = "FTAG", ylab = "FTHG", main = "Heatmap de probabilidades conjuntas")
```
![alt text](https://github.com/CrisTafRos/BEDU_R/raw/main/Postwork%203/heatmap2.jpeg)
**Segundo heatmap**
```r
library(ggplot2)

ggplot(goles, aes(gol_a, gol_b, fill = probas)) + 
  geom_tile() +
  xlab(label = "FTHG") +
  ylab(label = "FTAG") +
  scale_fill_gradient(name = "Probabilidad Conjunta")
```

![alt text](https://github.com/CrisTafRos/BEDU_R/raw/main/Postwork%203/heatmap.jpeg)

[Postwork Anterior](https://github.com/CrisTafRos/BEDU_R/tree/main/Postwork%202) | [Postwork Siguiente](#) 

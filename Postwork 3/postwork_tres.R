#write.csv(datos_gral, "Goals17_20.csv")

datos_gral <- read.csv("Goals17_20.csv")

datos_gral <- datos_gral[, 2:7]
View(datos_gral)
class(datos_gral)

# Probabilidad marginal de goles en casa

marginal_casa <- as.data.frame(table(datos_gral$FTHG))
total <- sum(marginal_casa$Freq)
marginal_casa$Freq <- marginal_casa$Freq/total
marginal_casa

# Probabilidad marginal de goles como visitante

marginal_visita <- as.data.frame(table(datos_gral$FTAG))
total <- sum(marginal_visita$Freq)
marginal_visita$Freq <- marginal_visita$Freq/total
marginal_visita

#primero va la columna y después el renglón
# i.e. FTHG es la Columna, FTAG es la fila

conjunta <- as.data.frame(table(datos_gral$FTHG, datos_gral$FTAG))

# Convitiendo el vector resultando en matriz

probas <- matrix(as.vector(table(datos_gral$FTHG, datos_gral$FTAG)))

probas <- as.integer(probas)

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

gol_a <- gol_a [1:63,]
gol_b <- gol_b [1:63,]
goles <- as.data.frame(cbind(gol_a, gol_b, probas))

summary(goles)

goles <- mutate(goles, probas = as.integer(probas))

goles <- mutate(goles, probas = probas/nrow(datos_gral))

# Graficando:



# Heatmap No. 1

heatmap(table(datos_gral$FTHG, datos_gral$FTAG), col = terrain.colors(256), xlab = "FTAG", ylab = "FTHG", main = "Heatmap de probabilidades conjuntas")

# Heatmap No. 2

library(ggplot2)

ggplot(goles, aes(gol_a, gol_b, fill = probas)) + 
  geom_tile() +
  xlab(label = "FTHG") +
  ylab(label = "FTAG") +
  scale_fill_gradient(name = "Probabilidad Conjunta")

#####


# Agregando goles

#labels_goles <- matrix(nrow = 9, ncol = 7)

#for(i in 0:9){
#  for(j in 0:7){
#    labels_goles[i,j] <- paste(i - 1, j - 1, sep = ",")
#  }
#}

#labels <- matrix(labels_goles)

#conjunta <- cbind(labels, probas)
#conjunta  <- as.data.frame(conjunta)
#colnames(conjunta) <- c("Goles", "Freq")
#
#summary(conjunta)

#library(dplyr)

#conjunta <- mutate(conjunta, Freq = as.numeric(Freq))

#View(conjunta)

###########

#library(dplyr)

#conjunta <- mutate(conjunta, Freq = as.integer(Freq))

#?mutate

#warnings()
#unique(datos_gral)

#plot(x = datosgraf$Var1)

#hist(x = datosgraf$Var1)



#summary(datos_gral$FTHG)
#
#
#
#hist(datos_gral$FTHG)
#
#hist(datos_gral$FTHG, breaks = (seq(0,8, 0.5)), 
#     main = "Histograma de Mediciones",
#     xlab = "Mediciones",
#     ylab = "Frecuencia")

#datosgraf <- table((datos_gral$FTAG)/nrow(datos_gral))

#View(datosgraf)

#head(datosgraf)

#barplot(datosgraf)

#datos_gral <- select(datos_gral, FTHG, FTAG)

#as.data.frame(table(datos_gral)/nrow(datos_gral))


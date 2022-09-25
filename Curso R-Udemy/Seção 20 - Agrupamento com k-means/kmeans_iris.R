#AVALIAÇÃO DE CLUSTERS QUANDO TEM UMA BASE DE DADOS PARA CLASSIFICAÇÃO. 
base <- iris
base2 <- base[1:2]

set.seed(1)
kmeans <- kmeans(x = base2, centers = 3)

previsoes <- kmeans$cluster

library(cluster)
clusplot(base, previsoes, color = TRUE)

clusplot(base2, previsoes, color = TRUE)

table(base$Species, previsoes)
#Precisão de 82%
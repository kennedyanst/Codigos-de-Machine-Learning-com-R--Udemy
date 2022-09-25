idade <- c(20, 27, 21, 37, 46, 53, 55, 47, 52, 32, 39, 41, 39, 48, 48)
salario <- c(1000, 1200, 2900, 1850, 900, 950, 2000, 2100, 3000, 5900, 4100, 5100, 7000, 5000, 6500) 
base <- data.frame(idade, salario)

base <- scale(base)
plot(idade, salario)

hc <- hclust(d = dist(base, method = "euclidian"), method = "ward.D")
plot(hc, main = "Dendrograma", xlab = "Pessoas", ylab = "Distância")

previsoes <- cutree(hc, 3)
previsoes

library(cluster)
clusplot(base, previsoes)

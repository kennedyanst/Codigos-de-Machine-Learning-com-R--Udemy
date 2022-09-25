# COMO TRABALHAR COM AGRUPAMENTO NO K-MEANS, UTILIZANDO UMA BASE DE DADOS REAL
base <- read.csv("credit_card_clients.csv", header = TRUE)
base$BILL_TOTAL <- base$BILL_AMT1 + base$BILL_AMT2 + base$BILL_AMT3 + base$BILL_AMT4 + base$BILL_AMT5 + base$BILL_AMT6

X <- data.frame(limite = base$LIMIT_BAL, gast0 = base$BILL_TOTAL)

X <- scale(X) #Tem que escalonar pq o algoritmo trabalha com base em calculos de distância

#The Elbow Method = Metodo do cotovelo
set.seed(1)
wcss <- vector()
for (i in 1:10){
    kmeans <- kmeans( x = X, centers = i)
    wcss[i] <- sum(kmeans$withinss)
}
print(wcss)

plot(1:10, wcss, type = "b", xlab = "Clusters", ylab = "WCSS") #type = b: Vai fazer tanto o grafico de bolinha quanto o de linha. Ultilizar 4 ou 5 clusters

set.seed(1)
kmeans <- kmeans(x = X, centers = 5)
previsoes <- kmeans$cluster

plot(X, col = previsoes) #ANALIZAR OS GRUPOS.

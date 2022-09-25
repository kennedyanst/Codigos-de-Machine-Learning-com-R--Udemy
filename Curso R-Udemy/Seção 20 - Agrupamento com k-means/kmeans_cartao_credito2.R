base <- read.csv("credit_card_clients.csv", header = TRUE)
base$BILL_TOTAL <- base$BILL_AMT1 + base$BILL_AMT2 + base$BILL_AMT3 + base$BILL_AMT4 + base$BILL_AMT5 + base$BILL_AMT6

X <- data.frame(limete = base$LIMIT_BAL, gasto = base$BILL_TOTAL, genero = base$SEX,
    educacao = base$EDUCATION, civil = base$MARRIAGE, idade = base$AGE)

X <- scale(X)

set.seed(1)
wcss <- vector()
for (i in 1:10){
    kmeans <- kmeans( x = X, centers = i)
    wcss[i] <- sum(kmeans$withinss)
}

plot(1:10, wcss, type = "b", xlab = "Clusters", ylab = "WCSS") #type = b: Vai fazer tanto o grafico de bolinha quanto o de linha. Ultilizar 4 ou 5 clusters

set.seed(1)
kmeans <- kmeans(x = X, centers = 4)
previsoes <- kmeans$cluster

pairs(X, col = c(1:4)[previsoes]) #4 CORES BUSCADA DAS PREVISÕES

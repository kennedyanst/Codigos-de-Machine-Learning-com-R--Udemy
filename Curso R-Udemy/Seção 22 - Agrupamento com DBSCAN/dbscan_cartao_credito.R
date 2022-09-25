base <- read.csv("credit_card_clients.csv", header = TRUE)
base$BILL_TOTAL <- base$BILL_AMT1 + base$BILL_AMT2 + base$BILL_AMT3 + base$BILL_AMT4 + base$BILL_AMT5 + base$BILL_AMT6

X <- data.frame(limite = base$LIMIT_BAL, gasto = base$BILL_TOTAL)
X <- scale(X)

library(dbscan)
dbscan <- dbscan(X, eps = 0.37, minPts = 4)
previsoes <- dbscan$cluster

table(previsoes)

plot(X, col = previsoes)

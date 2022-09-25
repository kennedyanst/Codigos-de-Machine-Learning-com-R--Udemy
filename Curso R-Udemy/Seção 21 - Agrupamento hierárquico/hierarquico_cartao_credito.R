base <- read.csv("credit_card_clients.csv", header = TRUE)
base$BILL_TOTAL <- base$BILL_AMT1 + base$BILL_AMT2 + base$BILL_AMT3 + base$BILL_AMT4 + base$BILL_AMT5 + base$BILL_AMT6

X <- data.frame(limite = base$LIMIT_BAL, gasto = base$BILL_TOTAL)
X <- scale(X)

hc <- hclust(d = dist(X, method = "euclidian"), method = "ward.D")
plot(hc)

previsoes <- cutree(hc, 4)
plot(X, col = previsoes)
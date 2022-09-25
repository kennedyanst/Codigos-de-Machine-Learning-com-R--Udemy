base <- read.csv("risco_credito.csv")

install.packages("e1071")
library(e1071)

classificador <- naiveBayes(x = base[-5], y= base$risco)
#View(classificador)

#Exemplo 1: historia: boa, divida: alta, garantias: nenhuma, renda: >35
#Exemplo 2: historia: ruim, divida: alta, garantias: adequada, renda: <15


historia <- c("boa")
divida <- c("alta")
garantia <- c("nenhuma")
renda <- c("acima_35")
df <- data.frame(historia, divida, garantia, renda)


previsao <- predict(classificador, newdata = df, "raw")
print(previsao)


historia <- c("ruim")
divida <- c("alta")
garantia <- c("adequada")
renda <- c("0_15")
df1 <- data.frame(historia, divida, garantia, renda)
previsao1 <- predict(classificador, newdata = df1, "raw")

print(previsao1)

install.packages("languageserver")

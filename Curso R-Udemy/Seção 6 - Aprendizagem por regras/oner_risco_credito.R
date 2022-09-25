base <- read.csv("risco_credito.csv")


install.packages("OneR")
library(OneR)

classificador <- OneR(x = base)
print(classificador)

historia <- c("boa", "ruim")
divida <- c("alta", "alta")
garantias <- c("nenhuma", "adequada")
renda <- c("acima_35", "0_15")
df <- data.frame(historia, divida, garantias, renda)

previsoes <- predict(classificador, newdata = df)
print(previsoes)
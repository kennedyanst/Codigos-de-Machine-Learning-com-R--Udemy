base <- read.csv("risco_credito.csv")

#install.packages("rpart")
library(rpart)

classificador <- rpart(formula = risco ~ ., data = base, control = rpart.control(minbucket = 1))
print(classificador)
plot(classificador)
text(classificador)

install.packages("rpart.plot")
library(rpart.plot)

rpart.plot(classificador)


historia <- c("boa", "ruim")
divida <- c("alta", "alta")
garantias <- c("nenhuma", "adequada")
renda <- c("acima_35", "0_15")
df <- data.frame(historia, divida, garantia, renda)

previsoes <- predict(classificador, newdata = df)
print(previsoes)

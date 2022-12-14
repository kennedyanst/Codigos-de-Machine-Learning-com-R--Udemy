# Leitura da base de dados
base <- read.csv("credit_data copy.csv")

# Apaga a coluna clientid
base$clientid <- NULL

# Valores inconsistentes
base$age = ifelse(base$age < 0, 40.92, base$age)

# Valores faltantes
base$age = ifelse(is.na(base$age), mean(base$age, na.rm = TRUE), base$age)

# Escalonamento
base[, 1:3] <- scale(base[, 1:3])

# Encode da classe
base$default = factor(base$default, levels = c(0,1))

# Divisão entre treinamento e teste
library(caTools)
set.seed(1)
divisao <- sample.split(base$default, SplitRatio = 0.75)
base_treinamento <- subset(base, divisao == TRUE)
base_teste <- subset(base, divisao == FALSE)

library(caret)
pca <- preProcess(x = base_treinamento[-4], method = "pca", pcaComp = 2)
base_treinamento <- predict(pca, base_treinamento)
base_teste <- predict(pca, base_teste)

library(e1071)
classificador <- naiveBayes(x = base_treinamento[-1], y = base_treinamento$default)
previsoes <- predict(classificador, newdata = base_teste[-1])
matriz_confusao <- table(base_teste[, 1], previsoes)

confusionMatrix(matriz_confusao)
#NAIVE BAYES = 92% DE ACERTOS
#PCA = 88% DE ACERTOS
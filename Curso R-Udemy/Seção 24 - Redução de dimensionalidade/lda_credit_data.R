# Leitura da base de dados
base <- read.csv("credit_data copy.csv")
View(base)

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

library(MASS)
lda <- lda(formula = default ~ ., data = base_treinamento)
base_treinamento <- as.data.frame(predict(lda, base_treinamento))
base_treinamento <- base_treinamento[c(4,1)]
base_teste <- as.data.frame(predict(lda, base_teste))
base_teste <- base_teste[c(4,1)]

library(caret)
library(e1071)
classificador <- naiveBayes(x = base_treinamento[-2], y = base_treinamento$class)
previsoes <- predict(classificador, newdata = base_teste[-2])
matriz_confusao <- table(base_teste[, 2], previsoes)

confusionMatrix(matriz_confusao)
#Naive Bayes = 92%
#COM LDA = 98% (No video deu 99,4%!!)
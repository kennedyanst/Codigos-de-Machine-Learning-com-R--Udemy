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

#install.packages("kernlab")
library(kernlab)
kpca <- kpca(x = ~., data = base_treinamento[-4], kernel = "rbfdot", features = 2)
base_treinamento2 <- as.data.frame(predict(kpca, base_treinamento))
base_treinamento2$default <- base_treinamento$default
base_teste2 <- as.data.frame(predict(kpca, base_teste))
base_teste2$default <- base_teste$default


library(e1071)
classificador <- naiveBayes(x = base_treinamento2[-3], y = base_treinamento2$default)
previsoes <- predict(classificador, newdata = base_teste2[-3])
matriz_confusao <- table(base_teste2[, 3], previsoes)

confusionMatrix(matriz_confusao)
#Acerto de 0.866
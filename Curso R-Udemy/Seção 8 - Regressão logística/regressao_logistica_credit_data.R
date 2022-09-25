# Leitura da base de dados
base <- read.csv("credit_data copy.csv")

# Apaga a coluna clientid
base$clientid = NULL

# Valores inconsistentes
base$age = ifelse(base$age < 0, 40.92, base$age)

# Valores faltantes
base$age = ifelse(is.na(base$age), mean(base$age, na.rm = TRUE), base$age)

# Escalonamento
base[, 1:3] <- scale(base[, 1:3])

# Encode da classe
# base$default = factor(base$default, levels = c(0,1))

# Divisão entre treinamento e teste
library(caTools)
set.seed(1)
divisao <- sample.split(base$default, SplitRatio = 0.75)
base_treinamento <- subset(base, divisao == TRUE)
base_teste <- subset(base, divisao == FALSE)

#Usando o algoritimo de previsão
classificador <- glm(formula = default ~ ., family = binomial, data = base_treinamento) #Treinamento
probabilidades <- predict(classificador, type = "response", newdata = base_teste[-4]) #Teste
previsoes <- ifelse(probabilidades >0.5, 1, 0) #Se o resultado for maior que 0.5 ele é 1 se não é 0
matriz_de_confusao <- table(base_teste[, 4], previsoes) 

#Olhando a porcentagem de acerto do algoritmo 
library(caret)
confusionMatrix(matriz_de_confusao)
print(previsoes)

# Leitura da base de dados
base <- read.csv("credit_data copy.csv")

# Apaga a coluna clientid
base$clientid <- NULL

# Valores inconsistentes
base$age = ifelse(base$age < 0, 40.92, base$age)

# Valores faltantes
base$age = ifelse(is.na(base$age), mean(base$age, na.rm = TRUE), base$age)

# Escalonamento
#base[, 1:3] <- scale(base[, 1:3])

# Encode da classe
#base$default = factor(base$default, levels = c(0,1))

# Divisão entre treinamento e teste
library(caTools)
set.seed(1)
divisao <- sample.split(base$default, SplitRatio = 0.75)
base_treinamento <- subset(base, divisao == TRUE)
base_teste <- subset(base, divisao == FALSE)

#USANDO O CN2
#install.packages("RoughSets")
library(RoughSets)
dt_treinamento <- SF.asDecisionTable(dataset = base_treinamento, decision.attr = 4)
dt_teste <- SF.asDecisionTable(dataset = base_treinamento, decision.attr = 4)
intervalos <- D.discretization.RST(dt_treinamento, nOfIntervals = 4) #Transforma atributos númericos em categoricos

dt_treinamento <- SF.applyDecTable(dt_treinamento, intervalos)
dt_teste <- SF.applyDecTable(dt_teste, intervalos)
classificador <- RI.CN2Rules.RST(dt_treinamento, K = 5) # Vai dá erro pq ele não aceita atributos numericos e sim categoricos. Então não pode rodar o escalonamento.
#print(classificador)

previsoes <- predict(classificador, newdata = dt_teste[-4])
matriz_confusao <- table(dt_teste[, 4], unlist(previsoes))
print(matriz_confusao)

library(caret)
confusionMatrix(matriz_confusao)
# PRECISÃO DE 93,07%

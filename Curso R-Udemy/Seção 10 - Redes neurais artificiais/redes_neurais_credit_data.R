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
# base$default = factor(base$default, levels = c(0,1))

# Divisão entre treinamento e teste
library(caTools)
set.seed(1)
divisao <- sample.split(base$default, SplitRatio = 0.75)
base_treinamento <- subset(base, divisao == TRUE)
base_teste <- subset(base, divisao == FALSE)


# Aplicação da rede neural pela Biblioteca (H20)
#install.packages("h2o")
library(h2o)
h2o.init(nthreads = -1) # Inicializando o servidor em nuvem com o numero padrão de processamento (TODOS).
classificador <- h2o.deeplearning(y = "default", # Atributo classe a ser previsto. 
                                training_frame = as.h2o(base_treinamento), # Base de treino no padrão H2O
                                activation = "Rectifier", hidden = c(100, 100), # Função de ativação, Quantidade de neurônios em DUAS camadas ocultas. 
                                epochs = 1000) # Quantas vezes serão atualizadas os pesos. 
previsoes <- h2o.predict(classificador, newdata = as.h2o(base_teste[-4]))
previsoes <- (previsoes > 0.5) #Se for maior que 0.5 será uma clase, se for menor, será de outra. 
previsoes <- as.vector(previsoes) #Transformando em vetor 
matriz_confusao <- table(base_teste[, 4], previsoes) 
library(caret)
confusionMatrix(matriz_confusao)
#Precisão com 100 neurônios em uma camada oculta = 99.4%
#Precisão com 100 neurônios em duas camadas ocultas = 99.6%

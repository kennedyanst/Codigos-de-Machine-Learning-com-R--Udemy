base <- read.csv("house_prices.csv")
base$id = NULL
base$date = NULL
base$sqft_living15 = NULL
base$sqft_lot15 = NULL
base$sqft_basement = NULL

library(caTools)
set.seed(1)
divisao <- sample.split(base$price, SplitRatio = 0.70)
base_treinamento <- subset(base, divisao == TRUE)
base_teste <- subset(base, divisao == FALSE)

#CRIAÇÃO DO REGRESSOR
library(h2o)
h2o.init(nthreads = -1)
regressor <- h2o.deeplearning(y = "price", training_frame = as.h2o(base_treinamento), activation = "Rectifier", hidden = c(200, 200), epochs = 1000)

previsoes_treinamento <- predict(regressor, newdata = as.h2o(base_treinamento[-1]))
previsoes_treinamento <- as.vector(previsoes_treinamento)
library(miscTools)
cc_treinamento <- rSquared(base_treinamento[["price"]], resid = base_treinamento[["price"]] - previsoes_treinamento)


previsoes_teste <- predict(regressor, newdata = as.h2o(base_teste[-1]))
previsoes_teste <- as.vector(previsoes_teste)
mean(abs(base_teste[["price"]] - previsoes_teste))
cc_teste <- rSquared(base_teste[["price"]], resid = base_teste[["price"]] - previsoes_teste)
print(cc_treinamento)
print(cc_teste)

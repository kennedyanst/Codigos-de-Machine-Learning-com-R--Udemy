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

# CRIAÇÃO DO REGRESSOR
library(e1071)
regressor <- svm(formula = price ~., data = base_treinamento, type = "eps-regression", kernel = "radial")

previsoes_treinamento <- predict(regressor, newdata = base_treinamento[-1])
library(miscTools)
cc_treinamento <- rSquared(base_treinamento[["price"]], resid = base_treinamento[["price"]] - previsoes_treinamento)

previsoes_teste <- predict(regressor, newdata = base_teste[-1])
mean(abs(base_teste[["price"]] - previsoes_teste))
cc_teste <- rSquared(base_teste[["price"]], resid = base_teste[["price"]] - previsoes_teste)

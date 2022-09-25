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

regressor <- lm(formula = price ~., data = base_treinamento)
summary(regressor)

previsoes <- predict(regressor, newdata = base_teste[-1])
mean(abs(base_teste[["price"]] - previsoes)) #121K para cima ou para baixo

library(miscTools)
cc <- rSquared(base_teste[["price"]], resid = base_teste[["price"]] - previsoes)
print(cc) #PRECISÃO.

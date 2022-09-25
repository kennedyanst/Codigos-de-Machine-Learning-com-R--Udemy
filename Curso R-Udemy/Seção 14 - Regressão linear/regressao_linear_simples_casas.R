base <- read.csv("house_prices.csv")


library(caTools)
set.seed(1)
divisao <- sample.split(base$price, SplitRatio = 0.70)
base_treinamento <- subset(base, divisao == TRUE)
base_teste <- subset(base, divisao == FALSE)

regressor <- lm(formula = price ~ sqft_living, data =  base_treinamento) #Metragem quadrada para fazer a previsão do preço
summary(regressor)

previsoes_treinamento <- predict(regressor, newdata = base_treinamento[6])

library(ggplot2)
ggplot() + geom_point(aes(x = base_treinamento$sqft_living, y = base_treinamento$price), colour = "blue") +
        geom_line(aes(x = base_treinamento$sqft_living, y = previsoes_treinamento), colour = "red")


previsoes_teste <- predict(regressor, newdata = base_teste[6])
resultado <- abs(base_teste[3] - previsoes_teste)
mean(resultado[["price"]])#167k para cima ou para baixo

#install.packages("miscTools")
library(miscTools)
cr <- rSquared(base_teste[["price"]], resid = base_teste[["price"]] - previsoes_teste)
print(cr)
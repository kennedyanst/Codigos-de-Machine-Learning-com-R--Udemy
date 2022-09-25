base <- read.csv("plano_saude2.csv")

library(randomForest)
regressor <- randomForest(x = base[1], y = base$custo, ntree = 680)
summary(regressor)

previsoes <- predict(regressor, newdata = base[-2])
library(miscTools)
cc <- rSquared(base[["custo"]], resid = base[["custo"]] - previsoes)

x_teste <- seq(min(base$idade), max(base$idade), 0.01)
previsoes2 <- predict(regressor, newdata = data.frame(idade = x_teste))
ggplot() + geom_point(aes(x = base$idade, y = base$custo), colour = "blue") +
    geom_line(aes(x = x_teste, y = previsoes2), colour = "red")
print(cc)

df <- data.frame(idade = c(40))
previsao <- predict(regressor, newdata = df)
base <- read.csv("plano_saude2.csv")

library(rpart)
regressor <- rpart(formula = custo ~ idade, data = base, control = rpart.control(minsplit = 1)) #Com base na idade, queremos prever o custo! Minsplit = 1: Coloca dentro de um split somente 1 registro
summary(regressor)

previsoes <- predict(regressor, newdata = base[-2])
library(miscTools)
cc <- rSquared(base[["custo"]], resid = base[["custo"]] - previsoes)

library(ggplot2)
ggplot() + geom_point(aes(x= base$idade, y = base$custo), colour = "blue") +
    geom_line(aes(x= base$idade, y = previsoes), colour = "red")

x_teste <- seq(min(base$idade), max(base$idade), 0.1)
previsoes2 <- predict(regressor, newdata = data.frame(idade = x_teste))
ggplot() + geom_point(aes(x= base$idade, y = base$custo), colour = "blue") +
    geom_line(aes(x= base$idade, y = previsoes), colour = "red")

# PREVISÃO
df <- data.frame(idade = c(58))
previsao <- predict(regressor, newdata = df)
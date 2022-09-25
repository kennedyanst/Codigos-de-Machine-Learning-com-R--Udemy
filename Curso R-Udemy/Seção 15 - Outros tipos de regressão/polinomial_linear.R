base <- read.csv("plano_saude2.csv")

#REGRESSÃO LINEAR SIMPLES
regressor1 <- lm(formula = custo ~ idade, data = base)
summary(regressor1)
cc1 = summary(regressor1)$r.sqared

idade <- c(40)
df <- data.frame(idade)
previsao1 <- predict(regressor1, newdata = df)

library(ggplot2)
ggplot() + geom_point(aes(x = base$idade, y = base$custo), colour = "blue") +
    geom_line(aes(x = base$idade, y = predict(regressor1, newdata = base[-2])), colour = "red")


#REGRESSÃO LINEAR POLINOMIAL 
base2 <- base
base$idade2 = base2$idade^2
base2$idade3 = base2$idade^3

regressor2 <- lm(formula = custo ~ ., data = base2)
summary(regressor2)
cc2 <- summary(regressor2)$r.squared

#PREVISÃO
idade <- c(40)
idade2 <- c(40^2)
idade3 <- c(40^3)
df2 <- data.frame(idade, idade2, idade3)
previsao2 <- predict(regressor2, newdata = df2)
ggplot() + geom_point(aes(x = base$idade, y = base$custo), colour = "blue") +
    geom_line(aes(x = base$idade, y = predict(regressor2, newdata = base2[-2])), colour = "red")

base <- read.csv("plano_saude2.csv")

library(e1071)

regressor <- svm(formula = custo ~ idade, data = base, type = "eps-regression", kernel = "radial") #Radial é a unção que melhor se adapta. 
summary(regressor)

previsoes <- predict(regressor, newdata = base[-2])
library(miscTools)
cc <- rSquared(base[["custo"]], resid = base[["custo"]] - previsoes)

ggplot() + geom_point(aes(x = base$idade, y = base$custo), colour = "blue") +
    geom_line(aes(x = base$idade, y = previsoes), colour = "red")
print(cc)

df <- data.frame(idade = c(40))
preisao <- predict(regressor, newdata = df)
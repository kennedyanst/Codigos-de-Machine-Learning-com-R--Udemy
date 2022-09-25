base <- read.csv("plano_saude.csv")

cor(base$idade, base$custo) #CALCULANDO A CORRELAÇÃO

regressor <- lm(formula = custo ~ idade, data = base)
summary(regressor)

#Coefficients:
#            Estimate Std. Error t value Pr(>|t|)    
#(Intercept) -558.949    368.759  -1.516    0.168    
#idade         61.868      8.582   7.209 9.16e-05 *** Como idade tem mais estrelas, ele é o atributo com mais importância para a previsão

#Residual standard error: 389.7 on 8 degrees of freedom
#Multiple R-squared:  0.8666,    Adjusted R-squared:  0.8499 (Quanto mais proximo de 1, melhor a precisão) 
#F-statistic: 51.98 on 1 and 8 DF,  p-value: 9.161e-05

b0 <- regressor$coefficients[1]
b1 <- regressor$coefficients[2]
cr <- summary(regressor)$adj.r.squared

previsoes <- predict(regressor, newdata = base[-2])

print(previsoes)

#GERANDO O GRAFICO DA REGRESSÃO LINEAR
library(ggplot2)
ggplot() + geom_point(aes(x = base$idade, y = base$custo), colour = "blue") + 
        geom_line(aes(x = base$idade, y = previsoes), colour = "red") +
        ggtitle("Idade x Custo") + xlab("Idade") + ylab("Custo")


idade <- c(40)
df <- data.frame(idade)

#CALCULANDO AS PREVISÕES:
previsao1 <- predict(regressor, newdata = df)
print(previsao1)
previsao2 <- b0 + b1 * 40
print(previsao2)

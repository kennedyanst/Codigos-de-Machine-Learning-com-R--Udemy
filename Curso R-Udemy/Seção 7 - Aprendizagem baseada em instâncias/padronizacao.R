idade <- c(60,35,20)
renda <- c(30000, 45000, 29500)
base <- data.frame(idade, renda)

#MÉDIA
mean(base$idade)
mean(base$renda)

#Desvio padrão
sd(base$idade)
sd(base$renda)

#Faz o calculo da padronização
base <- scale(base)

#DADOS DE TREINO = income, age, loan. PREVISÃO = default
base <- read.csv("credit_data.csv")
#View(base)
base$clientid <- NULL
#View(base)
#summary(base)
#idade_invalida <- base[base$age < 0 & !is.na(base$age), ]
#View(idade_invalida)

# 1 apagar a coluna inteira
#base$age <- NULL

# 2 apagar somente os registros que estão com problemas
#base <- base[base$age > 0, ]
#View(base)

# 3 preencher os dados manualmente (MANEIRA MAIS CERTA DE TRATAR A BASE DE DADOS)

# 4 calcular a media da idade e preencher os dados faltantes
#mean(base$age, na.rm = TRUE)
#mean(base$age[base$age > 0], na.rm = TRUE)
base$age = ifelse(base$age < 0, 40.92, base$age)
#View(base$age)

#base[is.na(base$age), ]
#SE A IDADE FOR = A NULO, ENTÃO PREENCHA A MÉDIA. CASO CONTRARIO MANTENHA A IDADE PREENCHIDA
base$age = ifelse(is.na(base$age), mean(base$age, na.rm = TRUE), base$age)
#View(base)

#base <- scale(base)
#View(base)

base[, 1:3] <- scale(base[, 1:3])
View(base)

install.packages("caTools")
library(caTools)
set.seed(1)
divisao <- sample.split(base$default, SplitRatio = 0.75)
base_treinamento <- subset(base, divisao == TRUE)
base_teste <- subset(base, divisao == FALSE)



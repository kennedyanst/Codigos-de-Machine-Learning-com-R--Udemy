base <- read.csv("credit_data copy.csv")
base$clientid <- NULL
base$age = ifelse(base$age < 0, 40.92, base$age)
base$age = ifelse(is.na(base$age), mean(base$age, na.rm = TRUE), base$age)
base[, 1:3] <- scale(base[, 1:3])
base$default = factor(base$default, levels = c(0,1))

# VALIDAÇÃO CRUZADA DO NAIVE BAYES:
library(caret)
resultados30 <- c()
for (i in 1:30){
    controle_treinamento <- trainControl(method = "cv", number = 10)
    modelo <- train(default ~., data = base, trControl = controle_treinamento, method = "avNNet")
    precisao <- modelo$results$Accuracy[8]
    print(precisao)
    resultados30 <- c(resultados30, precisao)
}

for (i in 1:30){
    cat(gsub("[.]",",", resultados30[i]))
    cat("\n")
}


# TESTE DE FRIEDMAN E NEMENYI: Descobrindo se o algoritmo é cientificamente melhor que o outro. 
#require(TStools)
#dados <- read.csv("dados_teste1.csv")
#matriz <- as.matrix(dados)
#tsutils::nemenyi(matriz, conf.int = 0.95, plottype = "vline")
 
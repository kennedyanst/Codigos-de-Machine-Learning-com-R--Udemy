base <- read.csv("credit_data copy.csv")
base$clientid <- NULL
base$age = ifelse(base$age < 0, 40.92, base$age)
base$age = ifelse(is.na(base$age), mean(base$age, na.rm = TRUE), base$age)
base[, 1:3] <- scale(base[, 1:3])
base$default = factor(base$default, levels = c(0,1))

# VALIDAÇÃO CRUZADA DO NAIVE BAYES:
library(caret)
controle_treinamento <- trainControl(method = "cv", number = 10)
modelo <- train(default ~., data = base, trControl = controle_treinamento, method = "nb")
print(modelo)
#usekernel  Accuracy   Kappa    
#  FALSE      0.9260367  0.6538175
#   TRUE      0.9305243  0.6733955


# VALIDAÇÃO CRUZADA DA ÁRVORE DE DECISÃO
controle_treinamento <- trainControl(method = "cv", number = 10)
modelo <- train(default ~., data = base, trControl = controle_treinamento, method = "rpart")
print(modelo)
#  cp          Accuracy   Kappa    
#  0.05300353  0.9590022  0.8326733
#  0.09363958  0.9434995  0.7594574
#  0.28445230  0.8830362  0.2596606


# VALIDAÇÃO CRUZADA DO RANDOM FOREST
controle_treinamento <- trainControl(method = "cv", number = 10)
modelo <- train(default ~., data = base, trControl = controle_treinamento, method = "rf")
print(modelo)
#  mtry  Accuracy   Kappa
#  2     0.9890049  0.9545499
#  3     0.9900124  0.9595279


#VALIDAÇÃO CRUZADA DE ALGORITMOS POR REGRAS
controle_treinamento <- trainControl(method = "cv", number = 10)
modelo <- train(default ~., data = base, trControl = controle_treinamento, method = "C5.0Rules")
print(modelo)
#  Accuracy   Kappa
#  0.9884924  0.9524805


# VALIDAÇÃO CRUZADA DO KNN
controle_treinamento <- trainControl(method = "cv", number = 10)
modelo <- train(default ~., data = base, trControl = controle_treinamento, method = "knn")
print(modelo)
#  k  Accuracy   Kappa    
#  5  0.9804973  0.9192362
#  7  0.9794898  0.9144051
#  9  0.9799848  0.9172245


# VALIDAÇÃO CRUZADA DA REGRESSÃO LOGISTICA 
controle_treinamento <- trainControl(method = "cv", number = 10)
modelo <- train(default ~., data = base, trControl = controle_treinamento, method = "glm", family = "binomial")
print(modelo)
#  Accuracy  Kappa
#  0.947497  0.780231


# VALIDAÇÃO CRUZADA DO SVM com o RADIAL
controle_treinamento <- trainControl(method = "cv", number = 10)
modelo <- train(default ~., data = base, trControl = controle_treinamento, method = "svmRadial")
print(modelo)
#  C     Accuracy   Kappa    
#  0.25  0.9790023  0.9101139
#  0.50  0.9825048  0.9254653
#  1.00  0.9879974  0.9500860


# VALIDAÇÃO CRUZADA DA REDE NEURAL (Bibioteca avNNet)
controle_treinamento <- trainControl(method = "cv", number = 10)
modelo <- train(default ~., data = base, trControl = controle_treinamento, method = "avNNet")
print(modelo)
#  size  decay  Accuracy   Kappa
#  1     0e+00  0.8585036  0.0000000
#  1     1e-04  0.8874638  0.2369518
#  1     1e-01  0.9485019  0.7865440
#  3     0e+00  0.8585036  0.0000000
#  3     1e-04  0.9555721  0.6918761
#  3     1e-01  0.9959949  0.9835661
#  5     0e+00  0.8585036  0.0000000
#  5     1e-04  0.9975000  0.9898302
#  5     1e-01  0.9959949  0.9835067

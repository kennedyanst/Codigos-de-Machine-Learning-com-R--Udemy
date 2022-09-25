base <- read.csv("risco_credito.csv", header = T, stringsAsFactors = T) #Só assim para ler a base de dados. 
base <- base[base$risco != "moderado", ]

classificador <- glm(formula = risco ~ ., family = binomial, data = base) #Treinamento da base de dados

historia <- c("boa", "ruim")
divida <- c("alta", "alta")
garantias <- c("nenhuma", "adequada")
renda <- c("acima_35", "0_15")
df <- data.frame(historia, divida, garantias, renda)

probabilidades <- predict(classificador, type = "response", newdata = df)
resposta <- ifelse(probabilidades > 0.5, "baixo", "alto")
print(resposta)

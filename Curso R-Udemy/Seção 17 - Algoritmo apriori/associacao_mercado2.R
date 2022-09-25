library(arules)

base <- read.transactions("mercado2.csv", sep = ",", rm.duplicates = TRUE) #rm.duplicates = TRUE: Retirar os PRODUTOS duplicados de uma mesma transação
summary(base)

itemFrequencyPlot(base, topN = 20)

regras <- apriori(data = base, parameter = list(support = 0.003, confidence = 0.2)) #Dados grandes tem a ter um numero de suporte muito baixo e a confiança tb baixa. 

inspect(sort(regras, by = "confidence")[1:10])

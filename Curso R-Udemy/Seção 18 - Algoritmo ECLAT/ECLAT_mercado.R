library(arules)

base <- read.transactions("mercado2.csv", sep = ",", rm.duplicates = TRUE)

itemsets <- eclat(data = base, parameter = list(support = 0.003, minlen = 3))

inspect(sort(itemsets, by = "support"))

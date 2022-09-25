#UMA VARIAVEL SOMENTE 
base <- read.csv("credit_data copy.csv")

#OUTLIER IDADE
boxplot(base$age, outline = TRUE)
boxplot.stats(base$age)$out
outlier_age <- base[base$age < 0, ]

#OUTLIER LOAN
boxplot(base$loan)
boxplot.stats(base$loan)$out
outliers_loan <- base[base$loan > 13100,]

#OUTLIER INCOME 
boxplot(base$income)

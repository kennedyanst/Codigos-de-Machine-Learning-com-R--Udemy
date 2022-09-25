credit <- read.csv("credit_data copy.csv")
census <- read.csv("census copy.csv")

install.packages("outliers")
library(outliers)


#INFERIOR
outlier(credit$age)
#SUPERIOR
outlier(credit$age, opposite = TRUE)


#income
outlier(credit$income)
outlier(credit$income, opposite = TRUE)


#loan
outlier(credit$loan)
outlier(credit$loan, opposite = TRUE)


#CENSUS
outlier(census$age)
outlier(census$final.weigth)

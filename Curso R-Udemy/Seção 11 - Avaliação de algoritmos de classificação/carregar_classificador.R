base <- read.csv("credit_data copy.csv")
base$clientid <- NULL
base$age = ifelse(base$age < 0, 40.92, base$age)
base$age = ifelse(is.na(base$age), mean(base$age, na.rm = TRUE), base$age)
base[, 1:3] <- scale(base[, 1:3])
base$default = factor(base$default, levels = c(0,1))

rfFinal <- readRDS("rfFinal.rds")
previsoesrf <- predict(rfFinal, newdata = base[1, -4])

rnaFinal <- readRDS("rnaFinal.rds")
previsoesrna <- predict(rnaFinal, newdata = as.h2o(base[-4]))
print(previsoesrna)

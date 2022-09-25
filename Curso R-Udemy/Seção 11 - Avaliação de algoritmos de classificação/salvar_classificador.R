base <- read.csv("credit_data copy.csv")
base$clientid <- NULL
base$age = ifelse(base$age < 0, 40.92, base$age)
base$age = ifelse(is.na(base$age), mean(base$age, na.rm = TRUE), base$age)
base[, 1:3] <- scale(base[, 1:3])
base$default = factor(base$default, levels = c(0,1))

library(randomForest)
classificadorRandomForest <- randomForest(x = base[-4], y = base$default, ntree = 30, mtry = 2)

library(h2o)
h2o.init(nthreads = -1)
classificadorRedeNeural <- h2o.deeplearning(y = "default", training_frame = as.h2o(base), activation = "Rectifier", hidden = c(100), epochs = 100)
print(classificadorRedeNeural)

saveRDS(classificadorRandomForest, "rfFinal.rds")
saveRDS(classificadorRedeNeural, "rnaFinal.rds")
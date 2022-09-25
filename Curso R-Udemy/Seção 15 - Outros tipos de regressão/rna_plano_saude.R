base <- read.csv("plano_saude2.csv")

library(h2o)
h2o.init(nthreads = -1)
regressor <- h2o.deeplearning(y = "custo", training_frame = as.h2o(base), activation = "Rectifier", 
                                hidden = c(200, 200), epochs = 3000)

previsoes <- h2o.predict(regressor, newdata = as.h2o(base[-2]))
previsoes <- as.vector(previsoes)

library(miscTools)
cc <- rSquared(base[["custo"]], resid = base[["custo"]] - previsoes)
print(cc)

ggplot() + geom_point(aes(x = base$idade, y = base$custo), colour = "blue") +
    geom_line(aes(x = base$idade, y = previsoes), colour = "red")

df <- as.h2o(data.frame(idade = c(40)))
previsao <- predict(regressor, newdata = df)
previsao <- as.vector(previsao)
print(previsao)

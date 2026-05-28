# ==============================================================================
# Teoria do Aprendizado Estatístico
# Rodolfo Vinicius Cima Takemoto
# ==============================================================================


#Regressão Logìstica

rm(list=ls())


#carregar bibliotecas

library(caret)
library(pROC)


#Carregar dados da biblioteca ISLR

ISLR::Smarket
dados2 <- ISLR::Smarket
names (dados2)


#Gerando o Modelo

modelologistico01 <- glm (Direction~. -Today,
                       data = dados2, family = binomial)

formula(modelologistico01)
summary(modelologistico01)




#regressão Logistica

#bibliotecas

library(caret)

library(pROC)

#carregar dados da biblioteca ISLR

ISLR::Smarket

dados2<-ISLR::Smarket

names(dados2)

str(dados2)

nrow(dados2)

seq_len(nrow(dados2))


#separando em treino e teste

set.seed(123) # reprodutibilidade

particao <- sample(seq_len(nrow(dados2)), size = 0.7*nrow(dados2))

dados2treino <- dados2[particao, ]

dados2teste  <- dados2[-particao, ]

prop.table(table(dados2treino$Direction)); 

prop.table(table(dados2teste$Direction))

#apresentando o comportamento dos dados

pairs(dados2,col=dados2$Direction)

# Visualização básica (histograma balance por default)

ggplot(dados2, aes(Lag3, fill = Direction)) +
  
  geom_histogram(bins = 30, alpha = .8, position = "identity") +
  
  labs(title = "Distribuição de Direction por Today", x = "Direction", y = "Contagem")

#gerando o modelo

modelologistio01<-glm(Direction~.-Today,
                      
                      data = dados2treino, 
                      
                      family = binomial)

formula(modelologistio01)

summary(modelologistio01)


#predição

prob_modelologistico01<-predict(modelologistio01,
                                
                                newdata = dados2teste, 
                                
                                type = "response")

summary(prob_modelologistico01)

length(prob_modelologistico01)

#usando a melhor coordenada

prob_modelologistico01

resposta_modelologistico01<-ifelse(prob_modelologistico01 < 0.5,
                                   
                                   "Down",
                                   
                                   "Up")

resposta_modelologistico01<-as.factor(resposta_modelologistico01)

prop.table(table(resposta_modelologistico01==dados2teste$Direction))

length(resposta_modelologistico01)

length(dados2teste$Direction)

#criando data.frama

tabelamatrizconfusao<-data.frame(real=dados2teste$Direction,predicao =resposta_modelologistico01)

tabelamatrizconfusao$real==tabelamatrizconfusao$predicao

acuracia<-mean(tabelamatrizconfusao$real==tabelamatrizconfusao$predicao)

tabelamatrizconfusao[tabelamatrizconfusao$real=="Up",1]==tabelamatrizconfusao[tabelamatrizconfusao$real=="Up",2]

sensibilidade<-mean(tabelamatrizconfusao[tabelamatrizconfusao$real=="Up",1]==tabelamatrizconfusao[tabelamatrizconfusao$real=="Up",2])


tabelamatrizconfusao[tabelamatrizconfusao$real=="Down",]

especificidade<-mean(tabelamatrizconfusao[tabelamatrizconfusao$real=="Down",1]==tabelamatrizconfusao[tabelamatrizconfusao$real=="Down",2])


#criando a matriz confusão

tabela_predicao <- table(Predito = resposta_modelologistico01,
                         
                         Real = dados2teste$Direction)

tabela_predicao

sensibilidade001<-tabela_predicao[2,2]/sum(tabela_predicao[,2])

especificidade001<-tabela_predicao[1,1]/sum(tabela_predicao[,1])

acuracia001<-(tabela_predicao[1,1]+tabela_predicao[2,2])/sum(tabela_predicao[,])


tabela_predicao

as.factor(dados2treino$Direction[1])

dados2treino$Direction[1]


#matriz confusão

confusionMatrix(as.factor(resposta_modelologistico01),
                
                dados2teste$Direction,
                
                positive= "Down")

Exercícios
#Cosntruir a Regressão Logistica básico sem particionar os dados em treino e teste:
# a) ISLR::Default, definindo como variável dependente student
# b) ISLR2::Smarket, definindo como variável dependente Direction
# c) ISLR2::Weekly, definindo como variável dependente Direction
# d) ISLR2::Caravan, definindo como variável dependente Purchase


rm(list=ls())
library(ISLR)
library(ISLR2)
library(caret)

# ------------------------------------------------------------------------------
# a) ISLR::Default - Variável dependente: student
# ------------------------------------------------------------------------------
dados_a <- ISLR::Default

# Gerando o modelo
modelo_a <- glm(student ~ ., data = dados_a, family = binomial)
summary(modelo_a)

# Predição (Probabilidades)
prob_a <- predict(modelo_a, type = "response")

# Transformando em classe (ponto de corte 0.5)
pred_a <- ifelse(prob_a > 0.5, "Yes", "No")
pred_a <- as.factor(pred_a)

# Matriz de Confusão
confusionMatrix(pred_a, dados_a$student, positive = "Yes")


# ------------------------------------------------------------------------------
# b) ISLR2::Smarket - Variável dependente: Direction
# ------------------------------------------------------------------------------
dados_b <- ISLR2::Smarket

# Gerando o modelo (Removendo Today para evitar correlação perfeita)
modelo_b <- glm(Direction ~ . - Today, data = dados_b, family = binomial)

prob_b <- predict(modelo_b, type = "response")
pred_b <- ifelse(prob_b > 0.5, "Up", "Down")
pred_b <- as.factor(pred_b)

confusionMatrix(pred_b, dados_b$Direction, positive = "Up")


# ------------------------------------------------------------------------------
# c) ISLR2::Weekly - Variável dependente: Direction
# ------------------------------------------------------------------------------
dados_c <- ISLR2::Weekly

# Gerando o modelo
modelo_c <- glm(Direction ~ . - Today, data = dados_c, family = binomial)

prob_c <- predict(modelo_c, type = "response")
pred_c <- ifelse(prob_c > 0.5, "Up", "Down")
pred_c <- as.factor(pred_c)

confusionMatrix(pred_c, dados_c$Direction, positive = "Up")


# ------------------------------------------------------------------------------
# d) ISLR2::Caravan - Variável dependente: Purchase
# ------------------------------------------------------------------------------
dados_d <- ISLR2::Caravan

# Gerando o modelo (Este dataset é grande, pode demorar alguns segundos)
modelo_d <- glm(Purchase ~ ., data = dados_d, family = binomial)

prob_d <- predict(modelo_d, type = "response")
pred_d <- ifelse(prob_d > 0.5, "Yes", "No")
pred_d <- as.factor(pred_d)

confusionMatrix(pred_d, dados_d$Purchase, positive = "Yes")

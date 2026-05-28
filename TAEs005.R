# ==============================================================================
# Teoria do Aprendizado Estatístico - Particionamento Treino/Teste
# Rodolfo Vinicius Cima Takemoto
# ==============================================================================

rm(list=ls())
library(ISLR)
library(ISLR2)
library(caret)

# Função auxiliar para não repetir código em cada exercício
# ---------------------------------------------------------
executar_logistica_rodolfo <- function(dados, formula_modelo, label_positivo) {
  set.seed(123) # Para o resultado ser sempre igual
  
  # 1. Particionamento (70% Treino / 30% Teste)
  index <- sample(seq_len(nrow(dados)), size = 0.7 * nrow(dados))
  treino <- dados[index, ]
  teste  <- dados[-index, ]
  
  # 2. Treinamento
  modelo <- glm(formula_modelo, data = treino, family = binomial)
  
  # 3. Predição no Teste
  prob <- predict(modelo, newdata = teste, type = "response")
  pred <- ifelse(prob > 0.5, levels(dados[[all.vars(formula_modelo)[1]]])[2], 
                 levels(dados[[all.vars(formula_modelo)[1]]])[1])
  
  # 4. Avaliação
  confusionMatrix(as.factor(pred), teste[[all.vars(formula_modelo)[1]]], 
                  positive = label_positivo)
}

# --- Execução dos Exercícios ---

# a) ISLR::Default (student)
cat("\n--- RESULTADO DEFAULT ---")
executar_logistica_rodolfo(ISLR::Default, student ~ ., "Yes")

# b) ISLR2::Smarket (Direction) - Removendo 'Today'
cat("\n--- RESULTADO SMARKET ---")
executar_logistica_rodolfo(ISLR2::Smarket, Direction ~ . - Today, "Up")

# c) ISLR2::Weekly (Direction) - Removendo 'Today'
cat("\n--- RESULTADO WEEKLY ---")
executar_logistica_rodolfo(ISLR2::Weekly, Direction ~ . - Today, "Up")

# d) ISLR2::Caravan (Purchase)
cat("\n--- RESULTADO CARAVAN ---")
executar_logistica_rodolfo(ISLR2::Caravan, Purchase ~ ., "Yes")


#regressão Logistica
#bibliotecas
library(caret)
library(pROC)

#carregar dados da biblioteca ISLR
ISLR::Smarket
dados2<-ISLR::Smarket
names(dados2)

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
prob_modelologistico01
dados2$Direction

#ROC, AUC e escolha de limiar (método de Youden)
roc_obj <- roc(response = dados2teste$Direction , 
               predictor = prob_modelologistico01, 
               levels = c("Down","Up"), 
               direction = "<")


plot(roc_obj, main = sprintf("ROC - Default (AUC = %.3f)", auc(roc_obj)))
melhor_coordenada<- coords(roc_obj, "best", ret = c("threshold","sensitivity","specificity"))

#melhor coordenanda balanceada
round(roc_obj$sensitivities, digits = 2)==round(roc_obj$specificities, digits = 2)
roc_obj$thresholds[round(roc_obj$sensitivities, digits = 2)==round(roc_obj$specificities, digits = 2)]
which(round(roc_obj$sensitivities, digits = 2)==round(roc_obj$specificities, digits = 2))
roc_obj$thresholds[187]

#melhor coordenada pensando na melhor acuracia
roc_obj$sensitivities+roc_obj$specificities
which.max(roc_obj$sensitivities+roc_obj$specificities)
melhor_coordenada2<-roc_obj$thresholds[which.max(roc_obj$sensitivities+roc_obj$specificities)]

#apresentação da busca do melhor valor
plot(1:376,roc_obj$sensitivities, col="blue",lwd=1)
lines(1:376,roc_obj$specificities, col="red",lwd=2)
lines(1:376,roc_obj$sensitivities, col="blue",lwd=1)
abline(h=roc_obj$thresholds[187])
roc_obj$thresholds
melhor_coordenada

#apresentação da busca do melhor valor
plot(roc_obj$sensitivities,1:376, col="white",lwd=1)
lines(roc_obj$specificities,1:376, col="red",lwd=2)
lines(roc_obj$sensitivities,1:376, col="blue",lwd=1)
abline(v=roc_obj$thresholds[188], col="green")
abline(v=melhor_coordenada[1], col="blue")
abline(v=melhor_coordenada2, col="brown")
abline(v=0.5, col="black")

melhor_coordenada[1]
melhor_coordenada2

roc_obj$thresholds[187]
melhor_coordenada
melhor_coordenada1<-roc_obj$thresholds[188]



#usando a melhor coordenada
prob_modelologistico01
as.numeric(melhor_coordenada[1])
resposta_modelologistico01<-ifelse(prob_modelologistico01 < as.numeric(melhor_coordenada[1]),
                                   "Down",
                                   "Up")
resposta_modelologistico01<-as.factor(resposta_modelologistico01)

prop.table(table(resposta_modelologistico01==dados2teste$Direction))
length(resposta_modelologistico01)
length(dados2teste$Direction)

# Matriz de confusão e métricas com limiar escolhido")
thr <- melhor_coordenada["threshold"]
pred_class <- ifelse(prob_modelologistico01 > as.numeric(thr), "Up", "Down")
tabela_predicao <- table(Predito = pred_class, Real = dados2teste$Direction)
tabela_predicao

accuracy <- mean(pred_class == dados2teste$Direction)
sensitivity <- mean(pred_class[dados2teste$Direction=="Down"] == "Down")
specificity <- mean(pred_class[dados2teste$Direction=="Up"]  == "Up")
c(accuracy = accuracy, sensitivity = sensitivity, specificity = specificity)

accuracy1 <-(tabela_predicao[1,1]+tabela_predicao[2,2])/(sum(tabela_predicao)) 
sensitivity1 <-(tabela_predicao[1,1]/sum(tabela_predicao[,1]))
specificity1 <- (tabela_predicao[2,2]/sum(tabela_predicao[,2]))
c(accuracy1 = accuracy1, sensitivity1 = sensitivity1, specificity1 = specificity1)


# Matriz de confusão e métricas com limiar escolhido)
thr <- melhor_coordenada1

pred_class <- ifelse(prob_modelologistico01 > as.numeric(thr), "Up", "Down")
tabela_predicao <- table(Predito = pred_class, Real = dados2teste$Direction)
tabela_predicao

accuracy <- mean(pred_class == dados2teste$Direction)
sensitivity <- mean(pred_class[dados2teste$Direction=="Down"] == "Down")
specificity <- mean(pred_class[dados2teste$Direction=="Up"]  == "Up")
c(accuracy = accuracy, sensitivity = sensitivity, specificity = specificity)

accuracy1 <-(tabela_predicao[1,1]+tabela_predicao[2,2])/(sum(tabela_predicao)) 
sensitivity1 <-(tabela_predicao[1,1]/sum(tabela_predicao[,1]))
specificity1 <- (tabela_predicao[2,2]/sum(tabela_predicao[,2]))
c(accuracy1 = accuracy1, sensitivity1 = sensitivity1, specificity1 = specificity1)


#pacote caret com informações sobre acuracia e afins
resumo<-confusionMatrix(resposta_modelologistico01, dados2teste$Direction)
resumo
resumo$table
resumo$overall
resumo$byClass

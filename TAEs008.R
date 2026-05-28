# ==============================================================================
# AVALIAÇÃO: Árvores de Decisão e Regressão Logística Multiclasse
# ALUNO: Rodolfo Vinicius Cima Takemoto
# ==============================================================================

# --- PASSO 1: LIMPEZA E CONFIGURAÇÃO ---

rm(list=ls()) 

library(ggplot2)
library(mlbench)
library(palmerpenguins)
library(rpart)
library(rpart.plot)
library(caret)
library(nnet)

SEMENTE_RODOLFO <- 123

# ==============================================================================
# EXERCÍCIO 1: ÁRVORE DE REGRESSÃO (BASE DIAMONDS)
# ==============================================================================
cat("\n--- EXERCÍCIO 1: ÁRVORE DE REGRESSÃO (DIAMONDS) ---\n")

data(diamonds, package = "ggplot2")
df_diamonds <- as.data.frame(diamonds)

set.seed(SEMENTE_RODOLFO)
index_dia <- createDataPartition(df_diamonds$price, p = 0.7, list = FALSE)
treino_dia <- df_diamonds[index_dia, ]
teste_dia  <- df_diamonds[-index_dia, ]

arvore_regressao <- rpart(price ~ ., data = treino_dia, method = "anova")

cat("Gerando o gráfico da árvore de regressão...\n")
rpart.plot(arvore_regressao, main = "Árvore de Regressão - Preço de Diamantes", 
           box.palette = "GnBu", shadow.col = "gray", nn = TRUE)

pred_dia <- predict(arvore_regressao, newdata = teste_dia)
metricas_dia <- postResample(pred_dia, teste_dia$price)
print(metricas_dia)


# ==============================================================================
# EXERCÍCIO 2: ÁRVORE DE CLASSIFICAÇÃO COM PODA (BASE SONAR)
# ==============================================================================
cat("\n--- EXERCÍCIO 2: ÁRVORE DE CLASSIFICAÇÃO (SONAR) ---\n")

data(Sonar, package = "mlbench")
df_sonar <- Sonar

set.seed(SEMENTE_RODOLFO)
index_son <- createDataPartition(df_sonar$Class, p = 0.7, list = FALSE)
treino_son <- df_sonar[index_son, ]
teste_son  <- df_sonar[-index_son, ]

# 2.1 Criando a árvore complexa inicial
arvore_sonar_completa <- rpart(Class ~ ., data = treino_son, method = "class", 
                               control = rpart.control(cp = 0.001))

cat("Visualizando a tabela de Cp (Complexidade) para escolher a poda:\n")
printcp(arvore_sonar_completa)

# Encontrando o CP associado ao menor erro de validação cruzada (xerror) automaticamente
melhor_cp <- arvore_sonar_completa$cptable[which.min(arvore_sonar_completa$cptable[,"xerror"]),"CP"]
cat("O melhor valor de CP encontrado para a poda foi:", melhor_cp, "\n")

# 2.2 Aplicando a Poda (Pruning)
arvore_sonar_podada <- prune(arvore_sonar_completa, cp = melhor_cp)

# 2.3 Apresentação dos Gráficos (Antes vs Depois)
cat("Gerando os gráficos comparativos da árvore...\n")
par(mfrow = c(1, 2)) # Divide a tela de plots em duas colunas
rpart.plot(arvore_sonar_completa, main = "Sonar - Sem Poda (Complexa)", box.palette = "RdYlGn")
rpart.plot(arvore_sonar_podada, main = "Sonar - Pós-Poda (Otimizada)", box.palette = "RdYlGn")
par(mfrow = c(1, 1)) # Restaura a tela de plots para o padrão

# 2.4 Predições com a árvore otimizada
pred_son <- predict(arvore_sonar_podada, newdata = teste_son, type = "class")

cat("\nMatriz de Confusão com a Árvore Otimizada (Sonar):\n")
cm_sonar <- confusionMatrix(pred_son, teste_son$Class, positive = "M")
print(cm_sonar$table)
print(cm_sonar$overall[c("Accuracy", "Kappa")])


# ==============================================================================
# EXERCÍCIO 3: REGRESSÃO LOGÍSTICA MULTICLASSE (BASE PENGUINS)
# ==============================================================================
cat("\n--- EXERCÍCIO 3: REGRESSÃO LOGÍSTICA MULTINOMIAL (PENGUINS) ---\n")

data(penguins, package = "palmerpenguins")
df_penguins_raw <- as.data.frame(penguins)

colunas_alvo <- c("species", "bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g")
df_penguins <- na.omit(df_penguins_raw[, colunas_alvo])

set.seed(SEMENTE_RODOLFO)
index_pen <- createDataPartition(df_penguins$species, p = 0.7, list = FALSE)
treino_pen <- df_penguins[index_pen, ]
teste_pen  <- df_penguins[-index_pen, ]

modelo_multinomial <- multinom(species ~ bill_length_mm + bill_depth_mm + 
                                 flipper_length_mm + body_mass_g, 
                               data = treino_pen, trace = FALSE)

cat("Coeficientes obtidos para as classes:\n")
print(summary(modelo_multinomial)$coefficients)

pred_pen <- predict(modelo_multinomial, newdata = teste_pen)

cat("\nMatriz de Confusão Multiclasse (Pinguins):\n")
cm_pen <- confusionMatrix(pred_pen, teste_pen$species)
print(cm_pen$table)
cat("\nAcurácia Global:", round(cm_pen["overall"]$overall["Accuracy"], 4), "\n")

cat("\n==================== FIM DO SCRIPT ====================\n")


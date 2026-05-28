# ==============================================================================
# PROJETO: Modelagem Preditiva e Otimização Estatística
# ALUNO: Rodolfo Vinicius Cima Takemoto
# ==============================================================================

# --- 0. CONFIGURAÇÃO E BIBLIOTECAS ---
rm(list=ls())
library(ISLR)
library(ISLR2)
library(caret)
library(pROC)
library(ggplot2)

# Definindo diretório padrão
setwd("C:/Users/takem/Documents/Projeto Integrador")

# ==============================================================================
# BLOCO 1: SELEÇÃO DE VARIÁVEIS (STEPWISE) - MODELOS LINEARES
# ==============================================================================

# --- 1.1 Dataset MTCARS (Exemplo Base) ---
dados_mt <- mtcars
mod_vazio_mt <- lm(mpg ~ 1, data = dados_mt)
mod_cheio_mt <- lm(mpg ~ wt + hp + disp + drat + qsec + cyl + vs + am + gear + carb, data = dados_mt)

step_both_mt <- step(mod_vazio_mt, scope = formula(mod_cheio_mt), direction = "both", trace = 0)
cat("\n--- Melhor Fórmula MTCARS (MPG) ---\n")
print(formula(step_both_mt))

# --- 1.2 Dataset AUTO (Alvo: Displacement) ---
dados_auto <- ISLR::Auto
dados_auto <- dados_auto[, -9] # Remove 'name'

mod_vazio_auto <- lm(displacement ~ 1, data = dados_auto)
mod_cheio_auto <- lm(displacement ~ ., data = dados_auto)

step_auto <- step(mod_vazio_auto, scope = formula(mod_cheio_auto), direction = "both", trace = 0)
cat("\n--- Melhor Fórmula AUTO (Displacement) ---\n")
print(formula(step_auto))

# --- 1.3 Dataset CARSEATS (Alvo: Price) ---
dados_car <- ISLR::Carseats
mod_vazio_car <- lm(Price ~ 1, data = dados_car)
mod_cheio_car <- lm(Price ~ ., data = dados_car)

step_car <- step(mod_vazio_car, scope = formula(mod_cheio_car), direction = "both", trace = 0)
cat("\n--- Melhor Fórmula CARSEATS (Price) ---\n")
print(formula(step_car))

# --- 1.4 Dataset HITTERS (Alvo: Salary) ---
dados_hit <- na.omit(ISLR::Hitters) # Limpeza de NAs obrigatória
mod_vazio_hit <- lm(Salary ~ 1, data = dados_hit)
mod_cheio_hit <- lm(Salary ~ ., data = dados_hit)

step_hit <- step(mod_vazio_hit, scope = formula(mod_cheio_hit), direction = "both", trace = 0)
cat("\n--- Melhor Fórmula HITTERS (Salary) ---\n")
print(formula(step_hit))


# ==============================================================================
# BLOCO 2: REGRESSÃO LOGÍSTICA E OTIMIZAÇÃO DE THRESHOLD (ROC)
# ==============================================================================

# Função auxiliar para automatizar a otimização via Índice de Youden
otimizar_modelo <- function(dados, formula_obj, pos_ref, titulo) {
  cat("\n------------------------------------------------------------\n")
  cat("OTIMIZANDO:", titulo, "\n")
  
  # 1. Ajuste do Modelo Logístico
  modelo <- glm(formula_obj, data = dados, family = binomial)
  
  # 2. Predição de Probabilidades
  probs <- predict(modelo, type = "response")
  
  # 3. Curva ROC e Melhor Threshold (Youden)
  niveis <- levels(dados[[all.vars(formula_obj)[1]]])
  obj_roc <- roc(response = dados[[all.vars(formula_obj)[1]]], 
                 predictor = probs, levels = niveis, quiet = TRUE)
  
  # Coordenada "best" maximiza Sensibilidade + Especificidade
  melhor_coord <- coords(obj_roc, "best", ret = c("threshold", "sensitivity", "specificity"))
  thr_ideal <- as.numeric(melhor_coord["threshold"])
  
  # 4. Classificação com novo Threshold
  pred_otim <- factor(ifelse(probs > thr_ideal, niveis[2], niveis[1]), levels = niveis)
  
  # 5. Resultados
  cat("Threshold Otimizado:", round(thr_ideal, 4), "| AUC:", round(auc(obj_roc), 4), "\n")
  cm <- confusionMatrix(pred_otim, dados[[all.vars(formula_obj)[1]]], positive = pos_ref)
  print(cm$table)
  print(cm$byClass[c("Sensitivity", "Specificity")])
  
  # Plot opcional da ROC
  plot(obj_roc, main = paste("ROC -", titulo), col = "darkblue", lwd = 2)
}

# --- Execução das Otimizações ---

# a) Default (student)
otimizar_modelo(ISLR::Default, student ~ ., "Yes", "Default (Student)")

# b) Smarket (Direction) - Removendo 'Today'
otimizar_modelo(ISLR2::Smarket, Direction ~ . - Today, "Up", "Smarket")

# c) Weekly (Direction) - Removendo 'Today'
otimizar_modelo(ISLR2::Weekly, Direction ~ . - Today, "Up", "Weekly")

# d) Caravan (Purchase) - Otimização crítica para classes raras
otimizar_modelo(ISLR2::Caravan, Purchase ~ ., "Yes", "Caravan")

cat("\n==================== FIM DO SCRIPT MESTRE ====================\n")


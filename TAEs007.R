# ==============================================================================
# PROJETO: Modelagem Preditiva (Linear e Logística)
# ALUNO: Rodolfo Vinicius Cima Takemoto
# DIRETÓRIO: C:/Users/takem/Documents/Projeto Integrador/TAE/DataFrame
# ==============================================================================

# --- 0. CONFIGURAÇÃO E BIBLIOTECAS ---
rm(list=ls())
library(caret)
library(pROC)

# Configurando o Diretório de Trabalho
setwd("C:\Users\takem\OneDrive\Documentos\FATEC\TAE\DataFrame")

# Função técnica para tratar a formatação dos seus arquivos CSV
limpar_numeros <- function(coluna) {
  if(is.character(coluna)) {
    x <- gsub("\\.", "", coluna) 
    return(as.numeric(x) / 10^14) 
  }
  return(coluna)
}

# ==============================================================================
# EXERCÍCIO 1: AUTO MPG (CONSUMO)
# ==============================================================================
cat("\n--- EXERCÍCIO 1: AUTO MPG ---\n")

# Carregamento do arquivo específico
dados001 <- read.csv("Rodolfo Takemoto - autos.csv - Rodolfo Takemoto - autos.csv.csv")

# Tratamento de dados
dados001$origin <- as.factor(dados001$origin)
cols_num_auto <- c("mpg", "displacement", "horsepower", "weight", "acceleration")
dados001[cols_num_auto] <- lapply(dados001[cols_num_auto], limpar_numeros)

# Modelo e Otimização
modelo_auto <- lm(mpg ~ . - name, data = dados001)
step_auto <- step(modelo_auto, direction = "both", trace = 0)

cat("Melhor fórmula selecionada (mpg):\n")
print(formula(step_auto))
summary(step_auto)


# ==============================================================================
# EXERCÍCIO 2: BOSTON HOUSING (PREÇO DE IMÓVEIS)
# ==============================================================================


cat("\n--- EXERCÍCIO 2: BOSTON HOUSING ---\n")

# 1. Carregamento
dados002 <- read.csv("Rodolfo Takemoto - boston_housing.csv - Rodolfo Takemoto - boston_housing.csv.csv")

# 2. Limpeza Ajustada 

cols_boston <- c("crim", "zn", "indus", "nox", "rm", "age", "dis", "ptratio", "b", "lstat", "medv")

# Aplicando a limpeza em todas as colunas numéricas
dados002[cols_boston] <- lapply(dados002[cols_boston], limpar_numeros)

# 3. Gerando o Modelo

modelo_boston <- lm(medv ~ ., data = dados002)

# 4. Otimização Stepwise

tryCatch({
  step_boston <- step(modelo_boston, direction = "both", trace = 0)
  cat("Melhor fórmula selecionada (medv):\n")
  print(formula(step_boston))
  summary(step_boston)
}, error = function(e) {
  cat("Aviso: O Stepwise ainda encontrou instabilidade. Exibindo resumo do modelo completo:\n")
  summary(modelo_boston)
})

# ==============================================================================
# EXERCÍCIO 3: HEART DISEASE (SAÚDE - REGRESSÃO LOGÍSTICA)
# ==============================================================================
cat("\n--- EXERCÍCIO 3: HEART DISEASE ---\n")

# Carregamento do arquivo específico
dados003 <- read.csv("Rodolfo Takemoto - heart_disease_uci.csv - Rodolfo Takemoto - heart_disease_uci.csv.csv")

# Tratamento de dados médicos
cols_num_heart <- c("trestbps", "chol", "thalach", "oldpeak")
dados003[cols_num_heart] <- lapply(dados003[cols_num_heart], limpar_numeros)

# Modelo Logístico
modelo_log <- glm(target ~ ., data = dados003, family = binomial)

# Otimização de Threshold (ROC)
probabilidades <- predict(modelo_log, type = "response")
roc_obj <- roc(dados003$target, probabilidades, quiet = TRUE)

# Encontrando o ponto de corte ideal (Youden)
melhor_corte <- as.numeric(coords(roc_obj, "best", ret = "threshold"))
cat("Ponto de corte (Threshold) otimizado:", melhor_corte, "\n")

# Matriz de Confusão
pred_final <- ifelse(probabilidades > melhor_corte, 1, 0)
confusionMatrix(as.factor(pred_final), as.factor(dados003$target), positive = "1")

# Visualização Gráfica
plot(roc_obj, main="Curva ROC - Heart Disease UCI", col="blue", lwd=2)


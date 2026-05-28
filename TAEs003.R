# ==============================================================================
# Teoria do Aprendizado Estatístico
# Rodolfo Vinicius Cima Takemoto
# ==============================================================================

rm(list=ls())

# Preparação dos dados
dados001 <- mtcars
dados001$car <- rownames(dados001)
rownames(dados001) <- NULL

# 1. Definição dos modelos base
modelo_vazio <- lm(mpg ~ 1, data = dados001)
modelo_completo <- lm(mpg ~ wt + hp + disp + drat + qsec + cyl + vs + am + gear + carb, data = dados001)

# 2. Seleção Stepwise Forward
# CORREÇÃO: mudei 'modelo_vazios' para 'modelo_vazio'
step_forward <- step(modelo_vazio, 
                     scope = formula(modelo_completo), 
                     direction = "forward", 
                     trace = 0)

# 3. Seleção Stepwise Backward
step_backward <- step(modelo_completo, 
                      direction = "backward", 
                      trace = 0)

# 4. Seleção Stepwise Both (Ambos os sentidos)
step_both <- step(modelo_vazio, 
                  scope = formula(modelo_completo), 
                  direction = "both",
                  trace = 0) # Adicionei trace=0 para não poluir o console

# 5 Verificação

formula(step_forward)
formula(step_backward)
formula(step_both)

summary(step_forward)
summary(step_backward)
summary(step_both)



#Exercicio Autos


# --- Limpeza e Biblioteca ---
rm(list=ls())
library(ISLR)

# 1. Preparar os dados
dados001 <- ISLR::Auto

# Removemos a coluna 'name' pois é texto e não entra no cálculo
dados001 <- dados001[, -9] 


# 2. Criar o modelo de regressão isplacement

modelo001 <- lm(displacement ~ mpg + cylinders + horsepower + weight + acceleration, data = dados001)

# 3. Analisar os coeficientes
summary(modelo001)

# 4. Criar a função manual (Calculadora)
# Extraindo os Betas
b0 <- modelo001$coefficients[1]
b1 <- modelo001$coefficients[2]
b2 <- modelo001$coefficients[3]
b3 <- modelo001$coefficients[4]
b4 <- modelo001$coefficients[5]
b5 <- modelo001$coefficients[6]

calculadora_auto <- function(x1, x2, x3, x4, x5){
  y <- b0 + (b1*x1) + (b2*x2) + (b3*x3) + (b4*x4) + (b5*x5)
  return(y)
}

# 5. Testar e Comparar
pred_R <- predict(modelo001, newdata = dados001)
pred_manual <- calculadora_auto(dados001$mpg, dados001$cylinders, 
                                dados001$horsepower, dados001$weight, 
                                dados001$acceleration)

# Conferindo os resultados
head(data.frame(Predicao_R = pred_R, Manual = pred_manual))

step_forward <- step(modelo_vazio, 
                     scope = formula(modelo_completo), 
                     direction = "forward", 
                     trace = 0)

rm(list=ls())
library(ISLR)

# Preparação dos dados
dados_auto <- ISLR::Auto
dados_auto <- dados_auto[, -9] # Removemos a coluna 'name' (texto)

# 6. Definição dos modelos base
# Variável dependente: displacement
modelo_vazio_auto <- lm(displacement ~ 1, data = dados_auto)
modelo_completo_auto <- lm(displacement ~ ., data = dados_auto)

# 7. Seleção Stepwise Forward
step_forward_auto <- step(modelo_vazio_auto, 
                          scope = formula(modelo_completo_auto), 
                          direction = "forward", 
                          trace = 0)

# 8. Seleção Stepwise Backward
step_backward_auto <- step(modelo_completo_auto, 
                           direction = "backward", 
                           trace = 0)

# 9. Seleção Stepwise Both
step_both_auto <- step(modelo_vazio_auto, 
                       scope = formula(modelo_completo_auto), 
                       direction = "both", 
                       trace = 0)

# 10. Resultados Finais

print(formula(step_forward_auto))
print(formula(step_backward_auto))
print(formula(step_both_auto))

summary(step_forward_auto)
summary(step_backward_auto)
summary(step_both_auto)

#Exercicio Carseats

rm(list=ls()) 

# 1. Preparar os dados
dados002 <- ISLR::Carseats

# 2. Criar o modelo de regressão
# Variável dependente: Price
modelo002 <- lm(Price ~ Sales + CompPrice + Income + Advertising + Age, data = dados002)

# 3. Analisar os coeficientes
summary(modelo002)

# 4. Criar a função manual
beta0 <- modelo002$coefficients[1]
beta1 <- modelo002$coefficients[2]
beta2 <- modelo002$coefficients[3]
beta3 <- modelo002$coefficients[4]
beta4 <- modelo002$coefficients[5]
beta5 <- modelo002$coefficients[6]

calculadora_price <- function(sales, comp, inc, adv, age){
  y <- beta0 + (beta1*sales) + (beta2*comp) + (beta3*inc) + (beta4*adv) + (beta5*age)
  return(y)
}

# 5. Comparar os resultados
pred_R_price <- predict(modelo002, newdata = dados002)
pred_manual_price <- calculadora_price(dados002$Sales, dados002$CompPrice, 
                                       dados002$Income, dados002$Advertising, 
                                       dados002$Age)

# Verificando a tabela de erros
respostas_price <- data.frame(
  Real = dados002$Price,
  Predito = pred_manual_price,
  Erro = dados002$Price - pred_manual_price
)

head(respostas_price)

#limpeza

rm(list=ls()) 


library(ISLR)
dados_car <- ISLR::Carseats

# 5. Definição dos modelos base
# Variável dependente: Price
modelo_vazio_car <- lm(Price ~ 1, data = dados_car)
modelo_completo_car <- lm(Price ~ ., data = dados_car)

# 6. Seleção Stepwise Forward
step_forward_car <- step(modelo_vazio_car, 
                         scope = formula(modelo_completo_car), 
                         direction = "forward", 
                         trace = 0)

# 7. Seleção Stepwise Backward
step_backward_car <- step(modelo_completo_car, 
                          direction = "backward", 
                          trace = 0)

# 8. Seleção Stepwise Both
step_both_car <- step(modelo_vazio_car, 
                      scope = formula(modelo_completo_car), 
                      direction = "both", 
                      trace = 0)

# 9. Resultados Finais

print(formula(step_forward_car))
print(formula(step_backward_car))
print(formula(step_both_car))

summary(step_forward_car)
summary(step_backward_car)
summary(step_both_car)


# Exercicio Hitters


# --- PASSO 0: Limpeza e Preparação ---
rm(list=ls())
library(ISLR)

# 1. Carregar os dados
dados_hitters <- ISLR::Hitters

# 2. LIMPEZA ESSENCIAL: 
# O dataset Hitters tem NAs na coluna Salary. Precisamos remover para o modelo funcionar.
dados_limpos <- na.omit(dados_hitters)

# --- PASSO 1: Definição dos Modelos para o Stepwise ---

# Modelo Vazio (apenas a média)
modelo_vazio <- lm(Salary ~ 1, data = dados_limpos)

# Modelo Completo (todas as variáveis do dataset)
modelo_completo <- lm(Salary ~ ., data = dados_limpos)

# --- PASSO 2: Seleção Automática de Variáveis ---

# 1. Stepwise Forward
step_forward <- step(modelo_vazio, 
                     scope = formula(modelo_completo), 
                     direction = "forward", 
                     trace = 0)

# 2. Stepwise Backward
step_backward <- step(modelo_completo, 
                      direction = "backward", 
                      trace = 0)

# 3. Stepwise Both (O mais equilibrado)
step_both <- step(modelo_vazio, 
                  scope = formula(modelo_completo), 
                  direction = "both", 
                  trace = 0)

# --- PASSO 3: Comparação das Fórmulas ---
cat("--- Melhores Modelos Encontrados ---\n")
print(formula(step_forward))
print(formula(step_backward))
print(formula(step_both))

# --- PASSO 4: Calculadora Manual do Modelo 'Both' ---
# Vamos olhar o summary do modelo escolhido
summary(step_both)

# Extraindo os coeficientes para a sua função (usando os 5 principais)
# Nota: O Stepwise escolheu várias variáveis, vou pegar as primeiras do summary
betas <- coef(step_both)

# Criando a função de predição manual
calculadora_salary <- function(atbat, hits, walks, cruns, crbi, putouts){
  # Fórmula: Y = B0 + B1*X1 + B2*X2...
  y <- betas[1] + (betas["AtBat"]*atbat) + (betas["Hits"]*hits) + 
    (betas["Walks"]*walks) + (betas["CRuns"]*cruns) + 
    (betas["CRBI"]*crbi) + (betas["PutOuts"]*putouts)
  return(y)
}

# --- PASSO 5: Comparando Resultados ---
pred_R <- predict(step_both, newdata = dados_limpos)
pred_manual <- calculadora_salary(dados_limpos$AtBat, dados_limpos$Hits, 
                                  dados_limpos$Walks, dados_limpos$CRuns, 
                                  dados_limpos$CRBI, dados_limpos$PutOuts)

# Verificando se os resultados caminham juntos
head(data.frame(R_Predict = pred_R, Manual = pred_manual))



                       
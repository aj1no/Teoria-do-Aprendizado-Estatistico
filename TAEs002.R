# ==============================================================================
# Teoria do Aprendizado Estatístico
# Rodolfo Vinicius Cima Takemoto
# ==============================================================================

#Limpeza
rm(list=ls())

#bibliotecas
library(ISLR)

dados001<-ISLR::Auto
dados001
names(dados001)
str(dados001)

#criando um modelo de regrecao linear

modelodados001 <- lm(mpg ~ . - name - acceleration, data = dados001)
summary(modelodados001)


#predicao dos modelos


mpg_predicao <- predict(modelodados001,
                        newdata = dados001,
                        type = "response")

resposta <- data.frame(mpg_predicao = mpg_predicao,
                        mpg = dados001$mpg,
                        erro_quadrado = (dados001$mpg - mpg_predicao)^2)

resposta


#criando função

modelodados001$coefficients[0]
b0 <- modelodados001$coefficients[1]
b1 <- modelodados001$coefficients[2]
b2 <- modelodados001$coefficients[3]
b3 <- modelodados001$coefficients[4]
b4 <- modelodados001$coefficients[5]
b5 <- modelodados001$coefficients[6]

calculadoradepredicao <- function(x1, x2, x3, x4, x5){
 y <- b0 + b1*x1 + b2*x2 + b3*x3 + b4*x4 + b5*x5
return(y)
}

#predicao do modelo

predicao_manual <- calculadoradepredicao(x1 = dados001$cylinders,
                                        x2 = dados001$displacement,
                                        x3 = dados001$horsepower,
                                        x4 = dados001$weight,
                                        x5 = dados001$year)
predicao_manual== mpg_predicao

# --- Limpeza para o novo exercício ---
rm(list=ls()) 

# 1) Carregar e Preparar
library(ISLR)
dados_car <- Carseats

# 2) Criando o Modelo (Rodolfo Style)
# Selecionei 5 variáveis para sua função manual bater certinho
modelo_car <- lm(Sales ~ CompPrice + Income + Advertising + Price + Age, data = dados_car)
summary(modelo_car)

# 3) Predição do R
sales_pred_R <- predict(modelo_car, newdata = dados_car)

# 4) Criando Função Manual
# Extraindo os coeficientes (Betas)
c_b0 <- modelo_car$coefficients[1]
c_b1 <- modelo_car$coefficients[2]
c_b2 <- modelo_car$coefficients[3]
c_b3 <- modelo_car$coefficients[4]
c_b4 <- modelo_car$coefficients[5]
c_b5 <- modelo_car$coefficients[6]

calc_carseats <- function(x1, x2, x3, x4, x5){
  y <- c_b0 + c_b1*x1 + c_b2*x2 + c_b3*x3 + c_b4*x4 + c_b5*x5
  return(y)
}

# 5) Comparando os resultados
pred_manual_car <- calc_carseats(dados_car$CompPrice, 
                                 dados_car$Income, 
                                 dados_car$Advertising, 
                                 dados_car$Price, 
                                 dados_car$Age)

# Verificando se os 5 primeiros batem (pode haver dferença minúscula por arredondamento)
head(data.frame(Manual = pred_manual_car, R_Predict = sales_pred_R))


# --- Limpeza para o novo exercício ---
rm(list=ls()) 


# 1) Carregar e Preparar
library(ISLR2)
dados_cred <- Credit
dados_cred <- dados_cred[,-1] # Remove a coluna ID que é a primeira

# 2) Criando o Modelo
# Usando variáveis numéricas para manter a lógica da sua calculadora
modelo_cred <- lm(Balance ~ Income + Limit + Rating + Cards + Age, data = dados_cred)
summary(modelo_cred)

# 3) Predição do R
balance_pred_R <- predict(modelo_cred, newdata = dados_cred)

# 4) Criando Função Manual
cr_b0 <- modelo_cred$coefficients[1]
cr_b1 <- modelo_cred$coefficients[2]
cr_b2 <- modelo_cred$coefficients[3]
cr_b3 <- modelo_cred$coefficients[4]
cr_b4 <- modelo_cred$coefficients[5]
cr_b5 <- modelo_cred$coefficients[6]

calc_credit <- function(x1, x2, x3, x4, x5){
  y <- cr_b0 + cr_b1*x1 + cr_b2*x2 + cr_b3*x3 + cr_b4*x4 + cr_b5*x5
  return(y)
}

# 5) Comparando
pred_manual_cred <- calc_credit(dados_cred$Income, 
                                dados_cred$Limit, 
                                dados_cred$Rating, 
                                dados_cred$Cards, 
                                dados_cred$Age)

# Mostrando a tabela de erros (como você fez no primeiro código)
resposta_cred <- data.frame(
  Real = dados_cred$Balance,
  Predito = pred_manual_cred,
  Erro_Quadrado = (dados_cred$Balance - pred_manual_cred)^2
)
head(resposta_cred)

